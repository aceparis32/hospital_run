/// @description Insert description here
// You can write your code in this editor
if (place_meeting(x, y, other) && keyTakeItem){
	show_debug_message("enter");
	if(ds_list_size(inventory) == 0){
		ds_list_add(inventory, other.item);
		show_debug_message(string(other.item));
		instance_destroy(other);
	}
}