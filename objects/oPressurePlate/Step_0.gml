if (target == noone) {
	for (var i = 0; i < instance_number(oSpikes); i++) {
		var instance = instance_find(oSpikes, i);
		
		if (instance.name == trap_object){
			target = instance;
			break;
		}
	}
}