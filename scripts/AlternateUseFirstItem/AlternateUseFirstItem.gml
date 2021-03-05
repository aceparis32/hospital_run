// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function AlternateUseFirstItem(){
	if (firstInventory == undefined) {
		exit;	
	}
	
	switch (firstInventory.name) {
		case "Bottle":
			var xRandom = irandom_range(-30, 30);
			var yRandom = irandom_range(-30, 30);
			instance_create_layer(x + xRandom, y + yRandom, "ObjectInstances", oSplash);
			
			firstInventory = undefined;
			break;
		default:
			break;
	}
}