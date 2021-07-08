"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.calculateSortingOption = exports.listeningForAdd = void 0;
const fs_extra_1 = __importDefault(require("fs-extra"));
const year_regex = /(?:19|20)\d{2}/;
async function listeningForAdd(fileName, baseDir, sortingOptions = "YYYY/MM") {
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
    let outputDir;
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
    await fs_extra_1.default.ensureDir(outputDir);
    const sleepDurationAfterWatchTrigger = 500; // ms
    const finalPath = outputDir + "\\" + fileName;
    console.log("Final path: ", finalPath);
    console.log("Final filename: ", fileName);
    await sleep(sleepDurationAfterWatchTrigger);
    await fs_extra_1.default.move(fileName, finalPath);
    console.log('Successfully moved "' + fileName + '"');
}
exports.listeningForAdd = listeningForAdd;
function sleep(ms) {
    return new Promise((resolve) => {
        setTimeout(resolve, ms);
    });
}
function calculateSortingOption(input) {
    switch (input) {
        case "YYYY/MM":
        case "YYYY-MM":
            return input;
        default:
            console.warn('Invalid Sorting Option. Using default value of "YYYY/MM"');
            return "YYYY/MM";
    }
}
exports.calculateSortingOption = calculateSortingOption;
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoibGlzdGVuaW5nRm9yQWRkLmpzIiwic291cmNlUm9vdCI6IiIsInNvdXJjZXMiOlsibGlzdGVuaW5nRm9yQWRkLnRzIl0sIm5hbWVzIjpbXSwibWFwcGluZ3MiOiI7Ozs7OztBQUFBLHdEQUEwQjtBQUUxQixNQUFNLFVBQVUsR0FBRyxnQkFBZ0IsQ0FBQztBQUk3QixLQUFLLFVBQVUsZUFBZSxDQUNwQyxRQUFnQixFQUNoQixPQUFlLEVBQ2YsaUJBQWlDLFNBQVM7SUFFMUMsSUFBSSxRQUFRLENBQUMsUUFBUSxDQUFDLE1BQU0sQ0FBQyxFQUFFO1FBQzlCLE9BQU87S0FDUDtJQUVELE9BQU8sQ0FBQyxHQUFHLENBQUMsa0JBQWtCLEdBQUcsR0FBRyxHQUFHLFFBQVEsR0FBRyxHQUFHLENBQUMsQ0FBQztJQUV2RCxNQUFNLGlCQUFpQixHQUFHLFFBQVEsQ0FBQyxLQUFLLENBQUMsUUFBUSxDQUFDLENBQUM7SUFFbkQsTUFBTSxVQUFVLEdBQUcsaUJBQWlCLENBQUMsSUFBSSxDQUFDLENBQUMsR0FBRyxFQUFFLEVBQUUsQ0FBQyxHQUFHLENBQUMsS0FBSyxDQUFDLFVBQVUsQ0FBQyxDQUFDLENBQUM7SUFFMUUsSUFBSSxDQUFDLFVBQVUsRUFBRTtRQUNoQixPQUFPLENBQUMsSUFBSSxDQUFDLEdBQUcsR0FBRyxRQUFRLEdBQUcsZ0JBQWdCLENBQUMsQ0FBQztRQUVoRCxPQUFPO0tBQ1A7SUFFRCxNQUFNLG1CQUFtQixHQUFHLFVBQVUsQ0FBQyxLQUFLLENBQUMsUUFBUSxDQUFDLENBQUM7SUFFdkQsTUFBTSxJQUFJLEdBQUcsbUJBQW1CLENBQUMsQ0FBQyxDQUFDLENBQUMsSUFBSSxFQUFFLENBQUM7SUFDM0MsTUFBTSxLQUFLLEdBQUcsbUJBQW1CLENBQUMsQ0FBQyxDQUFDLENBQUMsSUFBSSxFQUFFLENBQUM7SUFDNUMsTUFBTSxHQUFHLEdBQUcsbUJBQW1CLENBQUMsQ0FBQyxDQUFDLENBQUMsSUFBSSxFQUFFLENBQUM7SUFFMUMsT0FBTyxDQUFDLEdBQUcsQ0FBQyxPQUFPLEVBQUUsSUFBSSxDQUFDLENBQUM7SUFDM0IsT0FBTyxDQUFDLEdBQUcsQ0FBQyxRQUFRLEVBQUUsS0FBSyxDQUFDLENBQUM7SUFDN0IsT0FBTyxDQUFDLEdBQUcsQ0FBQyxNQUFNLEVBQUUsR0FBRyxDQUFDLENBQUM7SUFFekIsSUFBSSxTQUFpQixDQUFDO0lBRXRCLFFBQVEsY0FBYyxFQUFFO1FBQ3ZCLEtBQUssU0FBUztZQUNiLFNBQVMsR0FBRyxPQUFPLEdBQUcsSUFBSSxHQUFHLElBQUksR0FBRyxJQUFJLEdBQUcsS0FBSyxDQUFDO1lBQ2pELE1BQU07UUFDUCxLQUFLLFNBQVM7WUFDYixTQUFTLEdBQUcsT0FBTyxHQUFHLElBQUksR0FBRyxJQUFJLEdBQUcsR0FBRyxHQUFHLEtBQUssQ0FBQztZQUNoRCxNQUFNO0tBQ1A7SUFFRCxPQUFPLENBQUMsR0FBRyxDQUFDLG9CQUFvQixFQUFFLFNBQVMsQ0FBQyxDQUFDO0lBRTdDLFVBQVU7SUFFVixNQUFNLGtCQUFFLENBQUMsU0FBUyxDQUFDLFNBQVMsQ0FBQyxDQUFDO0lBRTlCLE1BQU0sOEJBQThCLEdBQUcsR0FBRyxDQUFDLENBQUMsS0FBSztJQUVqRCxNQUFNLFNBQVMsR0FBRyxTQUFTLEdBQUcsSUFBSSxHQUFHLFFBQVEsQ0FBQztJQUU5QyxPQUFPLENBQUMsR0FBRyxDQUFDLGNBQWMsRUFBRSxTQUFTLENBQUMsQ0FBQztJQUN2QyxPQUFPLENBQUMsR0FBRyxDQUFDLGtCQUFrQixFQUFFLFFBQVEsQ0FBQyxDQUFDO0lBRTFDLE1BQU0sS0FBSyxDQUFDLDhCQUE4QixDQUFDLENBQUM7SUFFNUMsTUFBTSxrQkFBRSxDQUFDLElBQUksQ0FBQyxRQUFRLEVBQUUsU0FBUyxDQUFDLENBQUM7SUFFbkMsT0FBTyxDQUFDLEdBQUcsQ0FBQyxzQkFBc0IsR0FBRyxRQUFRLEdBQUcsR0FBRyxDQUFDLENBQUM7QUFDdEQsQ0FBQztBQTVERCwwQ0E0REM7QUFFRCxTQUFTLEtBQUssQ0FBQyxFQUFVO0lBQ3hCLE9BQU8sSUFBSSxPQUFPLENBQUMsQ0FBQyxPQUFPLEVBQUUsRUFBRTtRQUM5QixVQUFVLENBQUMsT0FBTyxFQUFFLEVBQUUsQ0FBQyxDQUFDO0lBQ3pCLENBQUMsQ0FBQyxDQUFDO0FBQ0osQ0FBQztBQUVELFNBQWdCLHNCQUFzQixDQUFDLEtBQWE7SUFDbkQsUUFBUSxLQUF1QixFQUFFO1FBQ2hDLEtBQUssU0FBUyxDQUFDO1FBQ2YsS0FBSyxTQUFTO1lBQ2IsT0FBTyxLQUF1QixDQUFDO1FBQ2hDO1lBQ0MsT0FBTyxDQUFDLElBQUksQ0FBQywwREFBMEQsQ0FBQyxDQUFDO1lBQ3pFLE9BQU8sU0FBUyxDQUFDO0tBQ2xCO0FBQ0YsQ0FBQztBQVRELHdEQVNDIn0=