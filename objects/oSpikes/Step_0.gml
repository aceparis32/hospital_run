switch(spikeState) {
	case SPIKE_STATE.enabled:
		trap_active = true;
		break;
	case SPIKE_STATE.disabled:
		image_speed = 1;
		
		if (image_index == 5) {
			image_speed = 0;
			trap_active = false;	
		}
		
		break;
}