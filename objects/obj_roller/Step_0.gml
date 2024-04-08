/// @description Insert description here
// You can write your code in this editor





if (turning and not dying and not rolling) {
	image_xscale *= -1;
	turning = false;
	dir = dir * -1 ;
}
else if (not dying) {
	var player = instance_find(obj_player, 0);
	if (collision_line(x, y-30, player.x, player.y, obj_block, false, true) == noone and not rolling and ready_to_roll) {
		if ((player.x < x and dir == -1) or (player.x > x and dir == 1)) {
			rolling = true;
			ready_to_roll = false;
			sprite_index = spr_roller_roll_start;
			image_index = 0;
		}
	}
	if (not rolling) {
		hsp = spd * dir;
		sprite_index = spr_roller_walk;
	}
	else if (rolling and move) {
		hsp = rollspd * dir;
	}
	if (sprite_index == spr_roller_roll_start and animation_end()){
		move = true;
		sprite_index = spr_roller_roll;
		image_index = 0;
	}
	
	if (sprite_index == spr_roller_roll_stop and animation_end()) {
		stopping = false;
		rolling = false;
		turning = true;
		sprite_index = spr_roller_walk;
		alarm[0] = game_get_speed(gamespeed_fps) * .1;
	}
	
	
	if (hsp < 0 ) {
		boxx = bbox_left;
	} else {
		boxx = bbox_right;
	}
	if ((!place_meeting(boxx + hsp*30, y + 10, obj_block) and not rolling) or (!place_meeting(boxx, y + 10, obj_block) and rolling) or (place_meeting(boxx-hsp*3, y-30, obj_block) and rolling) or (place_meeting(boxx + hsp, y-30, obj_block) and not rolling) and hsp != 0) {
		if (rolling and not stopping) {
			stopping = true;
			move = false
			hsp = 0;
			sprite_index = spr_roller_roll_stop;
			image_index = 0;
		}
		else if (not rolling){
			turning = true;
		}
	} else {
		x += hsp;
	}

}

if(hp <= 0 and not dying){
	dying = true;
	sprite_index = spr_roller_death;
	image_index = 0;
}

if (dying and animation_end()) {
	instance_destroy(id, true);
}
	

