// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function EnemyCollision(){
	var _collision = false;
	#region Tilemap wall collision
	//// Right Collision
	//if (tilemap_get_at_pixel(wallTilemap, bbox_right + moveX, y) != 0){
	//	x = round(x);
		
	//	moveX = 0;
	//	_collision = true;
	//}
	
	//// Left Collision
	//if (tilemap_get_at_pixel(wallTilemap, bbox_left + moveX, y) != 0){
	//	x = round(x);
		
	//	moveX = 0;
	//	_collision = true;
	//}

	//// Top Collision
	//if (tilemap_get_at_pixel(wallTilemap, x, bbox_top + moveY) != 0){
	//	y = round(y);
		
	//	moveY = 0;
	//	_collision = true;
	//}
	
	//// Bottom Collision
	//if (tilemap_get_at_pixel(wallTilemap, x, bbox_bottom + moveY) != 0){
	//	y = round(y);
		
	//	moveY = 0;
	//	_collision = true;
	//}
	
	if (TileCollisionCheck(moveX, 0)){
		while (!TileCollisionCheck(sign(moveX), 0)){
			x += sign(moveX);	
		}
		
		moveX = 0;
		_collision = true;
	}
	
	if (TileCollisionCheck(0, moveY)){
		while (!TileCollisionCheck(0, sign(moveY))){
			y += sign(moveY);	
		}
		
		moveY = 0;
		_collision = true;
	}
	
	// create entity data structure
	var _entityList = ds_list_create();
	// Horizontal entities
	var _entityCountX = instance_position_list(x + moveX, y, pEntity, _entityList, false);
	// Boundary
	var _snapX;
	while (_entityCountX > 0){
		// code below same as ds_list_find_value(_entityList, 0)
		var _entityCheck = _entityList[| 0];
		if (_entityCheck.entity_collision == true && !_entityCheck.entity_walkable) {
			// Move as close as we can
			// if we move to left
			if (sign(moveX) == -1) _snapX = _entityCheck.bbox_right + 1;	
			else _snapX = _entityCheck.bbox_left - 1;
			x = _snapX;
			// hSpeed = 0 to stop player when colliding
			moveX = 0;
			_collision = true;
			_entityCountX = 0;
		}
		
		//speedWalk = PLAYER_SPEED;

		ds_list_delete(_entityList, 0);
		_entityCountX--;
	}
	
		// Clear list between axis
	ds_list_clear(_entityList);

	// Vertical entities
	var _entityCountY = instance_position_list(x, y + moveY, pEntity, _entityList, false);
	// Boundary
	var _snapY;
	while (_entityCountY > 0){
		// code below same as ds_list_find_value(_entityList, 0)
		var _entityCheck = _entityList[| 0];
		if (_entityCheck.entity_collision == true && !_entityCheck.entity_walkable) {
			// Move as close as we can
			// if we move to left
			if (sign(moveY) == -1) _snapY = _entityCheck.bbox_bottom + 1;	
			else _snapY = _entityCheck.bbox_top - 1;
			y = _snapY;
			moveY = 0;
			_collision = true;
			_entityCountY = 0;
		}
		
		//speedWalk = PLAYER_SPEED;
				
		ds_list_delete(_entityList, 0);
		_entityCountY--;
	}
	
	ds_list_destroy(_entityList);

	return _collision;
	#endregion
}