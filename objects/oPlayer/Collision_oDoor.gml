if(keyboard_check(ord("F"))){
	if (oPlayer.selectedInventory == selectedItem.firstItem) {
		if (oPlayer.firstInventory != undefined) {
			if (oPlayer.firstInventory.name == "Key") {
				interactionTimeStatus = true;
				var isEnd = InteractionTime(0);
				
				if(isEnd){
					interactionTimeStatus = false;
					other.currentDoorState = DoorStates.open;
				}
			}else if(oPlayer.firstInventory.name == "Crowbars" && other.entity_collision) {
				interactionTimeStatus = true;
				var isEnd = InteractionTime(1);
				
				if(isEnd) {
					interactionTimeStatus = false;
					other.currentDoorState = DoorStates.open;
				}
			}
		}	
	}else if (oPlayer.selectedInventory == selectedItem.secondItem) {
		if (oPlayer.secondInventory != undefined) {
			if (oPlayer.secondInventory.name == "Key") {
				interactionTimeStatus = true;
				var isEnd = InteractionTime(0);
				
				if(isEnd){
					interactionTimeStatus = false;
					other.currentDoorState = DoorStates.open;
				}
			}else if(oPlayer.secondInventory.name == "Crowbars" && other.entity_collision) {
				interactionTimeStatus = true;
				var isEnd = InteractionTime(1);
				
				if(isEnd) {
					interactionTimeStatus = false;
					other.currentDoorState = DoorStates.open;
				}
			}	
		}
	}
}else{
	keyTimer = room_speed * 0.3;
	crowbarsTimer = room_speed * 2.5;
	itemTimer = 0;
	interactionTimeStatus = false;
}