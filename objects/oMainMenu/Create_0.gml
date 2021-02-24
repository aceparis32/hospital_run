enum mp {
	enterRoom,
	search,
	host,
	options,
	gameGuide,
	quit
}

menuText[mp.enterRoom] = "Enter Room";
menuText[mp.search] = "Search";
menuText[mp.host] = "Host";
menuText[mp.options] = "Options";
menuText[mp.gameGuide] = "Game Guide";
menuText[mp.quit] = "Quit";

menuSelected = 0;
menuOptions = array_length_1d(menuText);

// Textbox
searchTextbox = oTextBox;

//// Resolution
//width = 480;
//height = 270;
//scale = 2;

//window_set_size(width * scale, height * scale);
//surface_resize(application_surface, width * scale, height * scale);
//display_set_gui_size(width, height);

//room_width = width;
//room_height = height;