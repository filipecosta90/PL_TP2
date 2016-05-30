int close_cycle(){
    int cycle_to_close = closing_cycles_order[cycle_position_to_close];
    cycle_position_to_close--;
    return cycle_to_close;
}