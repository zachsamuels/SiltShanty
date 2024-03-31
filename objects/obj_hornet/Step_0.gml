/// @description Insert description here
// You can write your code in this editor

if (invulnerable and not dying) {
	image_alpha = .8;
} else {
	image_alpha = 1;
}
if (invulnerable and not start_vul) {
	start_vul = true;
	alarm[2] = game_get_speed(gamespeed_fps) * .25;
}

if (hp <= 0 and not dying) {
	dying = true;
	sprite_index = spr_hornet_wounded;
	image_index = 0;
}

else if (sprite_index == spr_hornet_wounded and animation_end()) {
	sprite_index = spr_hornet_stunned;
	image_index = 0;
}
else if (sprite_index == spr_hornet_stunned and animation_end()) {
	sprite_index = spr_hornet_leave;
	image_index = 0;
}
else if (sprite_index == spr_hornet_leave and animation_end()){
	instance_destroy(id, true);
}

if (not dying) {
	player_left = obj_player.x < x;
	if (not dashing) {
		if (player_left) {
			image_xscale = 1;
		} else {
			image_xscale = -1;
		}
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
		sprite_index = spr_hornet_flourish;
		camera_set_view_border(cam, 0, 0)
	}
	
	if (sprite_index == spr_hornet_flourish and animation_end()) {
		sprite_index = spr_hornet_idle;
		image_index = 0;
		fighting = true;
		ready_to_counter = true;
		ready_to_dash = true;
	}
	
	if (fighting and ready_to_dash and (x < dash_left or x > dash_right) and not countering) {
		dashing = true;
		ready_to_dash = false;
		sprite_index = spr_hornet_dash_start;
		image_index = 0;	 
	}
	
	if (sprite_index == spr_hornet_dash_start and animation_end()) {
		var dash = instance_create_layer(x, y, "Instances", obj_dash);
		sprite_index = spr_hornet_dash;
		image_index = 0;
		if (player_left) {
			hsp = -40;
		} else {
			hsp = 40;
		}
		alarm[0]= game_get_speed(gamespeed_fps) * .4;
	}
	
	else if (sprite_index = spr_hornet_dash and image_index == 1) {
		image_speed = 0;
	}
	
	else if (sprite_index == spr_hornet_dash_end and animation_end()) {
		sprite_index = spr_hornet_idle;
		image_index = 0;
		dashing = false;
		alarm[1] = game_get_speed(gamespeed_fps) * 10;
	}
	
	if ((x - 200 < obj_player.x and x + 200 > obj_player.x) and ready_to_counter and not dashing) {
		countering = true;
		ready_to_counter = false;
		sprite_index = spr_hornet_counter_start;
		image_index = 0;
	}
	
	if (sprite_index == spr_hornet_counter_start and animation_end()) {
		sprite_index = spr_hornet_counter;
		image_index = 0;
	}
	
	else if (sprite_index == spr_hornet_counter) {
		if (countered) {
			sprite_index = spr_hornet_counter_hit;
			image_index = 0;
			counters = 0;
		}
		else if (counters > 8) {
			sprite_index = spr_hornet_counter_failed;
			image_index = 0;
			counters = 0;
		} else if (animation_end()) {
			counters += 1;
		}	
	}
	
	else if (sprite_index == spr_hornet_counter_failed and animation_end()) {
		sprite_index = spr_hornet_idle;
		image_index = 0;
		countering = false;
		alarm[3] = game_get_speed(gamespeed_fps) * 10;
	}
	
	else if (sprite_index == spr_hornet_counter_hit and animation_end()) {
		sprite_index = spr_hornet_countering_1;
		image_index = 0;
		alarm[4] = game_get_speed(gamespeed_fps) * .1;
	}
	
	
	else if (sprite_index == spr_hornet_countering_end) {
		sprite_index = spr_hornet_idle;
		image_index = 0;
		countering = false;
		countered = false;
		alarm[3] = game_get_speed(gamespeed_fps) * 10;
	}
	
	x += hsp;
	y += vsp;
	
}