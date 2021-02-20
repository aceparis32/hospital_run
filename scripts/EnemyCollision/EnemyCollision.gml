// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function EnemyCollision(){
	#region Tilemap wall collision
	// Right Collision
	if (tilemap_get_at_pixel(wallTilemap, bbox_right + moveX, y) != 0){
		x = round(x);
		
		moveX = 0;
	}
	
	// Left Collision
	if (tilemap_get_at_pixel(wallTilemap, bbox_left + moveX, y) != 0){
		x = round(x);
		
		moveX = 0;
	}

	// Top Collision
	if (tilemap_get_at_pixel(wallTilemap, x, bbox_top + moveY) != 0){
		y = round(y);
		
		moveY = 0;
	}
	
	// Bottom Collision
	if (tilemap_get_at_pixel(wallTilemap, x, bbox_bottom + moveY) != 0){
		y = round(y);
		
		moveY = 0;
	}
	#endregion
}