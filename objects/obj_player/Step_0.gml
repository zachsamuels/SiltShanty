/// @description Insert description here
// You can write your code in this editor



if (invulnerable and not start_vul) {
	start_vul = true;
	image_alpha = .8
	alarm[1] = game_get_speed(gamespeed_fps) * 2;
}


var keyleft = keyboard_check(vk_left);
var keyright = keyboard_check(vk_right);

var moving = keyright - keyleft;
hsp = spd * moving;

if (moving != 0) {
	sprite_index = spr_player_run;
	image_xscale = moving;
} else {
	if (not jumping and grounded) {
		sprite_index = spr_player_idle;
	}
}

//check for collision with an obj_block

if (place_meeting(x + hsp, y, obj_block)) {
	// Im going to hit the block so move to block
	while (not place_meeting(x + sign(hsp), y, obj_block)) {
		x += sign(hsp);
	}
	hsp = 0;
}


// vert collision
vsp += .9;
if (place_meeting(x, y + vsp, obj_block)) {
	// Im going to hit the block so move to block
	while (not place_meeting(x, y+ sign(vsp), obj_block)) {
		y += sign(vsp);
	}
	vsp = 0;
	grounded = true
	if (not landing and falling) {
		falling = false;
		landing = true;
		sprite_index = spr_player_land;	
		image_index = 0;
		}
} else {
	grounded = false;
	if (not jumping and not falling) {
		falling = true;
		sprite_index = spr_player_fall;
		image_index = 0;
	}
}

if (landing) {
	if (animation_end()) {
		landing = false;
	}
}

if (jumping) {
	if (animation_end()) {
		jumping = false;
	}
}
x += hsp;
y += vsp;
