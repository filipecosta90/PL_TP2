
int open_cycle(){
  int cycle = number_cycles;
  closing_cycles_order[cycle_position_to_close+1] = cycle;
  number_cycles++;
  cycle_position_to_close++;
  return cycle;
}

int close_cycle(){
  int cycle_to_close = closing_cycles_order[cycle_position_to_close];
  cycle_position_to_close--;
  return cycle_to_close;
}

int open_conditional(){
  int conditional = number_conditionals;
  closing_conditionals_order[conditional_position_to_close+1] = conditional;
  number_conditionals++;
  conditional_position_to_close++;
  return conditional;
}

int current_conditional(){
  int actual_conditional = closing_conditionals_order[conditional_position_to_close];
  return actual_conditional;
}

int close_conditional(){
  int conditional_to_close = closing_conditionals_order[conditional_position_to_close];
  conditional_position_to_close--;
  return conditional_to_close;
}

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

int lookup_int(char* varname) {
  int i, result;
  i = 0;
  while( (i < var_index ) && (strcmp(var_table[i].varname, varname)!= 0)){ i++; }
  if ( i == var_index ) {
    result = -1;
  }
  else{ 
    result = var_table[i].value;
  }
  return result;
} 

int lookup_array(char* varname, int pos) {
  int i, result;
  i = 0;
  while( (i < var_index ) && (strcmp(var_table[i].varname, varname)!= 0)){ i++; }
  if ( i == var_index ) {
    result = -1;
  }
  else{ 
    result = (var_table[i].values)[1][pos];
  }
  return result;
}

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

void compile_error( char* message){
  yyerror(message);
  exit(0);
}
void assert_no_redeclared_var( char* varname ,var_type type){
  if ( exists_var(varname, type) ){
    compile_error("re-declaring VAR"); 
  }
}

void assert_declared_var(char* varname, var_type type){
  if ( !exists_var(varname, type) ){
    compile_error("accessing non declared VAR"); 
  }
}

int lookup_matrix(char* varname, int row, int col) {
  int i, result;
  i = 0;
  while( (i < var_index ) && (strcmp(var_table[i].varname, varname)!= 0)){ i++; }
  if ( i == var_index ) {
    result = -1;
  }
  else{ 
    result = (var_table[i].values)[row][col];
  }
  return result;
}

int yyerror(char* s) {
  if (strlen(yytext)>1){
    printf("\t\terr \"Error (input file line %d): %s at %s\"\n", yylineno, s, yytext);
    fprintf(stderr,"Error\t (line %d): %s at %s\n", yylineno, s, yytext);
  }
  else {
    printf("\t\terr \"Error (input file line %d): %s\"\n", yylineno, s);
    fprintf(stderr,"Error\t (line %d): %s\n", yylineno, s);
  }
  return 1;
}

int main () {
  yyparse();
  return 0;
}
