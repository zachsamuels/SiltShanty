/// @description Insert description here
// You can write your code in this editor

hsp = 0;
hp = 1;
dmg = 1;
dying = false;
turning = false;
spd = 1;
dir = -1;
dmg = 1;
left = false;
rolling = false;
rollspd = 10;
move = false;
stopping = false;
ready_to_roll = true;


audio_play_sound(snd_crawler, 10, false);
alarm[0] = game_get_speed(gamespeed_fps) * 3.52
