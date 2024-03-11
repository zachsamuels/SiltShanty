/// @description Insert description here
// You can write your code in this editor


if (not other.invulnerable and not hit) {
	speed = 0;
	sprite_index = spr_bullet_hit;
	image_index = 0;
	hit = true;
	other.hp -= 1;
	other.invulnerable = true;
}
