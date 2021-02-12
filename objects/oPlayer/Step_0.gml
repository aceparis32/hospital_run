/// @description Insert description here
// You can write your code in this editor
// GET PLAYER INPUT
// if u want to use alphabet keys / symbol, u can create variable like this
// keyOther = keyboard_check(ord("A"));
keyLeft = keyboard_check(vk_left) || keyboard_check(ord("A"));
keyRight = keyboard_check(vk_right) || keyboard_check(ord("D"));
keyUp = keyboard_check(vk_up) || keyboard_check(ord("W"));
keyDown = keyboard_check(vk_down) || keyboard_check(ord("S"));
keySneak = keyboard_check(vk_control);
keyDash = keyboard_check_pressed(vk_shift);
keyTakeItem = keyboard_check_pressed(ord("E"));
keyDropItem = keyboard_check_pressed(ord("G"));

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

if(keyDropItem) {
	if (!ds_list_empty(inventory)) {
		ItemSpawn(x, y, inventory[| 0].object);
		ds_list_clear(inventory);	
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