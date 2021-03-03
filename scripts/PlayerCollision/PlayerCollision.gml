// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function PlayerCollisionDash(){
	var _collision = false;
	var _entityList = ds_list_create();
	
	#region Tilemap wall collision
	// Right Collision
	if (tilemap_get_at_pixel(wallTilemap, bbox_right + hSpeed, y) != 0){
		x = round(x);
		
		hSpeed = 0;
		_collision = true;
	}
	
	// Left Collision
	if (tilemap_get_at_pixel(wallTilemap, bbox_left + hSpeed, y) != 0){
		x = round(x);
		
		hSpeed = 0;
		_collision = true;
	}

	// Top Collision
	if (tilemap_get_at_pixel(wallTilemap, x, bbox_top + vSpeed) != 0){
		y = round(y);
		
		vSpeed = 0;
		_collision = true;
	}
	
	// Bottom Collision
	if (tilemap_get_at_pixel(wallTilemap, x, bbox_bottom + vSpeed) != 0){
		y = round(y);
		
		vSpeed = 0;
		_collision = true;
	}
	#endregion
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
	
function PlayerCollisionWalk(_speed){
		// MOVEMENT
	hSpeed = lengthdir_x(inputMagnitude * _speed, inputDirection) + round(boostX);
	vSpeed = lengthdir_y(inputMagnitude * _speed, inputDirection) + round(boostY);

	var _collision = false;
	
	#region Tilemap wall collision
	//// Right Collision
	//if (tilemap_get_at_pixel(wallTilemap, bbox_right + hSpeed + 5, y) != 0){
	//	x = round(x);
		
	//	hSpeed = 0;
	//	_collision = true;
	//}
	
	//// Left Collision
	//if (tilemap_get_at_pixel(wallTilemap, bbox_left + hSpeed - 5, y) != 0){
	//	x = round(x);
		
	//	hSpeed = 0;
	//	_collision = true;
	//}

	//// Top Collision
	//if (tilemap_get_at_pixel(wallTilemap, x, bbox_top + vSpeed + 10) != 0){
	//	y = round(y);
		
	//	vSpeed = 0;
	//	_collision = true;
	//}
	
	//// Bottom Collision
	//if (tilemap_get_at_pixel(wallTilemap, x, bbox_bottom + vSpeed - 10) != 0){
	//	y = round(y);
		
	//	vSpeed = 0;
	//	_collision = true;
	//}
	#endregion
	
	// Tilemap collision
	//var tileCol = tilemap_get_at_pixel(wallTilemap, bbox_left + hSpeed, bbox_top + vSpeed + 10) ||
	//				tilemap_get_at_pixel(wallTilemap, bbox_right + hSpeed, bbox_top + vSpeed + 10) ||
	//				tilemap_get_at_pixel(wallTilemap, bbox_right + hSpeed, bbox_bottom + vSpeed) ||					tilemap_get_at_pixel(wallTilemap, bbox_right + hSpeed, bbox_bottom + vSpeed) ||
	//				tilemap_get_at_pixel(wallTilemap, bbox_left + hSpeed, bbox_bottom + vSpeed);
	
	if (TileCollisionCheck(hSpeed, 0)){
		while (!TileCollisionCheck(sign(hSpeed), 0)){
			x += sign(hSpeed);	
		}
		
		hSpeed = 0;
	}
	
	if (TileCollisionCheck(0, vSpeed)){
		while (!TileCollisionCheck(0, sign(vSpeed))){
			y += sign(vSpeed);	
		}
		
		vSpeed = 0;
	}

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

function TileCollisionCheck(_hSpeed, _vSpeed) {
	var _xAdd = _hSpeed;
	var _yAdd = _vSpeed;
	
	// Tile Collision
	var tileCol =
				// Top left corner
				tilemap_get_at_pixel(wallTilemap, bbox_left + _xAdd, bbox_top + _yAdd) ||
				// Top right corner
				tilemap_get_at_pixel(wallTilemap, bbox_right + _xAdd, bbox_top + _yAdd) ||
				// Bottom right corner
				tilemap_get_at_pixel(wallTilemap, bbox_right + _xAdd, bbox_bottom + _yAdd) ||
				// Bottom left corner
				tilemap_get_at_pixel(wallTilemap, bbox_left + _xAdd, bbox_bottom + _yAdd);
				
	return tileCol;
}
	
