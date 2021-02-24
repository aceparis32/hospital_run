// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function ChangeVolume(_args){
	var type = menuOption[page];
	
	switch (type) {
		case 0:
			audio_master_gain(_args);
			break;
		case 1:
			audio_group_set_gain(audiogroup_soundeffects, _args, 0);
			break;
		case 2:
			audio_group_set_gain(audiogroup_music, _args, 0);
			break;			
	}	
}