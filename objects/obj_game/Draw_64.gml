/// @description Insert description here
// You can write your code in this editor

if(instance_exists(obj_player)){
	for(var i = 0; i < obj_player.hp; i++){
    draw_sprite(spr_player_hp,-1, 10 + (i * 100), 10);
	}
}






