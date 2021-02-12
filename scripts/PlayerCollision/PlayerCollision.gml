// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function PlayerCollisionDash(){
	var _collision = false;
	var _entityList = ds_list_create();
	
	if(PlayerCollisionWall(x + hSpeed, y, oBorder)){
		while (!PlayerCollisionWall(x + sign(hSpeed), y, oBorder)) {
		    x += sign(hSpeed);
		}
		hSpeed = 0;
	}else if(PlayerCollisionWall(x + hSpeed, y, oBorderBottom)){
		while (!PlayerCollisionWall(x + sign(hSpeed), y, oBorderBottom)) {
		    x += sign(hSpeed);
		}
		hSpeed = 0;
	}else if(PlayerCollisionWall(x + hSpeed, y, oBorderRight)){
		while (!PlayerCollisionWall(x + sign(hSpeed), y, oBorderRight)) {
		    x += sign(hSpeed);
		}
		hSpeed = 0;
	}
	
	if(PlayerCollisionWall(x, y + vSpeed, oBorder)){
		while (!PlayerCollisionWall(x, y + sign(vSpeed), oBorder)) {
		    y += sign(vSpeed);
		}
		vSpeed = 0;
	}else if(PlayerCollisionWall(x, y + vSpeed, oBorderBottom)){
		while (!PlayerCollisionWall(x, y + sign(vSpeed), oBorderBottom)) {
		    y += sign(vSpeed);
		}
		vSpeed = 0;
	}else if(PlayerCollisionWall(x, y + vSpeed, oBorderRight)){
		while (!PlayerCollisionWall(x, y + sign(vSpeed), oBorderRight)) {
		    y += sign(vSpeed);
		}
		vSpeed = 0;
	}
	
	// Horizontal entities
	var _entityCount = instance_position_list(x + hSpeed, y, pEntity, _entityList, false);
	// Boundary
	var _snapX;
	while (_entityCount > 0){
		// code below same as ds_list_find_value(_entityList, 0)
		var _entityCheck = _entityList[| 0];
		if (_entityCheck.entity_collision == true) {
			// Move as close as we can
			// if we move to left
			if (sign(hSpeed) == -1) _snapX = _entityCheck.bbox_right + 1;	
			else _snapX = _entityCheck.bbox_left - 1;
			x = _snapX;
			// hSpeed = 0 to stop player when colliding
			hSpeed = 0;
			// and change collision status to true
			_collision = true;
			_entityCount = 0;
		}
		
		ds_list_delete(_entityList, 0);
		_entityCount--;
	}
	x += hSpeed;
	// Clear list between axis
	ds_list_clear(_entityList);
	
		// Vertical entities
	var _entityCount = instance_position_list(x, y + vSpeed, pEntity, _entityList, false);
	// Boundary
	var _snapY;
	while (_entityCount){
		// code below same as ds_list_find_value(_entityList, 0)
		var _entityCheck = _entityList[| 0];
		if (_entityCheck.entity_collision == true) {
			// Move as close as we can
			// if we dash to bottom object, move player position in bottom
			// else, add 1 more y position so the object collide with player
			if (sign(vSpeed) == -1) _snapY = _entityCheck.bbox_bottom + 1;	
			else _snapY = _entityCheck.bbox_top + 1;
			y = _snapY;
			vSpeed = 0;
			_collision = true;
			_entityCount = 0;
		}
		
		ds_list_delete(_entityList, 0);
		_entityCount--;
	}
	
	y += vSpeed;
	
	// destroy entity data structure
	ds_list_destroy(_entityList);
	
	return _collision;
}

function PlayerCollisionWall(_x, _y, _border){
	return place_meeting(_x, _y, _border);
}
	
function PlayerCollisionWalk(){
		// MOVEMENT
	hSpeed = lengthdir_x(inputMagnitude * speedWalk, inputDirection);
	vSpeed = lengthdir_y(inputMagnitude * speedWalk, inputDirection);

	var _collision = false;
	
	//if(PlayerCollisionWall(x + hSpeed, y, oBorder)){
	//	while (!PlayerCollisionWall(x + sign(hSpeed), y, oBorder)) {
	//	    x += sign(hSpeed);
	//	}
	//	hSpeed = 0;
	//}else if(PlayerCollisionWall(x + hSpeed, y, oBorderBottom)){
	//	while (!PlayerCollisionWall(x + sign(hSpeed), y, oBorderBottom)) {
	//	    x += sign(hSpeed);
	//	}
	//	hSpeed = 0;
	//}else if(PlayerCollisionWall(x + hSpeed, y, oBorderRight)){
	//	while (!PlayerCollisionWall(x + sign(hSpeed), y, oBorderRight)) {
	//	    x += sign(hSpeed);
	//	}
	//	hSpeed = 0;
	//}
	
	//if(PlayerCollisionWall(x, y + vSpeed, oBorder)){
	//	while (!PlayerCollisionWall(x, y + sign(vSpeed), oBorder)) {
	//	    y += sign(vSpeed);
	//	}
	//	vSpeed = 0;
	//}else if(PlayerCollisionWall(x, y + vSpeed, oBorderBottom)){
	//	while (!PlayerCollisionWall(x, y + sign(vSpeed), oBorderBottom)) {
	//	    y += sign(vSpeed);
	//	}
	//	vSpeed = 0;
	//}else if(PlayerCollisionWall(x, y + vSpeed, oBorderRight)){
	//	while (!PlayerCollisionWall(x, y + sign(vSpeed), oBorderRight)) {
	//	    y += sign(vSpeed);
	//	}
	//	vSpeed = 0;
	//}
	
	#region Tilemap wall collision
	// Right Collision
	if (tilemap_get_at_pixel(wallTilemap, bbox_right + hSpeed, y) != 0){
		x = round(x);
		//while (tilemap_get_at_pixel(wallTilemap, bbox_right, y) == 0) {
		//	x += hSpeed;	
		//}
		
		//while (tilemap_get_at_pixel(wallTilemap, bbox_right, y) != 0) {
		//	x -= hSpeed;
		//}
		
		hSpeed = 0;
		_collision = true;
	}
	
	// Left Collision
	if (tilemap_get_at_pixel(wallTilemap, bbox_left + hSpeed, y) != 0){
		x = round(x);
		//while (tilemap_get_at_pixel(wallTilemap, bbox_left, y) == 0) {
		//	x += hSpeed;	
		//}
		
		//while (tilemap_get_at_pixel(wallTilemap, bbox_left, y) != 0) {
		//	x -= hSpeed;
		//}
		
		hSpeed = 0;
		_collision = true;
	}

	// Top Collision
	if (tilemap_get_at_pixel(wallTilemap, x, bbox_top + vSpeed) != 0){
		y = round(y);
		//while (tilemap_get_at_pixel(wallTilemap, x, bbox_top) == 0) {
		//	y += hSpeed;	
		//}
		
		//while (tilemap_get_at_pixel(wallTilemap, x, bbox_top) != 0) {
		//	y -= hSpeed;
		//}
		
		vSpeed = 0;
		_collision = true;
	}
	
	// Bottom Collision
	if (tilemap_get_at_pixel(wallTilemap, x, bbox_bottom + vSpeed) != 0){
		y = round(y);
		//while (tilemap_get_at_pixel(wallTilemap, x, bbox_bottom) == 0) {
		//	y += hSpeed;	
		//}
		
		//while (tilemap_get_at_pixel(wallTilemap, x, bbox_bottom) != 0) {
		//	y -= hSpeed;
		//}
		
		vSpeed = 0;
		_collision = true;
	}
	#endregion
	
	// create entity data structure
	var _entityList = ds_list_create();
	// Horizontal entities
	var _entityCountX = instance_position_list(x + hSpeed, y, pEntity, _entityList, false);
	// Boundary
	var _snapX;
	while (_entityCountX > 0){
		// code below same as ds_list_find_value(_entityList, 0)
		var _entityCheck = _entityList[| 0];
		if (_entityCheck.entity_collision == true && !_entityCheck.entity_walkable) {
			// Move as close as we can
			// if we move to left
			if (sign(hSpeed) == -1) _snapX = _entityCheck.bbox_right + 1;	
			else _snapX = _entityCheck.bbox_left - 1;
			x = _snapX;
			// hSpeed = 0 to stop player when colliding
			hSpeed = 0;
			// and change collision status to true
			_collision = true;
			_entityCountX = 0;
		}else if (_entityCheck.entity_collision == true && _entityCheck.entity_walkable) {
			speedWalk = 0.25;
			_entityCountX = 0;
		}
		
		//speedWalk = PLAYER_SPEED;

		ds_list_delete(_entityList, 0);
		_entityCountX--;
	}
	
	x += hSpeed;
	
	// Clear list between axis
	ds_list_clear(_entityList);

	// Vertical entities
	var _entityCountY = instance_position_list(x, y + vSpeed, pEntity, _entityList, false);
	// Boundary
	var _snapY;
	while (_entityCountY > 0){
		// code below same as ds_list_find_value(_entityList, 0)
		var _entityCheck = _entityList[| 0];
		if (_entityCheck.entity_collision == true && !_entityCheck.entity_walkable) {
			// Move as close as we can
			// if we move to left
			if (sign(vSpeed) == -1) _snapY = _entityCheck.bbox_bottom + 1;	
			else _snapY = _entityCheck.bbox_top - 1;
			y = _snapY;
			vSpeed = 0;
			_collision = true;
			_entityCountY = 0;
		}else if (_entityCheck.entity_collision == true && _entityCheck.entity_walkable) {
			speedWalk = 0.25;
			_entityCountY = 0;
		}
		
		//speedWalk = PLAYER_SPEED;
				
		ds_list_delete(_entityList, 0);
		_entityCountY--;
	}
	
	y += vSpeed;
	
	// destroy entity data structure
	ds_list_destroy(_entityList);
	
	return _collision;	
}