///draw_text_outline()
var dto_dcol = draw_get_color();
xx = argument0
yy = argument1

draw_set_color(argument3);

draw_set_color(argument2);  
draw_text(xx+1, yy+1, argument2);  
draw_text(xx-1, yy-1, argument2);  
draw_text(xx,   yy+1, argument2);  
draw_text(xx+1,   yy, argument2);  
draw_text(xx,   yy-1, argument2);  
draw_text(xx-1,   yy, argument2);  
draw_text(xx-1, yy+1, argument2);  
draw_text(xx+1, yy-1, argument2);  

draw_set_color(dto_dcol);

draw_text(xx,yy,argument2);
