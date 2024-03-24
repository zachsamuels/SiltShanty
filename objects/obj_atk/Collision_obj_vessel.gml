/// @description Insert description here
// You can write your code in this editor



if (not other.invulnerable){
	audio_play_sound(snd_damage_enemy, 10, false);
	other.vulnerable = false;
	other.hp -= 1; 
}





