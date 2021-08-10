interact_id = noone;
switch(obj_player.currentDirection){
    case facing.up:
        interact_id = collision_point(obj_player.fauxX, obj_player.fauxY-16, par_interactable,false,true);
        break;
    case facing.left:
        interact_id = collision_point(obj_player.fauxX-16, obj_player.fauxY, par_interactable,false,true);
        break;
    case facing.down:
        interact_id = collision_point(obj_player.fauxX, obj_player.fauxY+16, par_interactable,false,true);
        break;
    case facing.right:
        interact_id = collision_point(obj_player.fauxX+16, obj_player.fauxY, par_interactable,false,true);
        break;
}
if(interact_id != noone){
    return interact_id.file_name;
}
return "";
