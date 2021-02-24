// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function ChangeDifficulty(_args){
	var type = menuOption[page];
	
	// Enemies
	if (type == 0) {
		switch (_args) {
			case 0:
				// easy
				global.enemyHealth = 1;
				break;
			case 1:
				// medium
				global.enemyHealth = 3;
				break;
			case 2:
				// hard
				global.enemyHealth = 5;
				break;
		}
	}
	// Allies
	else if (type == 1) {
			switch (_args) {
			case 0:
				// easy
				global.allyHealth = 1;
				break;
			case 1:
				// medium
				global.allyHealth = 3;
				break;
			case 2:
				// hard
				global.allyHealth = 5;
				break;
		}	
	}
}