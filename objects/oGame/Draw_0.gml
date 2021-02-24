draw_set_halign(fa_center);
draw_set_font(fSmallText);
draw_text(oPlayer.x, oPlayer.y - 40, oPlayer.stateName);

if (oPlayer.interactionTimeStatus) draw_text(oPlayer.x, oPlayer.y + 5, "Time left : " + string(oPlayer.itemTimer) + " sec");