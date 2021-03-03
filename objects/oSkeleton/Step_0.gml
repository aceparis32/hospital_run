if (collision_line(x, y, oPlayer.x, oPlayer.y, oBorder, 1, 0)) {
	visible = false;	
}else{
	visible = true;
	switch (state){
	case st.idle: case st.move:
		//Input
		var inputX = 0, inputY = 0, run = 0, attack = 0;
 
		// Follow player
		if (instance_exists(oPlayer) && distance_to_object(oPlayer) < range){
			var dir = point_direction(x, y, oPlayer.x, oPlayer.y);
			moveDir = dir div 90;
			
			moveX = lengthdir_x(moveSpeed, dir);
			moveY = lengthdir_y(moveSpeed, dir);
			
			// Enemy Collision
			if (place_meeting(x + moveX, y + moveY, oEnemies)) {
				moveX = 0;
				moveY = 0;
			}
		}
		// Move around
		else if (irandom(30) == 0){
			moveDir = irandom(3);
			moveX = lengthdir_x(choose(moveSpeed, 0), moveDir * 90);
			moveY = lengthdir_y(choose(moveSpeed, 0), moveDir * 90);
		}
		
		var enemyCollision = EnemyCollision();
		
		if (enemyCollision) {
			state = st.idle;
		}
		
		//Collisions
		//if (collision(moveX, 0)){
		//	while(!collision(sign(moveX), 0)){
		//		x += sign(moveX);
		//	} 
		//	moveX = 0;
		//}
 
		//if (collision(0, moveY)){
		//	while(!collision(0, sign(moveY))){
		//		y += sign(moveY);
		//	}
		//	moveY = 0;
		//}
 
		//Apply
		x += moveX;
		y += moveY;
 
		//State
		if (abs(moveX)+abs(moveY)==0){
			state = st.idle;
		}else{
			state = st.move;
			image_speed = 1+run/2;
		}
		
		mask_index = mask; 
 
		//Attack
		if (place_meeting(x, y, oPlayer)){
			StateSet(st.attack);
		}
		break;
	case st.attack:
		image_speed = 1;
		mask_index = sprite_index;
	break;
}

sprite_index = sprites[state, moveDir];
}