/// @description Insert description here
// You can write your code in this editor





var hornet = instance_find(obj_hornet, 0);
image_xscale = hornet.image_xscale;

if (hornet.dying or animation_end()) {
	instance_destroy(id, false);
}




