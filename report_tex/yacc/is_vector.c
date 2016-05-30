int is_vector(char* varname) {
    int i, r;
    i = 0;
    while (( i < var_index ) && (strcmp(var_table[i].varname, varname)!= 0)) i++;
    if ( i == var_index ) {
        r = 0;
    }
    else {
        if( var_table[i].type == PL_ARRAY ){
            r = 1;
        }
        else{
            r = 0;
        }
    }
    return r;
}