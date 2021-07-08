import chokidar from "chokidar";

import { calculateSortingOption, listeningForAdd } from "./listeningForAdd.js";

const sortingOption = calculateSortingOption(process.argv[2]);

const baseDir = ".";

const replacedBaseDir = baseDir.replace("\\", "/");

const watcher = chokidar.watch(replacedBaseDir, {
	depth: 0,
	// persistent: true,
	persistent: false,
	// ignoreInitial: true,
});

watcher.on("add", (event) => listeningForAdd(event, baseDir, sortingOption));
