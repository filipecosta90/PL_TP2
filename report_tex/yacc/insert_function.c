void insert_function ( char* function_name ) {
    var_table[var_index].varname = strdup( function_name );
    var_table[var_index].value = -1;
    var_table[var_index].type = PL_FUNCTION;
    var_table[var_index].rows = -1;
    var_table[var_index].cols = -1;
    var_table[var_index].size =-1;
    int old_size = ia[var_index];
    var_index++;
    ia[var_index] = old_size + 1;
    printf("\t\tpushi 0\t\t// space for fucntion %s returned value\n", function_name);
}