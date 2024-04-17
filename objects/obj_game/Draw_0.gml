/// @description Insert description here
// You can write your code in this editor

if (room == Level1) {
	draw_text(390, 3490, "Left & Right Arrows/ Left Stick to Move");
	draw_text(390, 3508, "Space/ A to Jump");
	draw_text(390, 3526, "C/ X to Attack");
	draw_text(390, 3544, "Up & Down Arrows/ Left Stick to Aim Attack");
	if (instance_find(obj_player, 0) != noone and obj_player.has_double_jump) {
		draw_text(2950, 2050, "Double Press A or Space to Double Jump");
	}
}








