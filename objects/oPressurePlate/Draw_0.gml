draw_self();

if (debugOn) {
	if (target != noone) {
		draw_set_color(debugColor);
		draw_line(x, y, target.x, target.y);
		draw_set_color(c_white);
	}
}