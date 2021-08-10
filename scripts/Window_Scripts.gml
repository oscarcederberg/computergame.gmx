#define Window_Scripts


#define scr_window_create
///scr_window_create(width, height, type, data, file_id);
window_width = argument0;
window_height = argument1;
window_type = argument2;
window_data = argument3;
file_id = argument4;

pixel_width = (window_width+2)*16;
pixel_height = (window_height+2)*16;
random_x = irandom_range(view_xview[0], view_xview[0]+view_wview[0]-pixel_width);
random_y = irandom_range(view_yview[0]+16, view_yview[0]+view_hview[0]-16-pixel_height);

var window_id;
switch(string_lower(window_type)){
    case "text":
        window_id = instance_create(random_x,random_y,obj_window_1_text);
        window_id.lines = scr_string_to_lines(window_data, window_width);
        break;
    case "image":
        window_id = instance_create(random_x,random_y,obj_window_1_image);
        window_id.image_id = asset_get_index(window_data);
        break;
    default:
        window_id = noone;
        break;
}
window_id.width = window_width;
window_id.height = window_height;
window_id.type = window_type;
window_id.data = window_data;
window_id.file_id = file_id;
scr_window_scrollbar_check(window_id);

if(window_id != noone){
    ds_list_add(ctrl_window_handler.open_windows, window_id);
    scr_window_set_active(window_id);
}
return window_id;

#define scr_window_delete
///scr_window_delete(window_id);
window_id = argument0;

index = ds_list_find_index(ctrl_window_handler.open_windows, window_id);
ds_list_delete(ctrl_window_handler.open_windows, index);
instance_destroy(window_id);
scr_window_update_depths();

#define scr_window_set_active
///scr_window_set_active(window_id);
window_id = argument0;

ctrl_window_handler.active_window = window_id;
index = ds_list_find_index(ctrl_window_handler.open_windows, window_id);
ds_list_delete(ctrl_window_handler.open_windows, index);
ds_list_add(ctrl_window_handler.open_windows, window_id);
scr_window_update_depths();

#define scr_window_is_active
///scr_window_is_active(window_id);
return ctrl_window_handler.active_window == argument0;

#define scr_window_find_with_file_id
///scr_window_find_with_file_id(file_id);
file_id = argument0;

var i,size;
size = ds_list_size(ctrl_window_handler.open_windows);
for (i = 0; i < size; i += 1){
    window_id = ds_list_find_value(ctrl_window_handler.open_windows, i);
    if(window_id.file_id = file_id){
        return window_id;
        break;
    }
}
return noone;

#define scr_window_update_depths
///scr_window_update_depths();
var i,d,size;
d = -9000;
size = ds_list_size(ctrl_window_handler.open_windows);
for (i = 0; i < size; i += 1){
    window_id = ds_list_find_value(ctrl_window_handler.open_windows, i);
    window_id.depth = d;
    d--;
}

#define scr_window_collision_check
///scr_window_collision_check(x, y);
point_x = argument0;
point_y = argument1;

var i,window_id,size;
size = ds_list_size(ctrl_window_handler.open_windows);
for (i = 0; i < size; i += 1){
    window_id = ds_list_find_value(ctrl_window_handler.open_windows, size-i-1);
    
    window_x = window_id.x;
    window_y = window_id.y;
    window_width = window_id.width;
    window_height = window_id.height
    offset_top = window_id.offset_top;
    offset_side = window_id.offset_side;
    offset_bot = window_id.offset_bot;
    
    x1 = window_x + offset_side;
    y1 = window_y + offset_top;
    x2 = window_x + (window_width+2)*16 - offset_side;
    y2 = window_y + (window_height+2)*16 - offset_bot;
    
    if(scr_is_point_inside_box(point_x, point_y, x1, y1, x2, y2)){
        scr_window_collide(point_x, point_y, window_id);
        return true;
    }
}
return false;

#define scr_window_collide
///scr_window_collide(x, y, window_id);
point_x = argument0;
point_y = argument1;
window_id = argument2;

window_x = window_id.x;
window_y = window_id.y;
window_width = window_id.width;
window_height = window_id.height
offset_top = window_id.offset_top;
offset_side = window_id.offset_side;
offset_bot = window_id.offset_bot;

scroll_x = window_x + window_id.scroll_x;
scroll_y = window_y + window_id.scroll_y;
scroll_offset_top = window_id.scroll_offset_top;
scroll_offset_bot = window_id.scroll_offset_bot;

if(scr_is_point_inside_box(point_x, point_y, window_x+16+window_width*16, window_y+offset_top, 
        window_x+32+(window_width)*16-offset_side, window_y+16-3)){
    window_id.on_exit = true;
} else if(scr_is_point_inside_box(point_x, point_y, window_x+offset_side, window_y+offset_top, 
        window_x+16+(window_width)*16-offset_side, window_y+16)){
    scr_window_set_active(window_id);
    window_id.clicked_offset_x = point_x - window_x;
    window_id.clicked_offset_y = point_y - window_y;
    window_id.window_dragging = true;
    audio_play_sound(sfx_drag, 1, false);
} else if(window_id.scroll_active && scr_is_point_inside_box(point_x, point_y, scroll_x, scroll_y + scroll_offset_top, 
            scroll_x + 16 - offset_side, scroll_y + 32 + window_height*16 - scroll_offset_bot)){
    scr_window_set_active(window_id);
    if(mouse_y < scroll_y + 16 + window_id.thumb_pos){
        window_id.thumb_pos--;
    } else if(mouse_y > scroll_y + 16 + window_id.thumb_pos + window_id.thumb_size){
        window_id.thumb_pos++
    } else {
        window_id.scroll_dragging = true;
        window_id.clicked_offset_y = point_y - scroll_y - scroll_offset_top;
    }
} else{
    scr_window_set_active(window_id);
}



#define scr_window_scrollbar_check
///scr_window_scrollbar_check(window_id);
window_id = argument0;

if(window_id.type == "text"){
    if(ds_list_size(window_id.lines) > window_id.height*2){
        with(window_id){
            scroll_active = true;
            
            window_rows = 2*height;
            scrollbar_height = 16*height;
            rows = ds_list_size(lines);
            delta = rows - window_rows;
            
            thumb_size = floor((window_rows / rows) * (scrollbar_height));
            steps = scrollbar_height - thumb_size + 1;
            step_amount = delta/(steps - 1);
        }
        return true;
    }
}
return false;