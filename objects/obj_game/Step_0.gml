/// @description Insert description here
// You can write your code in this editor

if(room == Level1 and obj_player.x > 4250){
	room_goto(Level2);
}

if(room == Level2 and obj_player.x > 6300 and instance_find(obj_hornet, 0) == noone){
	room_goto(Ending);
}

if(room == Level2 and obj_player.x < - 30){
	room_goto(Level1);
	obj_player.x = 4100;
	obj_player.y = 2075;
}



