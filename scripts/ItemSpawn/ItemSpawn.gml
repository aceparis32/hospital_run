// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function ItemSpawn(_x, _y, _itemObject){
	var _inst = instance_create_layer(_x, _y, "Instances", _itemObject);
}