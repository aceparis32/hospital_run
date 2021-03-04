global.pause = true;
global.viewWidth = camera_get_view_width(view_camera[0]);
global.viewHeight = camera_get_view_height(view_camera[0]);

global.keyRevert = ord("X");
global.keyEnter = vk_enter;
global.keyLeft = vk_left;
global.keyRight = vk_right;
global.keyUp = vk_up;
global.keyDown = vk_down;

createRoomText = "";
setPasswordText = "";
searchServerText = "";

deleteTimer = 0;

display_set_gui_size(global.viewWidth, global.viewHeight);

enum menuPage {
	main		= 0,
	audio		= 1,
	difficulty	= 2,
	graphics	= 3,
	controls	= 4,
	search		= 5,
	host		= 6,
	options		= 7,
	gameGuide	= 8,
	height		= 9
}

enum menuElementType {
	script_runner,
	page_transfer,
	slider,
	shift,
	toggle,
	input,
	textBox,
	room_transition,
}

// Create menu pages
dsMenuMain = CreateMenuPage(
	["START", menuElementType.script_runner, ChangeRoom],
	//["SETTINGS", menuElementType.page_transfer, menuPage.settings],
	["SEARCH", menuElementType.page_transfer, menuPage.search],
	["HOST", menuElementType.page_transfer, menuPage.host],
	["OPTIONS", menuElementType.page_transfer, menuPage.options],
	["GAME GUIDE", menuElementType.page_transfer, menuPage.gameGuide],
	["EXIT", menuElementType.script_runner, ExitGame]
);

//dsSettings = CreateMenuPage(
//	["AUDIO", menuElementType.page_transfer, menuPage.audio],
//	["DIFFICULTY", menuElementType.page_transfer, menuPage.difficulty],
//	["GRAPHICS", menuElementType.page_transfer, menuPage.graphics],
//	["CONTROLS", menuElementType.page_transfer, menuPage.controls],
//	["BACK", menuElementType.page_transfer, menuPage.main]
//);

dsMenuAudio = CreateMenuPage(
	["MASTER", menuElementType.slider, ChangeVolume, 1, [0,1]],
	["SOUNDS", menuElementType.slider, ChangeVolume, 1, [0,1]],
	["MUSIC", menuElementType.slider, ChangeVolume, 1, [0,1]],
	["BACK", menuElementType.page_transfer, menuPage.options]
);

dsMenuDifficulty = CreateMenuPage(
	["ENEMIES", menuElementType.shift, ChangeDifficulty, 0, ["HARMLESS", "NORMAL", "TERRIBLE"]],
	["ALLIES", menuElementType.shift, ChangeDifficulty, 0, ["DIM-WITTED", "NORMAL", "HELPFUL"]],
	["BACK", menuElementType.page_transfer, menuPage.options]
);

dsMenuGraphics = CreateMenuPage(
	["RESOLUTION", menuElementType.shift, ChangeResolution, 0, ["1366 x 768", "1152 x 648", "768 x 432", "384 x 216"]],
	["FULLSCREEN", menuElementType.toggle, ChangeWindowMode, 1, ["FULLSCREEN", "WINDOWED"]],
	["BACK", menuElementType.page_transfer, menuPage.options]	
);

dsMenuControls = CreateMenuPage(
	["UP", menuElementType.input, "keyUp", vk_up],
	["LEFT", menuElementType.input, "keyLeft", vk_left],
	["RIGHT", menuElementType.input, "keyRight", vk_right],
	["DOWN", menuElementType.input, "keyDown", vk_down],
	["BACK", menuElementType.page_transfer, menuPage.options]	
);

dsMenuSearch = CreateMenuPage(
	["SERVER NAME", menuElementType.textBox, searchServerText, 20],
	["BACK", menuElementType.page_transfer, menuPage.main]	
);

dsMenuHost = CreateMenuPage(
	["CREATE ROOM", menuElementType.textBox, createRoomText, 20],
	["SET PASSWORD", menuElementType.textBox, setPasswordText, 20],
	["BACK", menuElementType.page_transfer, menuPage.main]
);

dsMenuOptions = CreateMenuPage(
	["AUDIO", menuElementType.page_transfer, menuPage.audio],
	["DIFFICULTY", menuElementType.page_transfer, menuPage.difficulty],
	["GRAPHICS", menuElementType.page_transfer, menuPage.graphics],
	["CONTROLS", menuElementType.page_transfer, menuPage.controls],
	["BACK", menuElementType.page_transfer, menuPage.main]
);

dsMenuGameGuide = CreateMenuPage(
	["BACK", menuElementType.page_transfer, menuPage.main]
);

page = 0;
menuPages = [dsMenuMain, dsMenuAudio, dsMenuDifficulty, dsMenuGraphics, dsMenuControls, dsMenuSearch, dsMenuHost, dsMenuOptions, dsMenuGameGuide];

var i = 0;
var arrayLen = array_length_1d(menuPages);
repeat (arrayLen) {
	menuOption[i] = 0;
	i++;
}

inputting = false;

audio_group_load(audiogroup_music);
audio_group_load(audiogroup_soundeffects);