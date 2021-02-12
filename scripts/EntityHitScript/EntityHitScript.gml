// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function EntityHitDestructible() {
	show_debug_message("Enter destructible function");
	entity_hit_count--;
	if (entity_hit_count <= 0){
		instance_destroy();
	}
}

function EntityHitWet() {
	state = playerStates.stun;
	//oPlayer.playerStunned = 3;
}

function EntityHitSolid() {
	state = playerStates.stun;
	//oPlayer.playerStunned = 5 * FRAME_RATE;	
}

function EntityHitDoor() {
	show_debug_message("Door dashed");
	currentDoorState = DoorStates.open;
}