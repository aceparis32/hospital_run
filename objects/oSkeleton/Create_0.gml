// enemy state
enum st {
	idle,
	move,
	attack
}

//Properties
moveSpeed = 1;
moveDir = 0;

range = 64;

//Variables
moveX = 0;
moveY = 0;
state = st.idle;
 
//Sprites
sprites[st.idle, 0] = sSkeleton_Idle_Right;
sprites[st.idle, 1] = sSkeleton_Idle_Up;
sprites[st.idle, 2] = sSkeleton_Idle_Left;
sprites[st.idle, 3] = sSkeleton_Idle_Down;
sprites[st.move, 0] = sSkeleton_Move_Right;
sprites[st.move, 1] = sSkeleton_Move_Up;
sprites[st.move, 2] = sSkeleton_Move_Left;
sprites[st.move, 3] = sSkeleton_Move_Down;
sprites[st.attack, 0] = sSkeleton_Attack_Right;
sprites[st.attack, 1] = sSkeleton_Attack_Up;
sprites[st.attack, 2] = sSkeleton_Attack_Left;
sprites[st.attack, 3] = sSkeleton_Attack_Down;
 
mask = sSkeleton_Mask;

// Tilemap
tilesId = layer_get_id("Tiles");
wallTilemap = layer_tilemap_get_id(tilesId);