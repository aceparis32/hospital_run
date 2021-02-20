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

if(keyDropFirstItem) {
	show_debug_message("drop first item");
	//if (!ds_list_empty(inventory)) {
	//	ItemSpawn(x, y, inventory[| 0].object);
	//	ds_list_delete(inventory, 0);
	//}
	if (firstInventory != undefined) {
		ItemSpawn(x, y, firstInventory.object);
		firstInventory = undefined;
		
		if(secondInventory != undefined) {
			selectedInventory = selectedItem.secondItem;	
		}else{
			selectedInventory = selectedItem.noItem;	
		}
	}
}

if(keyDropSecondItem) {
	//if (!ds_list_empty(inventory) && ds_list_size(inventory) == 2){
	//	ItemSpawn(x, y, inventory[| 1].object);
	//	ds_list_delete(inventory, 1);
	//}
	if (secondInventory != undefined) {
		ItemSpawn(x, y, secondInventory.object);
		secondInventory = undefined;
		
		if(firstInventory != undefined) {
			selectedInventory = selectedItem.firstItem;	
		}else{
			selectedInventory = selectedItem.noItem;
		}
	}
}

if(keySelectFirstItem) {
	if (firstInventory != undefined) {
		selectedInventory = selectedItem.firstItem;
	}
}

if(keySelectSecondItem) {
	if (secondInventory != undefined) {
		selectedInventory = selectedItem.secondItem;	
	}
}

if(state == playerStates.idle && !isPlayerStunned){
	#region idle
	script_execute(PlayerStateFree);
	#endregion
}else if(state == playerStates.walk && !isPlayerStunned){
	#region walk
	script_execute(PlayerStateWalk);
	#endregion
}else if(state == playerStates.sneak && !isPlayerStunned){
	#region sneak
	script_execute(PlayerStateSneak);
	#endregion
}else if(state == playerStates.dash && !isPlayerStunned){
	#region dash	
	script_execute(PlayerStateDash);
	#endregion
}else if(state == playerStates.stun){
	#region stunned
	show_debug_message("player enter stun condition");
	script_execute(PlayerStunned);
	#endregion
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