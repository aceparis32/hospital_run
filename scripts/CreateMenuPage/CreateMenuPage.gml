// @description Create menu page

function CreateMenuPage(){
	var arg;
	var i = 0;
	repeat (argument_count) {
		arg[i] = argument[i];
		i++;
	}
	
	var dsGridId = ds_grid_create(5, argument_count);
	i = 0;
	repeat (argument_count) {
		var array = arg[i];
		var arrayLen = array_length_1d(array);
		
		var xx = 0;
		repeat (arrayLen) {
			dsGridId[# xx, i] = array[xx];
			xx++;
		}
		
		i++;
	}
	
	return dsGridId;
}