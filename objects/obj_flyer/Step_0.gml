/// @description Insert description here
// You can write your code in this editor



if (firing) {
	if (animation_end()) {
		alarm[1] = game_get_speed(gamespeed_fps) * 3;
	}
}


if (hp <= 0 and not dying) {
	dying = true;
	sprite_index = spr_flyer_death;
}

if (dying) {
	if (animation_end()) {
		instance_destroy(id, true);
	}
}