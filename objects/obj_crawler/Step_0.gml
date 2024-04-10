/// @description Insert description here
// You can write your code in this editor




if (turning and not dying) {
	if (animation_end()) {
		sprite_index = spr_crawler_crawl;
		image_index = 0;
		image_xscale *= -1;
		turning = false;
		dir = dir * -1 ;
}
} else if (not dying) {
	hsp = spd * dir;
	if (hsp < 0 ) {
		var boxx = bbox_left;
	} else {
		var boxx = bbox_right;
	}
	if (!place_meeting(boxx + hsp*30, y + 10, obj_block) || place_meeting(x + hsp, y-30, obj_block)) {
		turning = true;
		sprite_index = spr_crawler_turn;
		image_index = 0;
	} else {
		x += hsp;
	}
}

if(hp <= 0 and not dying){
	dying = true;
	sprite_index = spr_crawler_death;
	audio_stop_sound(snd_crawler);
	image_index = 0;
}

if (dying and animation_end()) {
	instance_destroy(id, true);
	
}
	
