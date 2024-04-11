/// @description Insert description here
// You can write your code in this editor

if(dying){
	if (not death_sound) {
		audio_play_sound(snd_player_death, 10, false);
		death_sound = true;
	}
	sprite_index = spr_player_die;
	vsp = 10;
	if (place_meeting(x, y + vsp, obj_block)) {
	// Im going to hit the block so move to block
	while (not place_meeting(x, y+ sign(vsp), obj_block)) {
		y += sign(vsp);
	}
	
	}
	if(animation_end()){
		image_index = 3;
		
	}
}
else {
// vert collision
vsp += .9;
if (place_meeting(x, y + vsp, obj_block)) {
	// Im going to hit the block so move to block
	while (not place_meeting(x, y+ sign(vsp), obj_block)) {
		y += sign(vsp);
	}
	vsp = 0;
	grounded = true
	can_double_jump = true;
	if (not landing and falling) {
		falling = false;
		landing = true;
		gamepad_set_vibration(0, .5, .5);
		alarm[2] = game_get_speed(gamespeed_fps) * .1;
		sprite_index = spr_player_land;	
		image_index = 0;
		audio_play_sound(snd_land, 10, false);
		audio_stop_sound(snd_falling);
		}
		
} else {
	grounded = false;
	if (not jumping and not falling) {
		audio_play_sound(snd_falling, 10, true);
		falling = true;
		sprite_index = spr_player_fall;
		image_index = 0;
	}
}



if (landing) {
	if (animation_end()) {
		landing = false;
	}
}

if (jumping) {
	if (animation_end()) {
		jumping = false;
	}
}
y += vsp;
if not (global.freeze_game) {
	if (invulnerable) {
		if(not start_vul){
			start_vul = true;
			image_alpha = .8
			alarm[1] = game_get_speed(gamespeed_fps) * 2;
			audio_play_sound(snd_damage_player, 10, false);
			gamepad_set_vibration(0, .75, .75);
			alarm[2] = game_get_speed(gamespeed_fps) * .2;
			sprite_index = spr_player_hurt;
			vsp = -14;
			
		} 
		//x += 5;
	}

	
	
	
	if (gamepad_is_connected(0)) {
		var moving_controller = gamepad_axis_value(0, gp_axislh);
		if (moving_controller == 0) {
			var moving = 0;
		} else if (moving_controller > 0){
			var moving = 1;
		} else {
			var moving = -1;
		}
		var up_down = gamepad_axis_value(0, gp_axislv);
		var keyup = 0;
		var keydown = 0
		if (up_down > deadzone) {
			var keyup = 0;
			var keydown = 1;
		} else if (up_down < -deadzone) {
			var keyup = 1;
			var keydown = 0;
		}
		var keyspace = gamepad_button_check_pressed(0, gp_face3);
		var controller_jump = gamepad_button_check_pressed(0, gp_face1);
		if (gamepad_button_check_pressed(0, gp_shoulderl)) {
			has_double_jump = true;
		}
		if (controller_jump) {
			if ((grounded or (can_double_jump and has_double_jump)) and not global.freeze_game and !dying) {
				if (not grounded) {
					can_double_jump = false;
					audio_play_sound(snd_double_jump, 10, false);
				}
				else {
					audio_play_sound(snd_jump, 10, false);
				}
				vsp = -18;
				sprite_index = spr_player_jump;
				image_index = 0;
				jumping = true;
				
			}
		}
	} else {
		var keyleft = keyboard_check(vk_left);
		var keyright = keyboard_check(vk_right);
		var moving = keyright - keyleft;
		var keyup = keyboard_check(vk_up);
		var keydown = keyboard_check(vk_down);
		var keyspace = keyboard_check(ord("C"));
	}
	/*if (controller_jump) {
		if ((grounded or (can_double_jump and has_double_jump)) and not global.freeze_game and !dying) {
			if (not grounded) {
				can_double_jump = false;
			}
			vsp = -18;
			sprite_index = spr_player_jump;
			image_index = 0;
			jumping = true;
			audio_play_sound(snd_jump	, 10, false);
		}
	}*/
	
	hsp = spd * moving;
	
	var attack;
	
	if(!attacking){
		if (moving != 0) {
			sprite_index = spr_player_run;
			image_xscale = moving * 1.3;
			lastdir = moving;
		}else if (not jumping and grounded) {
			sprite_index = spr_player_idle;
		}
			if(keyspace != 0 and not attacking){
				attacking = true;
				gamepad_set_vibration(0, .5, .5);
				alarm[2] = game_get_speed(gamespeed_fps) * .05;
				if(keydown == 0 and keyup == 0){
					if (not instance_exists(obj_atk)) {
						sprite_index = spr_player_atk;
						if(-lastdir < 0){
							attack = instance_create_layer(x + 40, y, "Instances", obj_atk);
						}
						else{
							attack = instance_create_layer(x - 40, y, "Instances", obj_atk);
						}
						attack.image_xscale = -lastdir;
					}
				} else if (keydown == 1 and !grounded){
					if (not instance_exists(obj_atk_down)) {
						sprite_index = spr_player_atk_down;
						attack = instance_create_layer(x, y + 100, "Instances", obj_atk_down);
					}
					
				} else if (keyup == 1){
					if (not instance_exists(obj_atk_up)) {
						attack = instance_create_layer(x + 20, y - 50, "Instances", obj_atk_up);
					}
					
				}
				alarm[3] = game_get_speed(gamespeed_fps) * .4
			} 
	}

	//Make bool variable for attacking and check if atk is at last frame before changing back
	//check for collision with an obj_block

	if (place_meeting(x + hsp, y, obj_block)) {
		// Im going to hit the block so move to block
		while (not place_meeting(x + sign(hsp), y, obj_block)) {
			x += sign(hsp);
		}
		hsp = 0;
	}
	x += hsp;
	if (hsp != 0 and grounded and not run_start) {
		run_start = true;
		audio_play_sound(snd_player_run, 10, true);
	} else if (hsp == 0 or not grounded) {
		audio_stop_sound(snd_player_run);
		run_start = false;
	}
	}
	
}


var flyer = instance_nearest(x, y, obj_flyer);
var crawler  = instance_nearest(x, y, obj_crawler);
var roller = instance_nearest(x, y, obj_roller);

if (flyer != noone) {
	d = sqrt(sqr((flyer.x-x)) + sqr((flyer.y - y)))

	if (d < sound_distance) {
		var volume = 1 - (d / sound_distance);
	} else {
		var volume = 0;
	}
	audio_sound_gain(snd_flyer, volume, 0);
	audio_sound_gain(snd_flyer_shoot, volume, 0);
}


if (crawler != noone) {
	d = sqrt(sqr((crawler.x-x)) + sqr((crawler.y - y)))
	if (roller != noone) {
		rollerd = sqrt(sqr((roller.x-x)) + sqr((roller.y - y)))
		d = min(d, rollerd);
	}
	
	
	
	
	if (d < sound_distance) {
		var volume = 1 - (d / sound_distance);
	} else {
		var volume = 0;
	}
	audio_sound_gain(snd_crawler, volume, 0);
}


if (roller != noone) {
	d = sqrt(sqr((roller.x-x)) + sqr((roller.y - y)))

	if (d < sound_distance) {
		var volume = 1 - (d / sound_distance);
	} else {
		var volume = 0;
	}
	audio_sound_gain(snd_roller_curl, volume, 0);
	audio_sound_gain(snd_rolling, volume, 0);
	audio_sound_gain(snd_roller_hit_wall, volume, 0);
}