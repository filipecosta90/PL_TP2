int exists_var(char* varname, var_type type) {
    int i, r;
    i = 0;
    while (( i < var_index ) && (strcmp(var_table[i].varname, varname)!= 0)) {
        i++;
    }
    
    if ( i == var_index ) {
        r = 0;
    }
    else {
        if (type == var_table[i].type) {
            r = 1;
        }
    }
    return r;
}