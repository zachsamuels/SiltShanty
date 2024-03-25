/// @description Insert description here
// You can write your code in this editor





if (animation_end()) {
	instance_destroy(id, false);
}

var vessel = instance_find(obj_vessel, 0);

if (vessel.dying) {
	instance_destroy(id, false);
}


