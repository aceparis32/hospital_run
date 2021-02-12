/// @description Insert description here
// You can write your code in this editor
draw_set_font(fText);
draw_text(32, 100, string("Dash Cooldown : " + string(oPlayer.dashCooldown / 60) + " seconds"));
draw_text(32, 120, string("Current Room : " + oRoomNameManager.currentRoomName));