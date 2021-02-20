switch(currentDoorState){
	case 0:
		image_speed = 0;
		entity_collision = true;
		break;
	case 1:
		image_speed = 1;
		entity_collision = false;
		
		if(image_index == 4) {
			image_speed = 0;
		}
		break;
	default:
		break;
}