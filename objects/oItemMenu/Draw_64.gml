/// @description Insert description here
// You can write your code in this editor
var surf = surface_create(rectWidth, rectHeight);
surface_set_target(surf);

// BG
draw_clear(backColor);

// Items
var border = 2;
for (var i = 0; i < ds_list_size(oPlayer.inventory); i++){
	var arr = oPlayer.inventory[| i];
		
	// cell position
	var xx = i * cellSize;
	
	// Rectangle
	draw_set_alpha(0.2);
	draw_rectangle(xx + border, border, xx + cellSize - border * 2, cellSize - border*2, false);
	draw_set_alpha(1);
		
	// item
	draw_sprite(arr.sprite, 0, xx + cellSize / 2, cellSize);
	
	// Draw item name
	//draw_text(cellSize, cellSize/2, arr.name);
}

// Draw surface
surface_reset_target();

draw_surface(surf,x,y);

surface_free(surf);