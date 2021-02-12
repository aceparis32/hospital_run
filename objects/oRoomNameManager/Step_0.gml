var roomCollision = tilemap_get_at_pixel(roomNameTiles, oPlayer.x, oPlayer.y);

switch (roomCollision){
	case 1:
		currentRoomName = "Gym";
		break;
	case 2:
		currentRoomName = "Gym Storage";
		break;
	case 3:
		currentRoomName = "Canteen";
		break;
	default:
		currentRoomName = "Unknown";
		break;
}