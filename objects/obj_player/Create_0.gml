/// @description Insert description here
// You can write your code in this editor



global.freeze_game = false;
global.boss_fight = true;
global.boss = "";
hp = 3;
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

//sprite_collision_mask(spr_player_run, false, 2)