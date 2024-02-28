// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function animation_end(){
	// Return whether or not if on this frame, the animation
	// is done
	var sprite = sprite_index;
	var image = image_index;
	
	if (argument_count > 0) {
		sprite = argument[0];
	}
	if (argument_count > 1) {
		image = argument[1];
	}
	
	var type = sprite_get_speed_type(sprite_index);
	var spd = sprite_get_speed(sprite_index) * image_speed;
	if (type == spritespeed_framespersecond) {
		spd /= room_speed;
	}
	
	if (argument_count > 2) {
		spd = argument[2];
	}
	
	return image + spd >= sprite_get_number(sprite);
}