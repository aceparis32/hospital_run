// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function PlayerStateFree(){
	
	if (!isPlayerStunned) {
		PlayerCollisionWalk();
		
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
		PlayerCollisionWalk(); 
		
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

function PlayerStateSneak(){
	// MOVEMENT
	hSpeed = lengthdir_x(inputMagnitude * speedSneak, inputDirection) + boostX;
	vSpeed = lengthdir_y(inputMagnitude * speedSneak, inputDirection) + boostY;

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
	
	x += hSpeed;
	y += vSpeed;


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

function PlayerStateDash(){
	// Movement
	hSpeed = lengthdir_x(speedDash, direction) + round(boostX);
	vSpeed = lengthdir_y(speedDash, direction) + round(boostY);
	
	moveDistanceRemaining = max(0, moveDistanceRemaining - speedDash);
	// Collision Check 
	var _collided = PlayerCollisionDash();
	
	// No dash animation
	
	// If dash distance was finished, change state to normal
	if (moveDistanceRemaining <= 0){
		state = playerStates.idle;
		sprite_index = spriteIdle;
	}
	
	if (_collided) {
		var objectDashedList = ds_list_create();
		var dashed = instance_place_list(x, y, pEntity, objectDashedList, false);
		
		if(dashed > 0){
			for (var i = 0; i < dashed; i++) {
				var dashedID = objectDashedList[| i];
				with (dashedID){
					if(entity_hit_script != -1 && entity_hit_type == "dash") {
						script_execute(entity_hit_script);	
					}
				}
			}
		}
		ds_list_destroy(objectDashedList);
		state = playerStates.idle;
		sprite_index = spriteIdle;
	}
}

function PlayerStunned() {
	//hSpeed = 0;
	//vSpeed = 0;
	//sprite_index = spriteIdle;
	//playerStunned--;
	//show_debug_message("Player stunned for : " + string(isPlayerStunned) + " seconds");
	
	//if (isPlayerStunned <= 0) {
	//	state = playerStates.idle;	
	//}
}