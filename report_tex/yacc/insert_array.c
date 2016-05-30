void insert_array ( char* varname, int size ) {
    var_table[var_index].varname = strdup(varname);
    var_table[var_index].value = 0;
    var_table[var_index].type = PL_ARRAY;
    var_table[var_index].size =size;
    var_table[var_index].cols = size;
    int old_size = ia[var_index];
    var_index++;
    ia[var_index] = old_size + size;
    printf("\t\tpushn %d\t//%s[%d]\n",size,varname,size);
}