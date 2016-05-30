/* ---------------------------------------------------------------------------
 **    Filename: algebric_cc.y
 **
 **     License: This file is part of PL PROJECT.
 **
 **              PL PROJECT is free software: you can redistribute it
 **              and/or modify it under the terms of the GNU General Public
 **              License as published by the Free Software Foundation,
 **              either version 3 of the License, or (at your option)
 **              any later version.
 **
 **              OLAP is distributed in the hope that it will be useful,
 **              but WITHOUT ANY WARRANTY; without even the implied warranty of
 **              MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 **              GNU General Public License for more details.
 **
 **              You should have received a copy of the GNU General Public
 **              License along with PL PROJECT.
 **              If not, see <http://www.gnu.org/licenses/>.
 **
 ** Description: 
 **
 **      Author: Filipe Oliveira <a57816@alunos.uminho.pt>
 **
 ** University of Minho, Computer Science Dpt. , May 2016
 ** -------------------------------------------------------------------------*/

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

datatype var_table[1000];
int ia[1001];
int var_index = 0;

int closing_cycles_order[100];
int closing_conditionals_order[100];

int opened_cycles = 0;
int opened_conditionals = 0;

int number_cycles = 0;
int number_conditionals = 0;

int cycle_position_to_close = 0;
int conditional_position_to_close = 0;

void insert_int(char* varname);
void insert_array(char* varname, int size);
void insert_matrix(char* varname, int rows, int cols);
void insert_function ( char* function_name );

int open_cycle();
int close_cycle();
int open_conditional();
int close_conditional();
int current_conditional();
int lookup_int(char* varname);
int lookup_array(char* varname, int pos);
int get_matrix_ncols(char* varname);
int lookup_matrix(char* varname, int row, int col);
int exists_var(char* varname, var_type type);
int global_pos(char* varname);
int is_vector(char* varname);
int yylex();
int yyerror();
void compile_error( char* message);
void assert_no_redeclared_var( char* varname ,var_type type);
void assert_declared_var( char* varname, var_type type);

%}

%union {int qt; char* var;}

%token <var>id
%token <qt>num 
%token <var>string

%token TYPE_INT
%token TYPE_FUNCTION
%token INNER_MATRIX

/* identifiers */

%token PL_IF PL_THEN PL_ELSE
%token PL_DO PL_WHILE
%token PL_PRINT 
%token PL_READ
%token PL_CALL
%token PL_RETURN


%nonassoc PL_THEN
%nonassoc PL_ELSE 

%start AlgebricScript

%%

AlgebricScript : Declarations Function_Declarations 
               { printf("start\n");} 
               Instructions 
               { printf("stop\n");}
               ;

Declarations  : 
              Declarations Declaration ';'
              | /*empty*/ 
              ;

Function_Declarations :
                      Function_Declarations Function_Declaration 
                      | /*empty*/ 
                      ;

Declaration  : 
             TYPE_INT id  
             { 
               assert_no_redeclared_var($2,PL_INTEGER);
               insert_int($2); 
             }
             | TYPE_INT id '[' num  ',' num  ']' 
             { 
               assert_no_redeclared_var($2,PL_MATRIX);
               insert_matrix($2,$4,$6); 
             }
             | TYPE_INT id '[' num  ']' 
             { 
               assert_no_redeclared_var($2,PL_ARRAY);
               insert_array($2, $4); 
             }
             ;


Function_Declaration : 
                     TYPE_FUNCTION id '('')' '{'
                     {
                       assert_no_redeclared_var($2,PL_FUNCTION);
                       printf("\t\t\t\t\t\t// +++ Function Declaration Start +++\n");
                       insert_function($2);
                       printf("\t\tjump endfunction%s\n",$2);
                       printf("startfunction%s:\n",$2);
                       printf("\t\tnop\t\t// no operation\n");
                     }
                     Instructions Return_Statement 
                     '}'
                     {
                       printf("\t\tstoreg %d\t// store returned value of  %s\n",global_pos($2),$2);
                       printf("\t\treturn\n");
                       printf("endfunction%s:\n",$2);
                       printf("\t\t\t\t\t\t// --- Function Declaration End ---\n");
                     }
                     ;

Function_Invocation : 
                    PL_CALL id '(' ')' 
                    { 
                      assert_declared_var($2,PL_FUNCTION);
                      printf("\t\tpusha startfunction%s\n",$2);
                      printf("\t\tcall\n");
                      printf("\t\tpushg %d\t// pushes returned value of  %s\n",global_pos($2),$2);
                    }
                    ;

Return_Statement : PL_RETURN Arithmetic_Expression';'
                 ;

Instructions : Instructions Instruction 
             | /*empty*/ 
             ;

Instruction : Assignment ';'
            | WriteStdout ';'
            | Conditional 
            | Cycle 
            ;

Assignment : id '=' Assignement_Value 
           {
             assert_declared_var($1, PL_INTEGER );
             printf("\t\tstoreg %d\t// store var %s\n",global_pos($1),$1);
           }
           | Vectors
           '=' Assignement_Value 
           {
             printf("\t\tstoren\n");
           }
           ;

Assignement_Value : Arithmetic_Expression
                  | Read_Stdin
                  | Function_Invocation
                  ;
Vectors : id
        { 
        if ( is_vector($1) ){
          assert_declared_var($1,PL_ARRAY);
        }
        else{
          assert_declared_var($1,PL_MATRIX);
        }
          printf("\t\tpushgp\n");
          printf("\t\tpushi %d\t//puts on stack the address of %s\n",global_pos($1),$1 ); 
          printf("\t\tpadd\n");
          printf("\t\t\t\t\t\t// +++ Matrix or Vector Dimension Start +++\n");
        }
        '[' 
        Arithmetic_Expression 
        {
        if ( is_vector($1) ){
        }
        else {
          printf("\t\tpushi %d\t\t\t\t//pushes column size of vector or matrix\n",get_matrix_ncols($1));
          printf("\t\tmul\n");
        }
        }
        Second_Dimension Dimension_End
        ; 

Second_Dimension : ','  Arithmetic_Expression 
                 | /*empty*/ {printf("\t\tpushi 0\t\t//second dimension size of vector(0)\n");} 
                 ;

Dimension_End : ']'
              {
                printf("\t\tadd\t\t//sums both dimensions\n");
                printf("\t\t\t\t\t\t// --- Matrix or Vector Dimension End ---\n");
              }
              ;

Read_Stdin : PL_READ '(' ')' 
           {
             printf("\t\tread\n");
             printf("\t\tatoi\n");  
           }
           ;

Arithmetic_Expression : Term 
                      | Arithmetic_Expression '+' Term { printf("\t\tadd\n");}
                      | Arithmetic_Expression '-' Term { printf("\t\tsub\n");}
                      ;

Term    : Factor 
        | Term '*' Factor  { printf("\t\tmul\n");}
        | Term '/' Factor  { printf("\t\tdiv\n");}
        | Term '%' Factor  { printf("\t\tmod\n");}
        ;

Factor  : num     
        { printf("\t\tpushi %d\n", $1); }
        | id
        {
          assert_declared_var($1, PL_INTEGER);
          printf("\t\tpushg %d\n", global_pos($1));
        }
        | Vectors { printf("\t\tloadn \n");}
        | '(' Arithmetic_Expression ')'
        ;

Logical_Expressions : Logical_Expressions Logical_Expression
                    | 
                    ;

Logical_Expression : '!' Relational_Expression 
                   {
                     printf("\t\t\t\t\t\t// +++ Relational NOT BEGIN +++\n");
                     printf("\t\tpushi 1\n");
                     printf("\t\tadd\n");
                     printf("\t\tpushi 2\n");
                     printf("\t\tmod\n");
                     printf("\t\t\t\t\t\t// --- Relational NOT END ---\n");
                   }
                   | Relational_Expression
                   | Logical_Expression '|''|' Relational_Expression 
                   {
                     printf("\t\t\t\t\t\t// +++ Relational OR BEGIN +++\n");
                     printf("\t\tadd\n");
                     printf("\t\tpushi 2\n");
                     printf("\t\tmod\n");
                     printf("\t\t\t\t\t\t// --- Relational OR END ---\n");
                   }
                   | Logical_Expression '&''&' Relational_Expression
                   {
                     printf("\t\t\t\t\t\t// +++ Relational AND BEGIN +++\n");
                     printf("\t\tmul\n");
                     printf("\t\tpushi 2\n");
                     printf("\t\tmod\n");
                     printf("\t\t\t\t\t\t// --- Relational AND END ---\n");
                   }
                   ;

Relational_Expression : Arithmetic_Expression
                      | Arithmetic_Expression '=''=' Arithmetic_Expression
                      {
                        printf("\t\tequal\t//relational equal\n");
                      }
                      | Arithmetic_Expression '!''=' Arithmetic_Expression 
                      {
                        printf("\t\t\t\t\t\t// +++ Logical NOT EQUAL BEGIN +++\n");
                        printf("\t\tequal\n");
                        printf("\t\tpushi 1\n");
                        printf("\t\tadd\n");
                        printf("\t\tpushi 2\n");
                        printf("\t\tmod\n");
                        printf("\t\t\t\t\t\t// --- Logical NOT EQUAL END ---\n");
                      }
                      | Arithmetic_Expression '>' Arithmetic_Expression 
                      {
                        printf("\t\tsup\t//relational superior\n");
                      }
                      | Arithmetic_Expression '>''=' Arithmetic_Expression 
                      {
                        printf("\t\tsupeq\t//relational superior or equal\n");
                      }
                      | Arithmetic_Expression '<' Arithmetic_Expression 
                      {
                        printf("\t\tinf\t//relational inferior\n");
                      }
                      | Arithmetic_Expression '<''=' Arithmetic_Expression 
                      {
                        printf("\t\tinfeq\t//relational inferior or equal\n");
                      }
                      | '(' Logical_Expressions ')'
                      ;

Conditional : If_Starter
            PL_THEN '{' Instructions '}' 
            {
              int conditional_id = current_conditional();
              printf("\t\tjump outif%d\n",conditional_id); 
              printf("inelse%d:\n",conditional_id);
            }
            Else_Clause 
            {
              printf("\t\t\t\t\t\t// --- CONDITIONAL IF END ---\n");
            }
            | If_Starter
            PL_THEN  Instruction 
            {
              int conditional_id = current_conditional();
              printf("\t\tjump outif%d\n",conditional_id); 
              printf("inelse%d:\n",conditional_id);
            }
            Else_Clause 
            {
              printf("\t\t\t\t\t\t// --- CONDITIONAL IF END ---\n");
            }
            ;

If_Starter :
           {
             int conditional_id = open_conditional();
             printf("\t\t\t\t\t\t// +++ CONDITIONAL IF BEGIN +++\n");
             printf("conditional%d:\n",conditional_id);
           }
           PL_IF 
           '(' Logical_Expressions ')' 
           {
             int conditional_id = current_conditional();
             printf("\t\tjz inelse%d\n",conditional_id); 
             printf("inthen%d:\n",conditional_id);
           }
           ;

Else_Clause : PL_ELSE 
            '{' Instructions '}' 
            {
              int conditional_closed = close_conditional();
              printf("outif%d:\n",conditional_closed);
            }
            | PL_ELSE 
            Instruction 
            {
              int conditional_closed = close_conditional();
              printf("outif%d:\n",conditional_closed);
            }
            | /*empty*/
            {
              int conditional_closed = close_conditional();
              printf("outif%d:\n",conditional_closed);
            }
            ;

Cycle : PL_DO 
      {
        int cycle_id = open_cycle();
        printf("\t\t\t\t\t\t// +++ CICLE DO BEGIN +++\n");
        printf("cycle%d:\t//do\n",cycle_id);
      }
      '{' Instructions '}' PL_WHILE '(' Logical_Expressions ')' 
      {
        int cycle_closed = close_cycle();
        printf("\t\tjz endcycle%d\t//while\n",cycle_closed);
        printf("\t\tjump cycle%d\n",cycle_closed);
        printf("endcycle%d:\n",cycle_closed);
        printf("\t\t\t\t\t\t// --- CICLE DO END ---\n");
      }
      | PL_DO 
      {
        int cycle_id = open_cycle();
        printf("\t\t\t\t\t\t// +++ CICLE DO BEGIN +++\n");
        printf("cycle%d:\t//do\n",cycle_id);
      }
      Instruction PL_WHILE '(' Logical_Expressions ')' 
      {
        int cycle_closed = close_cycle();
        printf("\t\tjz endcycle%d\t//while\n",cycle_closed);
        printf("\t\tjump cycle%d\n",cycle_closed);
        printf("endcycle%d:\n",cycle_closed);
        printf("\t\t\t\t\t\t// --- CICLE DO END ---\n");
      }
      ;

WriteStdout : PL_PRINT id 
            {
              printf("\t\tpushgp\n");
              assert_declared_var($2, PL_INTEGER);
              printf("\t\tpushi %d\t//puts on stack the address of %s\n",global_pos($2),$2 ); 
              printf("\t\tpadd\n");
              printf("\t\tpushi 0\n");
              printf("\t\tloadn\n\t\twritei\n");
            }
            | PL_PRINT Vectors
            {
              printf("\t\tloadn\n\t\twritei\n");
            }
            | PL_PRINT num 
            { 
              printf("\t\tpushi %di\t//print num %d\n",$2,$2); 
              printf("\t\twritei\n"); 
            }
            | PL_PRINT string
            { 
              printf("\t\tpushs %s\t//print string %s\n",$2,$2); 
              printf("\t\twrites\n"); 
            }
            ;
%%

#include "lex.yy.c"


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
