/// @description Insert description here
// You can write your code in this editor




if (place_meeting(x, y + vsp, obj_block)) {
	// Im going to hit the block so move to block
	while (not place_meeting(x, y+ sign(vsp), obj_block)) {
		y += sign(vsp);
	}
	vsp = 0;
	audio_stop_sound(snd_monarch_fall);
	audio_play_sound(snd_monarch_land, 10, false);
}
y += vsp;


