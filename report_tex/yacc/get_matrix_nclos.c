int get_matrix_ncols(char* varname){
    int i, result;
    i = 0;
    while( (i < var_index ) && (strcmp(var_table[i].varname, varname)!= 0)){ i++; }
    if ( i == var_index ) {
        result = -1;
    }
    else{
        result = var_table[i].cols;
    }
    return result;
}