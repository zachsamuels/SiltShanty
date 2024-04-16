/// @description Insert description here
// You can write your code in this editor

if(instance_exists(obj_player)){
	for(var i = 0; i < obj_player.hp; i++){
		draw_sprite(spr_player_hp,-1, 10 + (i * 100), 10);
	}
	if(obj_player.hp <= 0){
		obj_player.dying = true;
		if(!dead){
			obj_player.y += 15;
			dead = true;
		}
		
	}
}

if(room == Level1){
	draw_text(440, 3550, "Left & Right Arrows/ Left Stick to Move");
}





