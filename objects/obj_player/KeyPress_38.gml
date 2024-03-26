/// @description Insert description here
// You can write your code in this editor




if (grounded and not global.freeze_game and !dying and !invulnerable) {
	vsp = -18;
	sprite_index = spr_player_jump;
	image_index = 0;
	jumping = true;
	audio_play_sound(snd_jump	, 10, false);
}

