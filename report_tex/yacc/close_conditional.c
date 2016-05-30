int close_conditional(){
    int conditional_to_close = closing_conditionals_order[conditional_position_to_close];
    conditional_position_to_close--;
    return conditional_to_close;
}