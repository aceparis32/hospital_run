/// @description Insert description here
// You can write your code in this editor
var surf = surface_create(rectWidth, rectHeight);
surface_set_target(surf);

if(showMap) {
	draw_sprite(sMap, 0, 0, 0);
	draw_set_font(fTextMap);
	draw_text_ext(rectWidth * 0.4, rectHeight * 0.1,"Map Example", 3, 500);
}

// Draw surface
surface_reset_target();

draw_surface(surf,x,y);

surface_free(surf);