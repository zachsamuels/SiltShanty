/// @description Insert description here
// You can write your code in this editor




if (dying and animation_end()) {
	instance_destroy(id, true);
} else if (not dying) {
	var player = instance_find(obj_player, 0);

	if (player.x > x and image_xscale == 1 and not firing) {
		image_xscale = -1;
		turning = true;
		image_index = 0;
		sprite_index = spr_flyer_turn;
	} else if (player.x < x and image_xscale == -1 and not firing) {
		image_xscale = 1;
		turning = true;
		image_index = 0;
		sprite_index = spr_flyer_turn;
	}

	if (collision_line(x, y, player.x, player.y, obj_block, false, true) == noone and not firing and can_fire) {
		firing = true;
		can_fire = false;
		sprite_index = spr_flyer_fire;
		image_index = 0;
	}

	if (firing and animation_end()) {
		firing = false;
		image_index = 0;
		sprite_index = spr_flyer_fly;
		alarm[1] = game_get_speed(gamespeed_fps) * 1;
	}

	if (firing and image_index == 9) {
		audio_play_sound(snd_flyer_shoot, 10, false);
		instance_create_layer(x, y, "Instances", obj_bullet);
	}

	if (turning and animation_end()) {
		turning = false
		image_index = 0;
		sprite_index = spr_flyer_fly;
	}


	if (hp <= 0 and not dying) {
		image_index = 0;
		sprite_index = spr_flyer_death;
		dying = true;
		audio_stop_sound(snd_flyer);
	}

} else {
	path_speed = 0;
}

