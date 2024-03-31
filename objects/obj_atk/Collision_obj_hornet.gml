/// @description Insert description here
// You can write your code in this editor





if (not other.invulnerable and not other.dying) {
	if (other.countering) {
		other.countered = true;
	} else {
		other.hp -= dmg;
		other.invulnerable = true;
		audio_play_sound(snd_damage_enemy, 10, false);
	}
}

