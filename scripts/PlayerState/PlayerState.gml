// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function PlayerStateFree(){
	
	if (!isPlayerStunned) {
		PlayerCollisionWalk(speedWalk);
		
		// UPDATE SPRITE INDEX
		var _oldSprite = sprite_index;
		if (inputMagnitude != 0 && keySneak){
			state = playerStates.sneak;
			direction = inputDirection;
			sprite_index = spriteSneak;
		} else if (inputMagnitude != 0) {
			state = playerStates.walk;
			direction = inputDirection;
			sprite_index = spriteWalk;
		} else {
			state = playerStates.idle;
			sprite_index = spriteIdle;
		}

		if(_oldSprite != sprite_index){
			localFrame = 0;
		}
	
		PlayerAnimateSprite();	
	}
}

function PlayerStateWalk(){
	if(!isPlayerStunned) {
		PlayerCollisionWalk(speedWalk); 
		
		// UPDATE SPRITE INDEX
		var _oldSprite = sprite_index;
		if (inputMagnitude != 0 && keySneak){
			state = playerStates.sneak;
			direction = inputDirection;
			sprite_index = spriteSneak;
		} else if (inputMagnitude != 0) {
			state = playerStates.walk;
			direction = inputDirection;
			sprite_index = spriteWalk;
		} else {
			state = playerStates.idle;
			sprite_index = spriteIdle;
		}

		if(_oldSprite != sprite_index){
			localFrame = 0;
		}
		
		if (place_meeting(x, y, oPuddle)) {
			state = playerStates.slip;
		}
	
		PlayerAnimateSprite();	
		
	}
}

function PlayerStateSneak(){
	if(!isPlayerStunned) {
		PlayerCollisionWalk(speedSneak); 
		
		// UPDATE SPRITE INDEX
		var _oldSprite = sprite_index;
		if (inputMagnitude != 0 && keySneak){
			state = playerStates.sneak;
			direction = inputDirection;
			sprite_index = spriteSneak;
		} else if (inputMagnitude != 0) {
			state = playerStates.walk;
			direction = inputDirection;
			sprite_index = spriteWalk;
		} else {
			state = playerStates.idle;
			sprite_index = spriteIdle;
		}

		if(_oldSprite != sprite_index){
			localFrame = 0;
		}
	
		if (place_meeting(x, y, oPuddle)) {
			state = playerStates.slip;
		}
	
		PlayerAnimateSprite();
	}
}

function PlayerStateDash(){
	// Movement
	hSpeed = lengthdir_x(speedDash, direction) + round(boostX);
	vSpeed = lengthdir_y(speedDash, direction) + round(boostY);
	
	moveDistanceRemaining = max(0, moveDistanceRemaining - speedDash);
	
	if (place_meeting(x, y, oPuddle)) {
		state = playerStates.slip;
	}
	
	// Collision Check 
	var _collided = PlayerCollisionDash();
	
	// No dash animation
	
	// If dash distance was finished, change state to normal
	if (moveDistanceRemaining <= 0){
		state = playerStates.idle;
		sprite_index = spriteIdle;
		dropItemRange = 0;
	}
	
	//if (_collided) {
	//	var objectDashedList = ds_list_create();
	//	var dashed = instance_place_list(x, y, pEntity, objectDashedList, false);
		
	//	if(dashed > 0){
	//		for (var i = 0; i < dashed; i++) {
	//			var dashedID = objectDashedList[| i];
	//			with (dashedID){
	//				if(entity_hit_script != -1 && entity_hit_type == "dash") {
	//					script_execute(entity_hit_script);	
	//				}
	//			}
	//		}
	//	}
	//	ds_list_destroy(objectDashedList);
	//	state = playerStates.idle;
	//	sprite_index = spriteIdle;
	//}
}

function PlayerStunned() {
	playerStunned--;	
	
	if (playerStunned <= 0) {
		playerStunned = 0;
		isPlayerStunned = false;
		state = playerStates.idle;
	}
}

function PlayerStunWall() {
	playerStunned--;	
	
	if (playerStunned <= 0) {
		playerStunned = 0;
		isPlayerStunned = false;
		state = playerStates.idle;
	}
}

function PlayerSlipped() {
	// Movement
	hSpeed = lengthdir_x(speedSlip, direction);
	vSpeed = lengthdir_y(speedSlip, direction);
	
	distanceSlip = distanceSlip - speedSlip;
	dropItemRange++;
	if (dropItemRange mod 5 == 0) {
		instance_create_layer(x, y, "ObjectInstances", oPuddle);
	}
	//for(i = 0; i < 4; i++) {
	//	ItemSpawn(x + (i * 32), y + (i * 32), oPuddle);	
	//}
	
	// Collision Check 
	var _collided = PlayerCollisionDash();
	
	// No dash animation
	
	// If dash distance was finished, change state to normal
	if (_collided) {
		dropItemRange = 0;
		distanceSlip = 0;
		
		playerStunned = 4 * 60;
		isPlayerStunned = true;
		state = playerStates.stun_wall;
		sprite_index = spriteIdle;
		dropItemRange = 0;
		distanceSlip = 120;
	}
	
	
	if (distanceSlip <= 0){
		playerStunned = 2 * 60;
		isPlayerStunned = true;
		state = playerStates.stun;
		sprite_index = spriteIdle;
		dropItemRange = 0;
		distanceSlip = 120;
	}
}