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

	var keyleft = keyboard_check(vk_left);
	var keyright = keyboard_check(vk_right);
	var keyup = keyboard_check(vk_up);
	var keydown = keyboard_check(vk_down);
	var keyspace = keyboard_check(vk_space);
	var attack;

	var moving = keyright - keyleft;
	hsp = spd * moving;

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

