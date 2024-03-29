/// @description Insert description here
// You can write your code in this editor



if (not dying) {
	var cam = view_camera[0];
	var cam_x = camera_get_view_x(cam);
	var cam_y = camera_get_view_y(cam);
	var cam_width = camera_get_view_width(cam);
	var cam_height = camera_get_view_height(cam);
	var in_viewport = bbox_right > cam_x && bbox_left < cam_x + cam_width- 400 &&
	                  bbox_bottom > cam_y && bbox_top < cam_y + cam_height;
	if (in_viewport and not awake) {
		awake = true;
		sprite_index = spr_hornet_flourish;
		camera_set_view_border(cam, 0, 0)
	}
	
	if (sprite_index == spr_hornet_flourish and animation_end()) {
		sprite_index = spr_hornet_idle;
		image_index = 0;
		
	}
}