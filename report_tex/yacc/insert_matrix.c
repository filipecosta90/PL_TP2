void insert_matrix ( char* varname, int rows, int cols ) {
    var_table[var_index].varname = strdup(varname);
    var_table[var_index].value = 0;
    var_table[var_index].type = PL_MATRIX;
    var_table[var_index].rows = rows;
    var_table[var_index].cols = cols;
    int size = rows * cols;
    var_table[var_index].size =size;
    int old_size = ia[var_index];
    var_index++;
    ia[var_index] = old_size + size;
    printf("\t\tpushn %d\t//%s[%d][%d] (size %d)\n",size,varname,rows,cols,size);
}