void insert_int ( char* varname ) {
    var_table[var_index].varname = strdup(varname);
    var_table[var_index].value = 0;
    var_table[var_index].type = PL_INTEGER;
    var_table[var_index].size =1;
    int old_size = ia[var_index];
    var_index++;
    ia[var_index] = old_size + 1;
    printf("\t\tpushi 0\t//%s\n",varname);
}