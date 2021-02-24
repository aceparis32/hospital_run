var menuMove = keyboard_check_pressed(vk_down) - keyboard_check_pressed(vk_up);

menuSelected += menuMove;

if (menuSelected >= menuOptions) menuSelected = 0;
if (menuSelected < 0) menuSelected = menuOptions - 1;

// Mouse Input
menuX = 32;
menuY = 32;

var mouseX = device_mouse_x_to_gui(0);
var mouseY = device_mouse_y_to_gui(0);

var mouseOption = (mouseY - menuY) div 32;

if (mouseOption >= 0 && mouseOption < menuOptions) {
	menuSelected = mouseOption;	
}

// Select
if (keyboard_check_pressed(vk_enter) || mouse_check_button_pressed(mb_left)) {
	switch (menuSelected) {
		// Main menu
		case mp.enterRoom:
			room_goto(HospitalRoom);
			break;
		case mp.search:
			searchTextbox.textboxActive = !searchTextbox.textboxActive;
			break;
		case mp.host:

			break;
		case mp.options:

			break;		
		case mp.gameGuide:

			break;
		case mp.quit:
			game_end();
			break;
	}
}