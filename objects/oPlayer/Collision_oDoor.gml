if(keyboard_check(ord("F"))){
	if (oPlayer.selectedInventory == selectedItem.firstItem) {
		if (oPlayer.firstInventory != undefined) {
			if (oPlayer.firstInventory.name == "Key") {
				var isEnd = InteractionTime(0);
				
				if(isEnd){
					other.currentDoorState = DoorStates.open;
				}
			}else if(oPlayer.firstInventory.name == "Crowbars" && other.entity_collision) {
				var isEnd = InteractionTime(1);
				
				if(isEnd) {
					instance_destroy(other);
				}
			}
		}	
	}else if (oPlayer.selectedInventory == selectedItem.secondItem) {
		if (oPlayer.secondInventory.name == "Key") {
				var isEnd = InteractionTime(0);
				
				if(isEnd){
					other.currentDoorState = DoorStates.open;
				}
			}else if(oPlayer.secondInventory.name == "Crowbars" && other.entity_collision) {
				var isEnd = InteractionTime(1);
				
				if(isEnd) {
					instance_destroy(other);
				}
			}	
	}
}else{
	keyTimer = room_speed * 0.3;
	crowbarsTimer = room_speed * 2.5;
}