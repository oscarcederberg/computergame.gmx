//Plays alternating step sfx

if(argument0 == 1){
    audio_play_sound(sfx_step_0, 1, false);
}else{
    audio_play_sound(sfx_step_1, 1, false);
}

return argument0 * -1;
