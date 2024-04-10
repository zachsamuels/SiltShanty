/// @description Insert description here
// You can write your code in this editor




blinkTimer = (blinkTimer + 1) % (blinkRate * 2); 
if (blinkTimer == 0) {
    visible = !visible;
}

