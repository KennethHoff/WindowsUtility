"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __generator = (this && this.__generator) || function (thisArg, body) {
    var _ = { label: 0, sent: function() { if (t[0] & 1) throw t[1]; return t[1]; }, trys: [], ops: [] }, f, y, t, g;
    return g = { next: verb(0), "throw": verb(1), "return": verb(2) }, typeof Symbol === "function" && (g[Symbol.iterator] = function() { return this; }), g;
    function verb(n) { return function (v) { return step([n, v]); }; }
    function step(op) {
        if (f) throw new TypeError("Generator is already executing.");
        while (_) try {
            if (f = 1, y && (t = op[0] & 2 ? y["return"] : op[0] ? y["throw"] || ((t = y["return"]) && t.call(y), 0) : y.next) && !(t = t.call(y, op[1])).done) return t;
            if (y = 0, t) op = [op[0] & 2, t.value];
            switch (op[0]) {
                case 0: case 1: t = op; break;
                case 4: _.label++; return { value: op[1], done: false };
                case 5: _.label++; y = op[1]; op = [0]; continue;
                case 7: op = _.ops.pop(); _.trys.pop(); continue;
                default:
                    if (!(t = _.trys, t = t.length > 0 && t[t.length - 1]) && (op[0] === 6 || op[0] === 2)) { _ = 0; continue; }
                    if (op[0] === 3 && (!t || (op[1] > t[0] && op[1] < t[3]))) { _.label = op[1]; break; }
                    if (op[0] === 6 && _.label < t[1]) { _.label = t[1]; t = op; break; }
                    if (t && _.label < t[2]) { _.label = t[2]; _.ops.push(op); break; }
                    if (t[2]) _.ops.pop();
                    _.trys.pop(); continue;
            }
            op = body.call(thisArg, _);
        } catch (e) { op = [6, e]; y = 0; } finally { f = t = 0; }
        if (op[0] & 5) throw op[1]; return { value: op[0] ? op[1] : void 0, done: true };
    }
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
var chokidar_1 = __importDefault(require("chokidar"));
var fs = require("fs-extra");
var year_regex = /(?:19|20)\d{2}/;
// const baseDir: string = "H:\\Videos\\OBS_Studio";
var baseDir = ".";
var replacedBaseDir = baseDir.replace("\\", "/");
var watcher = chokidar_1.default.watch(replacedBaseDir, {
    depth: 0,
    persistent: true,
    // persistent: false,
    // ignoreInitial: true,
});
watcher.on("add", function (fileName, _) { return __awaiter(void 0, void 0, void 0, function () {
    var fileNameSeparated, dateString, dateStringSeparated, year, month, day, outputDir, sleepDurationAfterWatchTrigger, finalPath;
    return __generator(this, function (_a) {
        switch (_a.label) {
            case 0:
                if (fileName.includes(".bat")) {
                    return [2 /*return*/];
                }
                console.log("New file added! " + '"' + fileName + '"');
                fileNameSeparated = fileName.split(/[\s_]+/);
                dateString = fileNameSeparated.find(function (str) { return str.match(year_regex); });
                // console.log("Date string", dateString);
                if (!dateString) {
                    console.warn('"' + fileName + '" has no date!');
                    return [2 /*return*/];
                }
                dateStringSeparated = dateString.split(/[._-]+/);
                year = dateStringSeparated[0].trim();
                month = dateStringSeparated[1].trim();
                day = dateStringSeparated[2].trim();
                outputDir = baseDir + "\\" + year + "\\" + month;
                // console.log("Output directory: ", outputDir);
                return [4 /*yield*/, fs.ensureDir(outputDir)];
            case 1:
                // console.log("Output directory: ", outputDir);
                _a.sent();
                sleepDurationAfterWatchTrigger = 500;
                finalPath = outputDir + "\\" + fileName;
                console.log("Final path: ", finalPath);
                console.log("Final filename: ", fileName);
                return [4 /*yield*/, sleep(sleepDurationAfterWatchTrigger)];
            case 2:
                _a.sent();
                return [4 /*yield*/, fs.move(fileName, finalPath)];
            case 3:
                _a.sent();
                console.log('Successfully moved "' + fileName + '"');
                return [2 /*return*/];
        }
    });
}); });
function sleep(ms) {
    return new Promise(function (resolve) {
        setTimeout(resolve, ms);
    });
}
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiaW5kZXguanMiLCJzb3VyY2VSb290IjoiIiwic291cmNlcyI6WyJpbmRleC50cyJdLCJuYW1lcyI6W10sIm1hcHBpbmdzIjoiOzs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7OztBQUFBLHNEQUFnQztBQUVoQyxJQUFNLEVBQUUsR0FBRyxPQUFPLENBQUMsVUFBVSxDQUFDLENBQUM7QUFFL0IsSUFBTSxVQUFVLEdBQUcsZ0JBQWdCLENBQUM7QUFFcEMsb0RBQW9EO0FBRXBELElBQU0sT0FBTyxHQUFXLEdBQUcsQ0FBQztBQUU1QixJQUFNLGVBQWUsR0FBRyxPQUFPLENBQUMsT0FBTyxDQUFDLElBQUksRUFBRSxHQUFHLENBQUMsQ0FBQztBQUVuRCxJQUFNLE9BQU8sR0FBRyxrQkFBUSxDQUFDLEtBQUssQ0FBQyxlQUFlLEVBQUU7SUFDL0MsS0FBSyxFQUFFLENBQUM7SUFDUixVQUFVLEVBQUUsSUFBSTtJQUNoQixxQkFBcUI7SUFDckIsdUJBQXVCO0NBQ3ZCLENBQUMsQ0FBQztBQUVILE9BQU8sQ0FBQyxFQUFFLENBQUMsS0FBSyxFQUFFLFVBQU8sUUFBUSxFQUFFLENBQUM7Ozs7O2dCQUNuQyxJQUFJLFFBQVEsQ0FBQyxRQUFRLENBQUMsTUFBTSxDQUFDLEVBQUU7b0JBQzlCLHNCQUFPO2lCQUNQO2dCQUVELE9BQU8sQ0FBQyxHQUFHLENBQUMsa0JBQWtCLEdBQUcsR0FBRyxHQUFHLFFBQVEsR0FBRyxHQUFHLENBQUMsQ0FBQztnQkFNakQsaUJBQWlCLEdBQUcsUUFBUSxDQUFDLEtBQUssQ0FBQyxRQUFRLENBQUMsQ0FBQztnQkFHN0MsVUFBVSxHQUFHLGlCQUFpQixDQUFDLElBQUksQ0FBQyxVQUFDLEdBQUcsSUFBSyxPQUFBLEdBQUcsQ0FBQyxLQUFLLENBQUMsVUFBVSxDQUFDLEVBQXJCLENBQXFCLENBQUMsQ0FBQztnQkFFMUUsMENBQTBDO2dCQUUxQyxJQUFJLENBQUMsVUFBVSxFQUFFO29CQUNoQixPQUFPLENBQUMsSUFBSSxDQUFDLEdBQUcsR0FBRyxRQUFRLEdBQUcsZ0JBQWdCLENBQUMsQ0FBQztvQkFFaEQsc0JBQU87aUJBQ1A7Z0JBRUssbUJBQW1CLEdBQUcsVUFBVSxDQUFDLEtBQUssQ0FBQyxRQUFRLENBQUMsQ0FBQztnQkFLakQsSUFBSSxHQUFHLG1CQUFtQixDQUFDLENBQUMsQ0FBQyxDQUFDLElBQUksRUFBRSxDQUFDO2dCQUNyQyxLQUFLLEdBQUcsbUJBQW1CLENBQUMsQ0FBQyxDQUFDLENBQUMsSUFBSSxFQUFFLENBQUM7Z0JBQ3RDLEdBQUcsR0FBRyxtQkFBbUIsQ0FBQyxDQUFDLENBQUMsQ0FBQyxJQUFJLEVBQUUsQ0FBQztnQkFNcEMsU0FBUyxHQUFHLE9BQU8sR0FBRyxJQUFJLEdBQUcsSUFBSSxHQUFHLElBQUksR0FBRyxLQUFLLENBQUM7Z0JBRXZELGdEQUFnRDtnQkFFaEQscUJBQU0sRUFBRSxDQUFDLFNBQVMsQ0FBQyxTQUFTLENBQUMsRUFBQTs7Z0JBRjdCLGdEQUFnRDtnQkFFaEQsU0FBNkIsQ0FBQztnQkFFeEIsOEJBQThCLEdBQUcsR0FBRyxDQUFDO2dCQUVyQyxTQUFTLEdBQUcsU0FBUyxHQUFHLElBQUksR0FBRyxRQUFRLENBQUM7Z0JBRTlDLE9BQU8sQ0FBQyxHQUFHLENBQUMsY0FBYyxFQUFFLFNBQVMsQ0FBQyxDQUFDO2dCQUN2QyxPQUFPLENBQUMsR0FBRyxDQUFDLGtCQUFrQixFQUFFLFFBQVEsQ0FBQyxDQUFDO2dCQUUxQyxxQkFBTSxLQUFLLENBQUMsOEJBQThCLENBQUMsRUFBQTs7Z0JBQTNDLFNBQTJDLENBQUM7Z0JBRTVDLHFCQUFNLEVBQUUsQ0FBQyxJQUFJLENBQUMsUUFBUSxFQUFFLFNBQVMsQ0FBQyxFQUFBOztnQkFBbEMsU0FBa0MsQ0FBQztnQkFFbkMsT0FBTyxDQUFDLEdBQUcsQ0FBQyxzQkFBc0IsR0FBRyxRQUFRLEdBQUcsR0FBRyxDQUFDLENBQUM7Ozs7S0FDckQsQ0FBQyxDQUFDO0FBRUgsU0FBUyxLQUFLLENBQUMsRUFBVTtJQUN4QixPQUFPLElBQUksT0FBTyxDQUFDLFVBQUMsT0FBTztRQUMxQixVQUFVLENBQUMsT0FBTyxFQUFFLEVBQUUsQ0FBQyxDQUFDO0lBQ3pCLENBQUMsQ0FBQyxDQUFDO0FBQ0osQ0FBQyJ9