/// @description Insert description here
// You can write your code in this editor






if ((grounded or (can_double_jump and has_double_jump)) and not global.freeze_game and !dying) {
	if (not grounded) {
		can_double_jump = false;
	}
	vsp = -18;
	sprite_index = spr_player_jump;
	image_index = 0;
	jumping = true;
	audio_play_sound(snd_jump	, 10, false);
}

