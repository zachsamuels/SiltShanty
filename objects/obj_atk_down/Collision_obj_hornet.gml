/// @description Insert description here
// You can write your code in this editor



if (not other.invulnerable and not other.dying) {
	if (other.countering) {
		other.countered = true;
	} else {
		other.hp -= dmg;
		other.invulnerable = true;
	}
		audio_play_sound(snd_boss_hit, 10, false);
		audio_play_sound(snd_hornet_hurt, 10, false);
}

if(instance_exists(obj_player)){
	obj_player.jumping = true;
	obj_player.vsp = -10;
	obj_player.can_double_jump = true;
}
