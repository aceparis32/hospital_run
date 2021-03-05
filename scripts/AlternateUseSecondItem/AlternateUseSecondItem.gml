// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function AlternateUseSecondItem(){
	if (secondInventory == undefined) {
		exit;	
	}
	
	switch (secondInventory.name) {
		case "Bottle":
			var xRandom = irandom_range(-20, 20);
			var yRandom = irandom_range(-20, 20);
			instance_create_layer(x + xRandom, y + yRandom, "ObjectInstances", oSplash);
			
			secondInventory = undefined;
			break;
		default:
			break;
	}
}