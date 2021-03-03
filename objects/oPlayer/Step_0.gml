/// @description Insert description here
// You can write your code in this editor
// GET PLAYER INPUT
// if u want to use alphabet keys / symbol, u can create variable like this
// keyOther = keyboard_check(ord("A"));
keyLeft = keyboard_check(ord("A"));
keyRight = keyboard_check(ord("D"));
keyUp = keyboard_check(ord("W"));
keyDown = keyboard_check(ord("S"));
keySneak = keyboard_check(vk_control);
keyDash = keyboard_check_pressed(vk_space);
keyTakeItem = keyboard_check_pressed(ord("C"));
keyDropFirstItem = keyboard_check(ord("Q")) && keyboard_check(vk_shift);
keyDropSecondItem = keyboard_check(ord("E")) && keyboard_check(vk_shift);
keyDropItem = keyboard_check(ord("G"));
keySelectFirstItem = keyboard_check_pressed(ord("Q"));
keySelectSecondItem = keyboard_check_pressed(ord("E"));

inputDirection = point_direction(0, 0, keyRight - keyLeft, keyDown - keyUp);
inputMagnitude = (keyRight - keyLeft != 0) || (keyDown - keyUp != 0);

if(keyDash && dashCooldown <= 0){
	state = playerStates.dash;
	moveDistanceRemaining = distanceDash;
	dashCooldown = 3 * 60;
}

if(dashCooldown > 0){
	dashCooldown--;	
}

if (keyDropItem) {
	if (selectedInventory == selectedItem.firstItem && firstInventory != undefined) {
		ItemSpawn(x, y, firstInventory.object);
		firstInventory = undefined;
	} else if (selectedInventory == selectedItem.secondItem && secondInventory != undefined) {
		ItemSpawn(x, y, secondInventory.object);
		secondInventory = undefined;
	}
}

//if(keyDropFirstItem) {
//	if (firstInventory != undefined) {
//		ItemSpawn(x, y, firstInventory.object);
//		firstInventory = undefined;
//	}
//}

//if(keyDropSecondItem) {
//	if (secondInventory != undefined) {
//		ItemSpawn(x, y, secondInventory.object);
//		secondInventory = undefined;
//	}
//}

if(keySelectFirstItem) {
	selectedInventory = selectedItem.firstItem;
}

if(keySelectSecondItem) {
	selectedInventory = selectedItem.secondItem;
}

if(state == playerStates.idle && !isPlayerStunned){
	#region idle
	stateName = "Idle";
	script_execute(PlayerStateFree);
	#endregion
}else if(state == playerStates.walk && !isPlayerStunned){
	#region walk
	stateName = "Walk";
	script_execute(PlayerStateWalk);
	#endregion
}else if(state == playerStates.sneak && !isPlayerStunned){
	#region sneak
	stateName = "Sneak";
	script_execute(PlayerStateSneak);
	#endregion
}else if(state == playerStates.dash && !isPlayerStunned){
	#region dash
	stateName = "Dash";
	script_execute(PlayerStateDash);
	#endregion
}else if(state == playerStates.stun){
	#region stunned
	stateName = "Stunned";
	script_execute(PlayerStunned);
	#endregion
}else if(state == playerStates.slip) {
	stateName = "Slip";
	script_execute(PlayerSlipped);	
}else if(state == playerStates.stun_wall) {
	stateName = "Wall Stun";
	script_execute(PlayerStunWall);	
}

// Enemy Collision
var enemy = instance_place(x, y, oEnemies);

if (enemy && enemy.state == st.attack) {
	var dir = point_direction(enemy.x, enemy.y, x, y);
	boostX = lengthdir_x(8, dir);
	boostY = lengthdir_y(8, dir);
}

boostX = lerp(boostX, 0, 0.1);
boostY = lerp(boostY, 0, 0.1);