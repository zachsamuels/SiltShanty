/// @description Insert description here
// You can write your code in this editor

if(dying){
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
		sprite_index = spr_player_land;	
		image_index = 0;
		}
		
} else {
	grounded = false;
	if (not jumping and not falling) {
		falling = true;
		sprite_index = spr_player_fall;
		image_index = 0;
	}
}

if(attacking and animation_end()){
	attacking = false;
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
		if (up_down == 0) {
			var keyup = 0;
			var keydown = 0;
		} else if (up_down > 0) {
			var keyup = 0;
			var keydown = 1;
		} else {
			var keyup = 1;
			var keydown = 0;
		}
		var keyspace = gamepad_button_check_pressed(0, gp_face3);
		var controller_jump = gamepad_button_check_pressed(0, gp_face1);
		if (gamepad_button_check_pressed(0, gp_shoulderl)) {
			has_double_jump = true;
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
			if(keyspace != 0){
				attacking = true;
				if(keydown == 0){
					sprite_index = spr_player_atk;
					if(-lastdir < 0){
						attack = instance_create_layer(x + 40, y, "Instances", obj_atk);
					}
					else{
						attack = instance_create_layer(x - 40, y, "Instances", obj_atk);
					}
					attack.image_xscale = -lastdir;
				} else if (keydown == 1 and !grounded){
					sprite_index = spr_player_atk_down;
					attack = instance_create_layer(x, y + 100, "Instances", obj_atk_down);
					
				}
			}
		} else {
			if(keyspace != 0){
				attacking = true;
				if(keydown == 0){
					sprite_index = spr_player_atk;
					if(-lastdir < 0){
						attack = instance_create_layer(x + 40, y, "Instances", obj_atk);
					}
					else{
						attack = instance_create_layer(x - 40, y, "Instances", obj_atk);
					}
					attack.image_xscale = -lastdir;
				} else if (keydown == 1 and !grounded){
					sprite_index = spr_player_atk_down;
					attack = instance_create_layer(x, y + 100, "Instances", obj_atk_down);
					
				}
			}
			else if (not jumping and grounded) {
				sprite_index = spr_player_idle;
			}
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
	}
	
}

