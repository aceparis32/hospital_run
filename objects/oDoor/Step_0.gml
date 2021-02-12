switch(currentDoorState){
	case 0:
		image_index = 0;
		entity_collision = true;
		break;
	case 1:
		image_index = 4;
		entity_collision = false;
		break;
	default:
		break;
}