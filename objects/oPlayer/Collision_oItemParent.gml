/// @description Insert description here
// You can write your code in this editor
if (place_meeting(x, y, other) && keyTakeItem){
	//if(ds_list_size(inventory) < 2){
	//	ds_list_add(inventory, other.item);
	//	show_debug_message(string(other.item));
	//	instance_destroy(other);
	//}
	
	if(firstInventory == undefined) {
		firstInventory = other.item;
		instance_destroy(other);
		if (secondInventory == undefined) {
			selectedInventory = selectedItem.firstItem;
		}
	}else{
		if(secondInventory == undefined){
			secondInventory = other.item;
			instance_destroy(other);
		}
	}
}