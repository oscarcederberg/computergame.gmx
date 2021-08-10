interact_id = argument0;
window_width = interact_id.window_width;
window_height = interact_id.window_height;
window_type = interact_id.window_type;
window_data = interact_id.window_data;

opt_window_id = scr_window_find_with_file_id(interact_id);

if(opt_window_id == noone){
    scr_window_create(window_width, window_height, window_type, window_data, interact_id);
} else {
    scr_window_set_active(opt_window_id);
}
