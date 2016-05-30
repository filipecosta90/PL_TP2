int open_conditional(){
    int conditional = number_conditionals;
    closing_conditionals_order[conditional_position_to_close+1] = conditional;
    number_conditionals++;
    conditional_position_to_close++;
    return conditional;
}