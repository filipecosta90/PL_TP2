int global_pos(char* varname) {
    int i, result;
    i = 0;
    while( (i < var_index ) && (strcmp(var_table[i].varname, varname)!= 0)){ i++; }
    if ( i == var_index ) {
        result = -1;
    }
    else{
        result = ia[i];
    }
    return result;
}