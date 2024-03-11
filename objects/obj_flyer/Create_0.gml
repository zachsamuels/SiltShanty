/// @description Insert description here
// You can write your code in this editor



hp = 1;
dmg = 1;
spd = 2;
firing = false;
dying = false;
can_fire = true;
turning = false;

//[0] = game_get_speed(gamespeed_fps) * 3;
path_start(pth_flyer_1, spd, path_action_restart, false);