if (!global.pause) exit;

inputUpP = keyboard_check_pressed(global.keyUp);
inputDownP = keyboard_check_pressed(global.keyDown);
inputEnterP = keyboard_check_pressed(global.keyEnter);

var dsGrid = menuPages[page];
var dsHeight = ds_grid_height(dsGrid);

var oChange = inputDownP - inputUpP;

if (inputting){
	switch (dsGrid[# 1, menuOption[page]]) {
		case menuElementType.shift:
			var hInput = keyboard_check_pressed(global.keyRight) - keyboard_check_pressed(global.keyLeft);
			if (hInput != 0){
				dsGrid[# 3, menuOption[page]] += hInput;
				dsGrid[# 3, menuOption[page]] = clamp(dsGrid[# 3, menuOption[page]], 0, array_length_1d(dsGrid[# 4, menuOption[page]]) - 1);
			}
			break;
		case menuElementType.slider:
			switch (menuOption[page]) {
				case 0:
					if (!audio_is_playing(mas_test)){
						audio_play_sound(mas_test, 1, false);
					}
					break;
				case 1:
					if (!audio_is_playing(snd_test)){
						audio_play_sound(snd_test, 1, false);
					}
					break;
				case 2:
					if (!audio_is_playing(msc_test)){
						audio_play_sound(msc_test, 1, false);
					}	
					break;
			}
		
			var hInput = keyboard_check(global.keyRight) - keyboard_check(global.keyLeft);
			if (hInput != 0){
				dsGrid[# 3, menuOption[page]] += hInput * 0.01;
				dsGrid[# 3, menuOption[page]] = clamp(dsGrid[# 3, menuOption[page]], 0, 1);
				script_execute(dsGrid[# 2, menuOption[page]], dsGrid[# 3, menuOption[page]]);
			}
			break;
		case menuElementType.toggle:
			var hInput = keyboard_check_pressed(global.keyRight) - keyboard_check_pressed(global.keyLeft);
			if (hInput != 0){
				dsGrid[# 3, menuOption[page]] += hInput;
				dsGrid[# 3, menuOption[page]] = clamp(dsGrid[# 3, menuOption[page]], 0, 1);
			}
			break;
		case menuElementType.input:
			var kk = keyboard_lastkey;
			if (kk != vk_enter) {
				dsGrid[# 3, menuOption[page]] = kk;
				variable_global_set(dsGrid[# 2, menuOption[page]], kk);
			}
			break;
		case menuElementType.textBox:
			if (keyboard_check(vk_anykey) 
				&& string_length(dsGrid[# 2, menuOption[page]]) < dsGrid[# 3, menuOption[page]]) {
					dsGrid[# 2, menuOption[page]] = dsGrid[# 2, menuOption[page]] + string(keyboard_string);
					keyboard_string = "";
			}
			
			if (keyboard_check(vk_backspace) && !keyboard_check_pressed(vk_backspace) && deleteTimer = 2) {
				dsGrid[# 2, menuOption[page]] = string_delete(dsGrid[# 2, menuOption[page]], string_length(dsGrid[# 2, menuOption[page]]), 1);
				deleteTimer = 0;
				keyboard_string = "";
			}
			
			if (keyboard_check_pressed(vk_backspace)) {
				dsGrid[# 2, menuOption[page]] = string_delete(dsGrid[# 2, menuOption[page]], string_length(dsGrid[# 2, menuOption[page]]), 1);
				keyboard_string = "";
				deleteTimer = -4;
			}
			
			// Handle timer update
			if (deleteTimer != 2) {
				deleteTimer++;	
			}
			
			break;
	}
}else{
	if (oChange != 0) {
		menuOption[page] += oChange;
		if (menuOption[page] > dsHeight - 1) {
			menuOption[page] = 0;	
		}
	
		if (menuOption[page] < 0) {
			menuOption[page] = dsHeight - 1;	
		}
	}	
}

if (inputEnterP) {
	switch (dsGrid[# 1, menuOption[page]]) {
		case menuElementType.script_runner:
			script_execute(dsGrid[# 2, menuOption[page]]);
			break;
		case menuElementType.page_transfer:
			page = dsGrid[# 2, menuOption[page]];
			break;
		case menuElementType.shift:
		case menuElementType.slider:
		case menuElementType.toggle:
			if (inputting) {
				script_execute(dsGrid[# 2, menuOption[page]], dsGrid[# 3, menuOption[page]]);
			}
		case menuElementType.input:
			inputting = !inputting;
			break;
		case menuElementType.textBox:
			inputting = !inputting;
			break;
	}
}