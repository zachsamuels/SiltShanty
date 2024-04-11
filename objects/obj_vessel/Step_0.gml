/// @description Insert description here
// You can write your code in this editor

if (invulnerable and not dying) {
	image_alpha = .8;
} else {
	image_alpha = 1;
}

if (hp <= 0 and not dying) {
	dying = true;
	sprite_index = spr_vessel_death_start;
	audio_play_sound(snd_vessel_last_hit, 10, false);
	audio_stop_sound(snd_vessel_background);
	image_index = 0;
}

if (dying and sprite_index == spr_vessel_death_start and animation_end()) {
	audio_play_sound(snd_vessel_death, 10, false);
	
	death_shake = true;
	cam_original_x = camera_get_view_x(view_camera[0]);
	cam_original_y = camera_get_view_y(view_camera[0]);
	image_speed = 0;
	shake_duration = 60;
	gamepad_set_vibration(0, .75, .75);
}

if (death_shake) {
	if (shake_duration > 0) {
		if (shake_duration% 15) == 0 {
			var infection = instance_create_layer(x, y, "Instances", obj_infection);
			infection.image_angle = shake_duration*6;
		}
		var _shakeX = irandom_range(-shake_intensity, shake_intensity);
		var _shakeY = irandom_range(-shake_intensity, shake_intensity);

		camera_set_view_pos(view_camera[0], cam_original_x + _shakeX, cam_original_y + _shakeY);

		shake_duration -= 1;
	}
	else {
		camera_set_view_pos(view_camera[0], cam_original_x, cam_original_y);
		death_shake = false;
		sprite_index = spr_vessel_death;
		image_index = 0;
		image_speed = 1;
		gamepad_set_vibration(0, 0, 0);
	}
}

if (dying and sprite_index == spr_vessel_death and animation_end() and not dead) {
	image_speed = 0;
	dead = true;
	camera_set_view_border(view_camera[0], 500, 300)
	audio_play_sound(snd_background2, 10, true);
	var monarch = instance_create_layer(obj_player.x, y-500, "Instances", obj_monarch_wings);
	monarch.image_xscale = .3;
	monarch.image_yscale = .3;
	
}

if (not dying) {
	if (invulnerable and not start_vul) {
		start_vul = true;
		alarm[1] = game_get_speed(gamespeed_fps) * .25;
	}

	var cam = view_camera[0];
	var cam_x = camera_get_view_x(cam);
	var cam_y = camera_get_view_y(cam);
	var cam_width = camera_get_view_width(cam);
	var cam_height = camera_get_view_height(cam);
	var in_viewport = bbox_right > cam_x && bbox_left < cam_x + cam_width- 250 &&
	                  bbox_bottom > cam_y && bbox_top < cam_y + cam_height;
	if (in_viewport and not awake) {
		awake = true;
		global.freeze_game = true;
		obj_player.sprite_index = spr_player_idle;
		sprite_index = spr_vessel_wake_1;
		audio_stop_sound(snd_background);
		audio_play_sound(snd_vessel_background, 10, true);
	}

	if (sprite_index == spr_vessel_wake_1 and animation_end()) {
		sprite_index = spr_vessel_wake_2;
		image_index = 0;
	}

	if (sprite_index == spr_vessel_wake_2 and animation_end()) {
		audio_play_sound(snd_roar, 10, false);
		sprite_index = spr_vessel_wake_3;
		image_index = 0;
	}

	if (sprite_index == spr_vessel_wake_3 and animation_end()) {
		sprite_index = spr_vessel_roar_start;
		image_index = 0;
	}

	if (sprite_index == spr_vessel_roar_start and animation_end()) {
		sprite_index = spr_vessel_roar;
		image_index = 0;
		roaring = true;
		cam_original_x = camera_get_view_x(view_camera[0]);
		cam_original_y = camera_get_view_y(view_camera[0]);
	}
	
	if (roaring) {
		gamepad_set_vibration(0, 1, 1);
		if (shake_duration > 0) {
		    var _shakeX = irandom_range(-shake_intensity, shake_intensity);
		    var _shakeY = irandom_range(-shake_intensity, shake_intensity);

		    camera_set_view_pos(view_camera[0], cam_original_x + _shakeX, cam_original_y + _shakeY);

		    shake_duration -= 1;
		}
		else {
		    // Optionally, reset the camera to its original position
		    camera_set_view_pos(view_camera[0], cam_original_x, cam_original_y);
			global.freeze_game = false;
			global.boss_fight = true;
			fighting = true;
			global.boss = "vessel";
			camera_set_view_border(cam, 0, 0)
			sprite_index = spr_vessel_idle;
		
			image_index = 0;
			roaring = false;
			gamepad_set_vibration(0, 0, 0);
		}
	}
	


	var player = instance_find(obj_player, 0);


	//player is close, so overhead (all overhead logic below)
	if ((x - 275 < player.x and x + 275 > player.x) and ready_for_overhead and fighting and not jumping) {
		ready_for_overhead = false;
		overheading = true;
		sprite_index = spr_vessel_overhead_start;
		image_index = 0;
	}

	if (sprite_index == spr_vessel_overhead_start and animation_end()) {
		sprite_index = spr_vessel_overhead;
		image_index = 0;
		var overhead = instance_create_layer(x, y, "Instances", obj_overhead);
		audio_play_sound(snd_vessel_sword, 10, false);
		alarm[3] = game_get_speed(gamespeed_fps) * .5
		make_overhead = true;
	}

	if (sprite_index == spr_vessel_overhead) {
		if (image_index == 3 or image_index = 4) {
			instance_find(obj_overhead, 0).image_index = 2;
			image_alpha = 0;
		}
		else if (image_index == 8 or image_index = 9) {
			instance_find(obj_overhead, 0).image_index = 5;
			image_alpha = 0;
		} else {
			image_alpha = 1;
		}
	}

	if (sprite_index == spr_vessel_overhead and animation_end()) {
		if (overhead_num < 3) {
			overhead_num += 1;
		}
		else {
			sprite_index = spr_vessel_overhead_end;
			image_index = 0;
			overhead_num = 0;
			make_overhead = false;
			instance_destroy(instance_find(obj_overhead, 0), false);
			audio_stop_sound(snd_vessel_sword);
		}
	} 

	if (sprite_index == spr_vessel_overhead_end and animation_end()) {
		sprite_index = spr_vessel_idle;
		alarm[0] = game_get_speed(gamespeed_fps) * 4;
		overheading = false;
	}


	//player is too far, so jump attack (all jump attack logic below)

	if ((x - 600 > player.x or x + 600 < player.x) and ready_for_jump and fighting and not overheading) {
		ready_for_jump =  false
		jumping = true;
		sprite_index = spr_vessel_jump_start;
		image_index = 0;
		audio_play_sound(snd_vessel_down_start, 10, false);
	}


	if (sprite_index == spr_vessel_jump_start and animation_end()) {
		audio_play_sound(snd_vessel_jump, 10, false);
		sprite_index = spr_vessel_jump;
		image_index = 0;
		vsp = -30;
		if (player.x - x > 0) {
			hsp = 35;
		} else {
			hsp = -35;
		}
	}

	if (abs(hsp) > 1 and (x > left and x < right)) {
		hsp -= .9 * sign(hsp);
	} else if ( x < left and fighting and not overheading and not jumping) {
		hsp = spd;
	} else if ( x > right and fighting and not overheading and not jumping) {
		hsp = -spd;
	} else if (player.x - x > 10 and fighting and not overheading and not jumping) {
		hsp = spd;
	} else if (player.x - x < -10 and fighting and not overheading and not jumping) {
		hsp = -spd;
	} else {
		hsp = 0;
	}

	vsp += .9;
	
	if (y + vsp > original_y) {
		// Im going to hit the block so move to block
		while (not y + sign(vsp) >= original_y) {
			y += sign(vsp);
		}
		vsp = 0;
	}

	if (sprite_index == spr_vessel_jump and animation_end()) {
		sprite_index = spr_vessel_downstab_start;
		image_index = 0;
	}

	if (sprite_index == spr_vessel_downstab_start and animation_end()) {
		ready_to_land = true;
	}

	if (ready_to_land) {
		image_index = 6;
	}

	if (ready_to_land and y + 30 >= original_y) {
		ready_to_land = false;
		audio_play_sound(snd_vessel_downstab, 10, false);
		sprite_index = spr_vessel_downstab;
		image_index = 0;
		var downstab = instance_create_layer(x, y, "Instances", obj_downstab);
	}

	if (sprite_index == spr_vessel_downstab and animation_end()) {
		sprite_index = spr_vessel_idle;
		image_index = 0;
		alarm[2] = game_get_speed(gamespeed_fps) * 5;
		jumping = false;
	}

	if (hsp > 0) {
		image_xscale = 1;
	} else {
		image_xscale = -1;
	}
	x += hsp;
	y += vsp;
}