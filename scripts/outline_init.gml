#define outline_init
uni_size = shader_get_uniform(sh_outline, "size");
uni_thick = shader_get_uniform(sh_outline, "thick");
uni_color = shader_get_uniform(sh_outline, "oColor");
uni_acc = shader_get_uniform(sh_outline, "accuracy");
uni_tol = shader_get_uniform(sh_outline, "tol");
uni_uvs = shader_get_uniform(sh_outline, "uvs");

#define outline_end
shader_reset();

#define outline_start
/// @arg thickness
/// @arg color
/// @arg OPTIONAL_sprite
/// @arg OPTIONAL_accuracy
/// @arg OPTIONAL_tolerance
var _spr;
if (argument_count<=2) _spr = sprite_index;
else _spr = argument[2];

shader_set(sh_outline);

var _tex = sprite_get_texture(_spr, image_index);

var _w = texture_get_texel_width(_tex);
var _h = texture_get_texel_height(_tex);

shader_set_uniform_f(uni_size, _w, _h);

shader_set_uniform_f(uni_thick, argument[0]);

shader_set_uniform_f(uni_color, color_get_red(argument[1])/255, color_get_green(argument[1])/255, color_get_blue(argument[1])/255);

var acc;
if (argument_count<=3) acc = 16;
else acc = argument[3];

shader_set_uniform_f(uni_acc, acc);

var tol;
if (argument_count<=4) tol = 0;
else tol = argument[4];

shader_set_uniform_f(uni_tol, tol);

var uvs = sprite_get_uvs(_spr, image_index);

shader_set_uniform_f(uni_uvs, uvs[0], uvs[1], uvs[2], uvs[3]);

#define outline_start_surface
/// @arg thickness
/// @arg color
/// @arg surface
/// @arg OPTIONAL_accuracy
/// @arg OPTIONAL_tolerance
var _sur = argument[2];

shader_set(sh_outline);

var _tex = surface_get_texture(_sur);

var _w = texture_get_texel_width(_tex);
var _h = texture_get_texel_height(_tex);

shader_set_uniform_f(uni_size, _w, _h);

shader_set_uniform_f(uni_thick, argument[0]);

shader_set_uniform_f(uni_color, color_get_red(argument[1])/255, color_get_green(argument[1])/255, color_get_blue(argument[1])/255);

var acc;
if (argument_count<=3) acc = 16;
else acc = argument[3];

shader_set_uniform_f(uni_acc, acc);

var tol;
if (argument_count<=4) tol = 0;
else tol = argument[4];

shader_set_uniform_f(uni_tol, tol);

var uvs = sprite_get_uvs(_sur,0);

shader_set_uniform_f(uni_uvs, uvs[0], uvs[1], uvs[2], uvs[3]);


#define docs
/*
Outline Shader
	--by matharoo
	
How To Use
----------

To add an outline to an object:

1) You need to put "outline_init()" in the Create event of the object.

2) Put "outline_start()" in the Draw event.


	Arguments:
	----------
	(Only two are required)
	
	thickness: The thickness of the outline, in pixels.
	
	color: The color of the outline. Has to be a color variable, like c_white, c_red, c_black, etc. To create your own color, use make_color_rgb().
	
	OPTIONAL_sprite: Set this to the sprite you are drawing. Not needed if you're using draw_self(), but if you're trying to draw some other sprite, specify it here first.
						Default: sprite_index
	
	OPTIONAL_accuracy: This is an optional argument. The default value is 16. If you think the outline or a part of it appears weird, try increasing it (maximum value is 360).
						You can optimize the shader by reducing it (minimum value is 4). 4 works best for a pixel outline.
						
	OPTIONAL_tolerance: This is another optional argument. Default value is 0, maximum is 1. Increase this if parts in your sprite with less alpha have an outline when they shouldn't.
	
	
	Surfaces:
	---------
	
	Use "outline_start_surface()" if you want outlines inside a surface area. In that function, the argument "OPTIONAL_sprite" is replaced by a REQUIRED surface argument. You need to specify
	the surface you are going to draw there.
	
	
3) Draw anything you want after one of those functions and it will have the outline.

4) Then use "outline_end()" when you're done drawing the outlined stuff.

-----------
!IMPORTANT!
-----------
The sprite needs to have empty space around the image for the outline to be drawn.
Open Tools > Texture Groups, select your sprite, and make sure "Automatically Crop" is disabled.
*/