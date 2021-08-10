data = argument0;
width = argument1;

lines = ds_list_create();
chars_per_line = width*2;
text_current = data;

while(string_length(text_current) >= chars_per_line){
    if(string_char_at(text_current, chars_per_line-1) != " " && 
            string_char_at(text_current, chars_per_line) != " " && 
            string_char_at(text_current, chars_per_line + 1) != " "){
        ds_list_add(lines, string_copy(text_current, 1, chars_per_line-1) + "-");
        text_current = string_copy(text_current, chars_per_line, string_length(text_current)-(chars_per_line-1));
    } else {
        ds_list_add(lines, string_copy(text_current, 1, chars_per_line));
        text_current = string_copy(text_current, chars_per_line+1, string_length(text_current)-(chars_per_line));
    }
}
if (string_length(text_current) > 0){
    ds_list_add(lines, text_current);
}

return lines;
