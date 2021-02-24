/// @description Handle Key Press Input
if (!textboxActive) exit;

if (keyboard_check(vk_anykey) && string_length(text) < 20) {
	text = text + string(keyboard_string);
	keyboard_string = "";
}

if (keyboard_check(vk_backspace) && !keyboard_check_pressed(vk_backspace) && deleteTimer = 2) {
	text = string_delete(text, string_length(text), 1);
	deleteTimer = 0;
	keyboard_string = "";
}

if (keyboard_check_pressed(vk_backspace)) {
	text = string_delete(text, string_length(text), 1);
	keyboard_string = "";
	deleteTimer = -4;
}

// Handle timer update
if (deleteTimer != 2) {
	deleteTimer++;	
}
