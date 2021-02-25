// Menu option change
var menuMove = keyboard_check_pressed(vk_down) - keyboard_check_pressed(vk_up);

menuSelected += menuMove;

if (menuSelected >= menuOptions) {
	menuSelected = 0;	
}

if (menuSelected < 0) {
	menuSelected = menuOptions - 1	
}

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
		case op.resume:
			instance_activate_all();
			global.pause = false;
			
			instance_destroy();
			break;
		case op.save:
			break;
		case op.quit:
			room_goto(MainMenuRoom);
			break;
	}
}