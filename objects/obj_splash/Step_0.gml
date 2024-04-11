/// @description Insert description here
// You can write your code in this editor




blinkTimer = (blinkTimer + 1) % (blinkRate * 2); 
if (blinkTimer == 0) {
    visible = !visible;
}

for (i=gp_face1; i<gp_axisrv; i++){
    if gamepad_button_check(0, i){
        room_goto_next();
    }
}