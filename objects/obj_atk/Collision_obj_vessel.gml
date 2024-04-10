/// @description Insert description here
// You can write your code in this editor



if (not other.invulnerable and not other.dying){
	audio_play_sound(snd_damage_enemy, 10, false);
	other.invulnerable = true;
	other.hp -= 1; 
	audio_play_sound(snd_boss_hit, 10, false);
}





