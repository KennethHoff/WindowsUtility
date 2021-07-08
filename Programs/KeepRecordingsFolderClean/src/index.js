"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const chokidar_1 = __importDefault(require("chokidar"));
const listeningForAdd_js_1 = require("./listeningForAdd.js");
const sortingOption = listeningForAdd_js_1.calculateSortingOption(process.argv[2]);
const baseDir = ".";
const replacedBaseDir = baseDir.replace("\\", "/");
const watcher = chokidar_1.default.watch(replacedBaseDir, {
    depth: 0,
    // persistent: true,
    persistent: false,
    // ignoreInitial: true,
});
watcher.on("add", (event) => listeningForAdd_js_1.listeningForAdd(event, baseDir, sortingOption));
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiaW5kZXguanMiLCJzb3VyY2VSb290IjoiIiwic291cmNlcyI6WyJpbmRleC50cyJdLCJuYW1lcyI6W10sIm1hcHBpbmdzIjoiOzs7OztBQUFBLHdEQUFnQztBQUVoQyw2REFBK0U7QUFFL0UsTUFBTSxhQUFhLEdBQUcsMkNBQXNCLENBQUMsT0FBTyxDQUFDLElBQUksQ0FBQyxDQUFDLENBQUMsQ0FBQyxDQUFDO0FBRTlELE1BQU0sT0FBTyxHQUFHLEdBQUcsQ0FBQztBQUVwQixNQUFNLGVBQWUsR0FBRyxPQUFPLENBQUMsT0FBTyxDQUFDLElBQUksRUFBRSxHQUFHLENBQUMsQ0FBQztBQUVuRCxNQUFNLE9BQU8sR0FBRyxrQkFBUSxDQUFDLEtBQUssQ0FBQyxlQUFlLEVBQUU7SUFDL0MsS0FBSyxFQUFFLENBQUM7SUFDUixvQkFBb0I7SUFDcEIsVUFBVSxFQUFFLEtBQUs7SUFDakIsdUJBQXVCO0NBQ3ZCLENBQUMsQ0FBQztBQUVILE9BQU8sQ0FBQyxFQUFFLENBQUMsS0FBSyxFQUFFLENBQUMsS0FBSyxFQUFFLEVBQUUsQ0FBQyxvQ0FBZSxDQUFDLEtBQUssRUFBRSxPQUFPLEVBQUUsYUFBYSxDQUFDLENBQUMsQ0FBQyJ9