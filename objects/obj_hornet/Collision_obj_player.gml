/// @description Insert description here
// You can write your code in this editor




if (not other.invulnerable and not dying) {
	other.hp -= dmg;
	other.invulnerable = true;
	gamepad_set_vibration(0, 1, 1);
}


