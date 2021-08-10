value = argument0;
if(is_real(value)){
    return floor(value) != value;
} else {
    return false;
}

