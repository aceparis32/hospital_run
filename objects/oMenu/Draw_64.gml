if (!global.pause) exit;
var gWidth = global.viewWidth;
var gHeight = global.viewHeight;

var dsGrid = menuPages[page];
var dsHeight = ds_grid_height(dsGrid);
var xBuffer = 16;
var yBuffer = 32;
var startY = (gHeight / 2) - ((((dsHeight - 1) / 2) * yBuffer));
var startX = gWidth / 2;

// Draw pause menu "back"
var c = c_black;
draw_rectangle_color(0, 0, gWidth, gHeight, c,c,c,c, false); 

// Draw elements on left side
draw_set_valign(fa_middle);
draw_set_halign(fa_right);

var ltx = startX - xBuffer;
var lty;
var xOffset;

var yy = 0;
repeat(dsHeight) {
	lty = startY + (yy * yBuffer);
	c = c_white;
	xOffset = 0;
	
	if(yy == menuOption[page]){
		c = c_orange;
		xOffset = -(xBuffer / 2);
	}
	draw_text_color(ltx + xOffset, lty, dsGrid[# 0, yy], c,c,c,c,1);
	yy++;
}

// Draw dividing line
draw_line(startX, startY - yBuffer, startX, lty + yBuffer);

// Draw elements in the right side
draw_set_halign(fa_left);
var rtx = startX + xBuffer;
var rty;

yy = 0;
repeat (dsHeight) {
	rty = startY + (yy * yBuffer);
	
	switch (dsGrid[# 1, yy]) {
		case menuElementType.shift:
			var currentVal = dsGrid[# 3, yy];
			var currentArray = dsGrid[# 4, yy];
			var leftShift = "<< ";
			var rightShift = " >>";
			
			if (currentVal == 0) leftShift = "";
			if (currentVal == array_length_1d(dsGrid[# 4, yy]) - 1) rightShift = "";
			
			c = c_white;
			
			if (inputting && yy == menuOption[page]) {
				c = c_yellow;
			}
			draw_text_color(rtx, rty, leftShift + currentArray[currentVal] + rightShift, c,c,c,c,1);
			break;
		case menuElementType.slider:
			var len = 64;
			var currentVal = dsGrid[# 3, yy];
			var currentArray = dsGrid[# 4, yy];
			// Example
			// currentVal = 3, currentArray = [2,5]
			// ((3 - 2) / (5 - 2))
			// 1 / 3
			// Percentage = 1/3 * 100 = 33%
			var circlePos = ((currentVal - currentArray[0]) / (currentArray[1] - currentArray[0]));
			c = c_white;
			
			draw_line_width(rtx, rty, rtx + len, rty, 2);
			if (inputting && yy == menuOption[page]) {
				c = c_yellow;
			}
			draw_circle_color(rtx + (circlePos * len), rty, 4, c,c, false);
			draw_text_color(rtx + (len * 1.2), rty, string(floor(circlePos * 100)) + " %", c,c,c,c, 1);
			break;
		case menuElementType.toggle:
			var currentVal = dsGrid[# 3, yy];
			var c1, c2;
			c = c_white;
			if (inputting && yy == menuOption[page]) {
				c = c_yellow;
			}
			
			if (currentVal == 0){
				c1 = c;
				c2 = c_dkgrey;
			}else{
				c1 = c_dkgrey;
				c2 = c;
			}
			
			draw_text_color(rtx, rty, "ON", c1,c1,c1,c1, 1);
			draw_text_color(rtx + 32, rty, "OFF", c2,c2,c2,c2, 1);
			break;
			
		case menuElementType.input:
			var currentVal = dsGrid[# 3, yy];
			var stringVal;
			switch (currentVal) {
				case vk_up:
					stringVal = "UP KEY";
					break;
				case vk_down:
					stringVal = "DOWN KEY";
					break;
				case vk_left:
					stringVal = "LEFT KEY";
					break;
				case vk_right:
					stringVal = "RIGHT KEY";
					break;
				default:
					stringVal = chr(currentVal);
					break;
			}
			
			c = c_white;
			if (inputting && yy == menuOption[page]) {
				c = c_yellow;
			}
			draw_text_color(rtx, rty, stringVal, c,c,c,c, 1);
			break;
		case menuElementType.textBox:
			var stringVal = dsGrid[# 2, yy];
			
			c = c_white;
			if (inputting && yy == menuOption[page]) {
				c = c_yellow;
			}
			draw_text_color(rtx, rty, stringVal, c,c,c,c, 1);
			break;
	}	
	
	yy++;
}


draw_set_valign(fa_top);