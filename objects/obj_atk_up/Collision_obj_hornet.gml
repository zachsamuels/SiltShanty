/// @description Insert description here
// You can write your code in this editor





if (not other.invulnerable and not other.dying) {
	if (other.countering) {
		other.countered = true;
	} else {
		other.hp -= dmg;
		other.invulnerable = true;
		audio_play_sound(snd_boss_hit, 10, false);
		audio_play_sound(snd_hornet_hurt, 10, false);
		gamepad_set_vibration(0, .75, .75);
		alarm[1] = game_get_speed(gamespeed_fps) * .2;

	}
}

