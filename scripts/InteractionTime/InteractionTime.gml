// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function InteractionTime(_interactedItem){
	switch (_interactedItem) {
		case 0:
			keyTimer -= 1;
			show_debug_message("Key Timer Left in seconds : " + string(keyTimer / room_speed));
			if (keyTimer <= 0) {
				keyTimer = 0;
				return true;
			}
		case 1:
			crowbarsTimer -= 1;
			show_debug_message("Crowbars Timer Left in seconds : " + string(crowbarsTimer / room_speed));
			if (crowbarsTimer <= 0) {
				crowbarsTimer = 0;
				return true;
			}
	}
}