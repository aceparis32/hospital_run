/// @description Insert description here
// You can write your code in this editor
enum playerStates {
	idle,
	walk,
	sneak,
	dash,
	stun
}

enum selectedItem {
	firstItem,
	secondItem
}

// player default state is idle
state = playerStates.idle;

// Horizontal Speed
hSpeed = 0;
// Vertical Speed
vSpeed = 0;
// Player speed walk
speedWalk = PLAYER_SPEED;
// Player speed when sneaking
speedSneak = speedWalk * 0.25;
// Player dash properties
speedDash = 3.0;
distanceDash = 150;
dashCooldown = 0.0;
// Player stun properties
playerStunned = 0;
isPlayerStunned = false;

// Store sprite into variables
spriteIdle = sPlayer;
spriteWalk = sPlayerWalk;
spriteSneak = sPlayerSneak;
localFrame = 0;

// Tilemap
// Get the layer tilemap
collisionMap = layer_tilemap_get_id(layer_get_id("Col"));

// Inventory List
inventory = ds_list_create();

// Split inventory
firstInventory = undefined;
secondInventory = undefined;

// Selected inventory
selectedInventory = selectedItem.firstItem;

// interface
instance_create_layer(0, 0, "Instances", oItemMenu);
instance_create_layer(0, 0, "Instances", oMap);
tilesId = layer_get_id("Tiles");
wallTilemap = layer_tilemap_get_id(tilesId);

// Map
mapObject = oMap;
mapObject.showMap = false;

// Knockback
boostX = 0;
boostY = 0;

// Timer
keyTimer = room_speed * 0.3;
crowbarsTimer = room_speed * 2.5;