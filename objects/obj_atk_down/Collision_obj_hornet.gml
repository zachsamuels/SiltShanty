/// @description Insert description here
// You can write your code in this editor



if (not other.invulnerable and not other.dying) {
	other.hp -= dmg;
	other.invulnerable = true;
}

if(instance_exists(obj_player)){
	obj_player.jumping = true;
	obj_player.vsp = -18;
	obj_player.can_double_jump = true;
}
