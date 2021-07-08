import fs from "fs-extra";

const year_regex = /(?:19|20)\d{2}/;

type SortingOptions = "YYYY/MM" | "YYYY-MM";

export async function listeningForAdd(
	fileName: string,
	baseDir: string,
	sortingOptions: SortingOptions = "YYYY/MM"
): Promise<void> {
	if (fileName.includes(".bat")) {
		return;
	}

	console.log("New file added! " + '"' + fileName + '"');

	const fileNameSeparated = fileName.split(/[\s_]+/);

	const dateString = fileNameSeparated.find((str) => str.match(year_regex));

	if (!dateString) {
		console.warn('"' + fileName + '" has no date!');

		return;
	}

	const dateStringSeparated = dateString.split(/[._-]+/);

	const year = dateStringSeparated[0].trim();
	const month = dateStringSeparated[1].trim();
	const day = dateStringSeparated[2].trim();

	console.log("Year:", year);
	console.log("Month:", month);
	console.log("Day:", day);

	let outputDir: string;

	switch (sortingOptions) {
		case "YYYY/MM":
			outputDir = baseDir + "\\" + year + "\\" + month;
			break;
		case "YYYY-MM":
			outputDir = baseDir + "\\" + year + "-" + month;
			break;
	}

	console.log("Output directory: ", outputDir);

	// return;

	await fs.ensureDir(outputDir);

	const sleepDurationAfterWatchTrigger = 500; // ms

	const finalPath = outputDir + "\\" + fileName;

	console.log("Final path: ", finalPath);
	console.log("Final filename: ", fileName);

	await sleep(sleepDurationAfterWatchTrigger);

	await fs.move(fileName, finalPath);

	console.log('Successfully moved "' + fileName + '"');
}

function sleep(ms: number) {
	return new Promise((resolve) => {
		setTimeout(resolve, ms);
	});
}

export function calculateSortingOption(input: string): SortingOptions {
	switch (input as SortingOptions) {
		case "YYYY/MM":
		case "YYYY-MM":
			return input as SortingOptions;
		default:
			console.warn('Invalid Sorting Option. Using default value of "YYYY/MM"');
			return "YYYY/MM";
	}
}
