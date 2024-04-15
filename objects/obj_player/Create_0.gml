/// @description Insert description here
// You can write your code in this editor



global.freeze_game = false;
global.boss_fight = true;
global.boss = "";
hp = 10;
spd = 10;
dmg = 1;
hsp = 0;
vsp = 0;
grounded = false;
jumping = false;
landing = false;
idle = false;
running = false;
falling = false;
attacking = false;
lastdir = 1;
invulnerable = false;
start_vul = false;
dying = false;
can_double_jump = true;
has_double_jump = true;
sound_distance = 1000;
run_start = false;
death_sound = false;
deadzone = .4;
hurt_x = 0;
if (gamepad_is_connected(0)) {
		gamepad_set_axis_deadzone(0, .2);
}
//sprite_collision_mask(spr_player_run, false, 2)
audio_play_sound(snd_background, 10, true);