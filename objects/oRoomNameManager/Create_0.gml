enum RoomNames {
	gym,
	gymStorage,
	canteen
}

roomNameLayerID = layer_get_id("RoomName");
roomNameTiles = layer_tilemap_get_id(roomNameLayerID);
currentRoomName = "Unknown";