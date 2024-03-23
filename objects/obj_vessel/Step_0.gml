/// @description Insert description here
// You can write your code in this editor


if (invulnerable and not start_vul) {
	start_vul = true;
	alarm[1] = game_get_speed(gamespeed_fps) * 2;
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
	sprite_index = spr_vessel_wake_1;
}

if (sprite_index == spr_vessel_wake_1 and animation_end()) {
	sprite_index = spr_vessel_wake_2;
	image_index = 0;
}

if (sprite_index == spr_vessel_wake_2 and animation_end()) {
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
	}
}
	


var player = instance_find(obj_player, 0);


//player is close, so overhead (all overhead logic below)
if ((x - 275 < player.x and x + 275 > player.x) and ready_for_overhead and fighting) {
	ready_for_overhead = false;
	overheading = true;
	sprite_index = spr_vessel_overhead_start;
	image_index = 0;
}

if (sprite_index == spr_vessel_overhead_start and animation_end()) {
	sprite_index = spr_vessel_overhead;
	image_index = 0;
	var overhead = instance_create_layer(x, y, "Instances", obj_overhead);
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
		instance_destroy(instance_find(obj_overhead, 0), false);
	}
} 

if (sprite_index == spr_vessel_overhead_end and animation_end()) {
	sprite_index = spr_vessel_idle;
	alarm[0] = game_get_speed(gamespeed_fps) * 10;
}


//player is too far, so jump attack (all jump attack logic below)

if ((x - 800 > player.x and x + 800 < player.x) and ready_for_jump and fighting) {
	ready_for_overhead = false;
	ready_for_jump =  false
	sprite_index = spr_vessel_jump_start;
	image_index = 0;
}


if (sprite_index == spr_vessel_jump_start and animation_end()) {
	sprite_index = spr_vessel_jump;
	image_index = 0;
	vsp = -30;
}

vsp += .9;
if (y + vsp > original_y) {
	// Im going to hit the block so move to block
	while (not y + sign(vsp) >= original_y) {
		y += sign(vsp);
	}
}

if (sprite_index == spr_vessel_jump and animation_end()) {
	sprite_index = spr_vessel_downstab_start;
	image_index = 0;
}

if (sprite_index == spr_vessel_downstab_start and animation_end()) {
	image_speed = 0;
	image_index = 6;
}

if (sprite_index = spr_vessel_downstab_start and y + vsp >= original_y) {
	image_speed = 1;
	sprite_index = spr_vessel_downstab_start;
	image_index = 0;
	var downstab = instance_create_layer(x, y, "Instances", obj_downstab);
}

x += hsp;
y += vsp;