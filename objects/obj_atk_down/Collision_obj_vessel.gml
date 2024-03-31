/// @description Insert description here
// You can write your code in this editor





if (not other.invulnerable and not other.dying){
	audio_play_sound(snd_damage_enemy, 10, false);
	other.invulnerable = true;
	other.hp -= 1; 
}

if(instance_exists(obj_player)){
	obj_player.jumping = true;
	obj_player.vsp = -10;
	obj_player.can_double_jump = true;
}


