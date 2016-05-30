%{
#include <stdio.h>

typedef enum {PL_INTEGER, PL_ARRAY, PL_MATRIX, PL_FUNCTION} var_type;

typedef struct {
  char* varname;
  var_type type;
  int value;
  int** values;
  int size;
  int rows;
  int cols;
} datatype;

// array containg the information about the declared vars and functions
datatype var_table[1000];
// array associating the number of var to the total space used by it
int ia[1001];
// current global var index
int var_index = 0;

// array containg the closing cycles order
int closing_cycles_order[100];
// array containg the closing conditionals order
int closing_conditionals_order[100];

// refers to the number of opened cycles
int opened_cycles = 0;
// refers to the number of opened conditionals
int opened_conditionals = 0;

// refers to the number of declared cycles
int number_cycles = 0;
// refers to the number of declared conditionals
int number_conditionals = 0;

// refers to the cycle position to close in the closing cycles array
int cycle_position_to_close = 0;
// refers to the conditional position to close in the closing conditionals array
int conditional_position_to_close = 0;

///////////////////////////////
// start of function signatures

// var/function insertion
void insert_int(char* varname);
void insert_array(char* varname, int size);
void insert_matrix(char* varname, int rows, int cols);
void insert_function ( char* function_name );

// cycle functions
int open_cycle();
int close_cycle();

// conditional functions
int open_conditional();
int close_conditional();
int current_conditional();

// var lookup functions
int lookup_int(char* varname);
int lookup_array(char* varname, int pos);
int lookup_matrix(char* varname, int row, int col);

// global variables functions
int global_pos(char* varname);

// vector/matrix related functions
int is_vector(char* varname);
int get_matrix_ncols(char* varname);

// error checking / handling functions
int exists_var(char* varname, var_type type);
void assert_no_redeclared_var( char* varname ,var_type type);
void assert_declared_var( char* varname, var_type type);
void compile_error( char* message);
int yyerror();

// general
int yylex();

// end of function signatures
///////////////////////////////

%}
