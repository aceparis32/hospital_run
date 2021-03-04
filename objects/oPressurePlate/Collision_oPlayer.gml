if (isTriggered == true){
	exit;
}

if (target != noone){
	show_debug_message("enter");
	target.spikeState = SPIKE_STATE.disabled;
	
	image_index = 1;
	isTriggered = true;
}