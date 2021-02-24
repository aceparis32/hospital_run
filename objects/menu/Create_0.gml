global.pause = true;
global.viewWidth = camera_get_view_width(view_camera[0]);
global.viewHeight = camera_get_view_height(view_camera[0]);

global.keyRevert = ord("X");
global.keyEnter = vk_enter;
global.keyLeft = vk_left;
global.keyRight = vk_right;
global.keyUp = vk_up;
global.keyDown = vk_down;

display_set_gui_size(global.viewWidth, global.viewHeight);

enum menuPage {
	main		= 0,
	settings	= 1,
	audio		= 2,
	difficulty	= 3,
	graphics	= 4,
	controls	= 5,
	height		= 6
}

enum menuElementType {
	script_runner,
	page_transfer,
	slider,
	shift,
	toggle,
	input
}

// Create menu pages
dsMenuMain = CreateMenuPage(
	["RESUME", menuElementType.script_runner, ResumeGame],
	["SETTINGS", menuElementType.page_transfer, menuPage.settings],
	["EXIT", menuElementType.script_runner, ExitGame]
);

dsSettings = CreateMenuPage(
	["AUDIO", menuElementType.page_transfer, menuPage.audio],
	["DIFFICULTY", menuElementType.page_transfer, menuPage.difficulty],
	["GRAPHICS", menuElementType.page_transfer, menuPage.graphics],
	["CONTROLS", menuElementType.page_transfer, menuPage.controls],
	["BACK", menuElementType.page_transfer, menuPage.main]
);

dsMenuAudio = CreateMenuPage(
	["MASTER", menuElementType.slider, ChangeVolume, 1, [0,1]],
	["SOUNDS", menuElementType.slider, ChangeVolume, 1, [0,1]],
	["MUSIC", menuElementType.slider, ChangeVolume, 1, [0,1]],
	["BACK", menuElementType.page_transfer, menuPage.settings]
);

dsMenuDifficulty = CreateMenuPage(
	["ENEMIES", menuElementType.shift, ChangeDifficulty, 0, ["HARMLESS", "NORMAL", "TERRIBLE"]],
	["ALLIES", menuElementType.shift, ChangeDifficulty, 0, ["DIM-WITTED", "NORMAL", "HELPFUL"]],
	["BACK", menuElementType.page_transfer, menuPage.settings]
);

dsMenuGraphics = CreateMenuPage(
	["RESOLUTION", menuElementType.shift, ChangeResolution, 0, ["384 x 216", "768 x 432", "1152 x 648", "1366 x 768"]],
	["WINDOW MODE", menuElementType.toggle, ChangeWindowMode, 1, ["FULLSCREEN", "WINDOWED"]],
	["BACK", menuElementType.page_transfer, menuPage.settings]	
);

dsMenuControls = CreateMenuPage(
	["UP", menuElementType.input, "keyUp", vk_up],
	["LEFT", menuElementType.input, "keyLeft", vk_left],
	["RIGHT", menuElementType.input, "keyRight", vk_right],
	["DOWN", menuElementType.input, "keyDown", vk_down],
	["BACK", menuElementType.page_transfer, menuPage.settings]	
);

page = 0;
menuPages = [dsMenuMain, dsSettings, dsMenuAudio, dsMenuDifficulty, dsMenuGraphics, dsMenuControls];

var i = 0;
var arrayLen = array_length_1d(menuPages);
repeat (arrayLen) {
	menuOption[i] = 0;
	i++;
}

inputting = false;

audio_group_load(audiogroup_music);
audio_group_load(audiogroup_soundeffects);