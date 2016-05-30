int open_cycle(){
    int cycle = number_cycles;
    closing_cycles_order[cycle_position_to_close+1] = cycle;
    number_cycles++;
    cycle_position_to_close++;
    return cycle;
}