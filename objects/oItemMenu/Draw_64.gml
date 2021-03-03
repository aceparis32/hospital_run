/// @description Insert description here
// You can write your code in this editor
var surf = surface_create(rectWidth, rectHeight);
surface_set_target(surf);

// BG
//draw_clear(backColor);

// Items
var border = 2;

var xx = cellSize;

// Draw inventory box
draw_sprite(sInventoryBox, 0, xx + border, border);
draw_sprite(sInventoryBox, 0, (xx * 2) + border, border);

// Item Selected BG
switch(oPlayer.selectedInventory) {
	case selectedItem.firstItem:
		var xx = cellSize;

		// Rectangle
		draw_set_color(c_white);
		draw_set_alpha(0.3);
		draw_rectangle(xx + border, border, xx + cellSize - border * 2, cellSize - border*2, false);
		draw_set_alpha(1);
		draw_text_color(xx + 10, 5, "1", c_white, c_white, c_white, c_white, 1);
		break;
	case selectedItem.secondItem:
		var xx = 2 * cellSize;

		// Rectangle
		draw_set_color(c_white);
		draw_set_alpha(0.3);
		draw_rectangle(xx + border, border, xx + cellSize - border * 2, cellSize - border*2, false);
		draw_set_alpha(1);
		draw_text_color(xx + 10, 5, "2", c_white, c_white, c_white, c_white, 1);
		break;
	default:
		break;
}

if (oPlayer.firstInventory != undefined) {
	var xx = cellSize;
	
	// Rectangle
	//draw_set_alpha(0.8);
	//draw_rectangle(xx + border, border, xx + cellSize - border * 2, cellSize - border*2, false);
	//draw_set_alpha(1);
		
	// item
	draw_sprite(oPlayer.firstInventory.sprite, 0, xx + cellSize / 2, cellSize);
}

if (oPlayer.secondInventory != undefined) {
	var xx = 2 * cellSize;
	
	// Rectangle
	//draw_set_alpha(0.8);
	//draw_rectangle(xx + border, border, xx + cellSize - border * 2, cellSize - border*2, false);
	//draw_set_alpha(1);
		
	// item
	draw_sprite(oPlayer.secondInventory.sprite, 0, xx + cellSize / 2, cellSize);	
}

//for (var i = 0; i < ds_list_size(oPlayer.inventory); i++){
//	var arr = oPlayer.inventory[| i];
		
//	// cell position
//	var xx = i * cellSize;
	
//	// Rectangle
//	draw_set_alpha(0.8);
//	draw_rectangle(xx + border, border, xx + cellSize - border * 2, cellSize - border*2, false);
//	draw_set_alpha(1);
		
//	// item
//	draw_sprite(arr.sprite, 0, xx + cellSize / 2, cellSize);
	
//	// Draw item name
//	//draw_text(cellSize, cellSize/2, arr.name);
//}

// Draw surface
surface_reset_target();

draw_surface(surf,x,y);

surface_free(surf);