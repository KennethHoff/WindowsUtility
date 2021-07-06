import chokidar from "chokidar";

const fs = require("fs-extra");

const year_regex = /(?:19|20)\d{2}/;

// const baseDir: string = "H:\\Videos\\OBS_Studio";

const baseDir: string = ".";

const replacedBaseDir = baseDir.replace("\\", "/");

const watcher = chokidar.watch(replacedBaseDir, {
	depth: 0,
	persistent: true,
	// persistent: false,
	// ignoreInitial: true,
});

watcher.on("add", async (fileName, _) => {
	if (fileName.includes(".bat")) {
		return;
	}

	console.log("New file added! " + '"' + fileName + '"');

	// const filename = filenameWithDirectory.replace(baseDir, "").substr(1);
	//
	// console.log("Filename without directory: ", filename);

	const fileNameSeparated = fileName.split(/[\s_]+/);

	// console.log("Separated file name: ", fileNameSeparated);
	const dateString = fileNameSeparated.find((str) => str.match(year_regex));

	// console.log("Date string", dateString);

	if (!dateString) {
		console.warn('"' + fileName + '" has no date!');

		return;
	}

	const dateStringSeparated = dateString.split(/[._-]+/);

	// console.log("dateStringSeparated:", dateStringSeparated);

	// return;
	const year = dateStringSeparated[0].trim();
	const month = dateStringSeparated[1].trim();
	const day = dateStringSeparated[2].trim();

	// console.log("Year:", year);
	// console.log("Month:", month);
	// console.log("Day:", day);

	const outputDir = baseDir + "\\" + year + "\\" + month;

	// console.log("Output directory: ", outputDir);

	await fs.ensureDir(outputDir);

	const sleepDurationAfterWatchTrigger = 500; // ms

	const finalPath = outputDir + "\\" + fileName;

	console.log("Final path: ", finalPath);
	console.log("Final filename: ", fileName);

	await sleep(sleepDurationAfterWatchTrigger);

	await fs.move(fileName, finalPath);

	console.log('Successfully moved "' + fileName + '"');
});

function sleep(ms: number) {
	return new Promise((resolve) => {
		setTimeout(resolve, ms);
	});
}
