switch(selectedInventory) {
	case selectedItem.firstItem:
		if(firstInventory != undefined) {
			switch(firstInventory.name){
				case "Bottle":
					isPlayerStunned = false;
					playerStunned = 0;
					state = playerStates.idle;
					
					firstInventory = undefined;
					break;
				default:
					break;
			}
		}
	case selectedItem.secondItem:
		if(secondInventory != undefined) {
			switch(secondInventory.name){
				case "Bottle":
					isPlayerStunned = false;
					playerStunned = 0;
					state = playerStates.idle;
					
					secondInventory = undefined;
					break;
				default:
					break;
			}
		}
}