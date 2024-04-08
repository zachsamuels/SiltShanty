/// @description Insert description here
// You can write your code in this editor





if (turning and not dying and not rolling) {
	image_xscale *= -1;
	turning = false;
	dir = dir * -1 ;
}
else if (not dying) {
	var player = instance_find(obj_player, 0);
	if (collision_line(x, y-30, player.x, player.y, obj_block, false, true) == noone and not rolling) {
		if ((player.x < x and dir == -1) or (player.x > x and dir == 1)) {
			rolling = true;
			sprite_index = spr_roller_roll_start;
			image_index = 0;
		}
		else {
			hsp = spd * dir;
		}
	} else if (not rolling) {
			hsp = spd * dir;
	}
	if (rolling and move) {
		hsp = rollspd * dir;
	}
	if (sprite_index == spr_roller_roll_start and animation_end()){
		move = true;
		sprite_index = spr_roller_roll;
		image_index = 0;
	}
	
	if (sprite_index == spr_roller_roll_stop and animation_end()) {
		turning = true;
		sprite_index = spr_roller_walk;
		image_index = 0;
		rolling = false;
	}
	
	if (hsp < 0 ) {
		boxx = bbox_left;
	} else {
		boxx = bbox_right;
	}
	
	
	if (!place_meeting(boxx + hsp*30, y + 10, obj_block) || place_meeting(x + hsp, y-30, obj_block)) {
		if (rolling and not stopping) {
			stopping = true;
			move = false
			hsp = 0;
			sprite_index = spr_roller_roll_stop;
			image_index = 0;
		}
		else {
			turning = true;
			image_index = 0;
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
	

