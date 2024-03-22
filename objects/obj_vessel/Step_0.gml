/// @description Insert description here
// You can write your code in this editor



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
		global.boss = "vessel";
		camera_set_view_border(cam, 0, 0)
		sprite_index = spr_vessel_idle;
		
		image_index = 0;
		roaring = false;
	}
}
	


