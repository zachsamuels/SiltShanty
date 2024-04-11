/// @description Insert description here
// You can write your code in this editor
if (not other.dying) {
	other.hp -= 1;
	audio_play_sound(snd_damage_enemy, 10, false);
	gamepad_set_vibration(0, .75, .75);
	alarm[1] = game_get_speed(gamespeed_fps) * .2;
}

if(instance_exists(obj_player)){
	obj_player.jumping = true;
	obj_player.vsp = -10;
	obj_player.can_double_jump = true;
}







