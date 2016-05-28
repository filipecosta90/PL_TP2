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

typedef enum {PL_INTEGER, PL_ARRAY, PL_MATRIX} var_type;

typedef struct {
  char* varname;
  var_type type;
  int value;
  int** values;
  int size;
  int rows;
  int cols;
} datatype;

datatype var_table[100];
int ia[101];
int var_index = 0;
int opened_cycles = 0;
int number_cycles = 0;
int closed_cycles = 0;
int closing_cycles_order[10];
int number_conditions = 0;
int conditional_id;

void insert_int(char* varname);
void insert_array(char* varname, int size);
void insert_matrix(char* varname, int rows, int cols);

int open_cycle();
int close_cycle();
int lookup_int(char* varname);
int lookup_array(char* varname, int pos);
int get_matrix_ncols(char* varname);
int lookup_matrix(char* varname, int row, int col);
int exists_var(char* var);
int global_pos(char* varname);
int is_vector(char* varname);
int yylex();
int yyerror();

%}

%union {int qt; char* var;}

%token <var>id
%token <qt>num 
%token <var>string

%token TYPE_INT
%token INNER_MATRIX

/* identifiers */

%token PL_IF PL_THEN PL_ELSE
%token PL_DO PL_WHILE
%token PL_PRINT 
%token PL_READ


%nonassoc PL_THEN
%nonassoc PL_ELSE 

%start AlgebricScript

%%

AlgebricScript : Declarations  {printf("start\n");} Instructions {printf("stop\n");}
               ;

Declarations  : Declarations Declaration ';'
              |
              ;

Declaration  : TYPE_INT id  { insert_int($2); }
             | TYPE_INT id '[' num  ',' num  ']' { insert_matrix($2,$4,$6); }
             | TYPE_INT id '[' num  ']' { insert_array($2, $4); }
             ;

Instructions : Instructions Instruction 
             |
             ;

Instruction :  Assignment ';'
            | WriteStdout ';'
            | Conditional 
            | Cycle 
/*            | FunctionInvocation Expressions */
            ;


Assignment : 
           id 
'=' Assignement_Value 
           {
           printf("\t\tstoreg %d\t// store var %s\n",global_pos($1),$1);
           }
           | id 
           { 
           printf("\t\tpushgp\n");
           printf("\t\tpushi %d\t//puts on stack the address of %s\n",global_pos($1),$1 ); 
           }
           '[' 
           {
              printf("\t\t\t\t\t\t// +++ Matrix or Vector Dimension Start +++\n");
           } 
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
           {
           printf("\t\tpadd\n");
           }
           '=' Assignement_Value 
           {
           printf("\t\tstoren\n");
           }
           ;

Assignement_Value : Arithmetic_Expression
                  | Read_Stdin
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

Factor  : num     { printf("\t\tpushi %d\n", $1); }
        | id      { printf("\t\tpushg %d\n", global_pos($1));}
        | '(' Arithmetic_Expression ')'
        ;

Logical_Expressions : Logical_Expressions Logical_Expression
                    | 
                    ;

Logical_Expression : '!' Relational_Expression {printf("\t\tnot\t\t//logical not\n");}
                   | Relational_Expression
                   | Logical_Expression '|''|' Relational_Expression 
                   {

printf("\t\t\t\t\t\t// +++ Relational OR BEGIN +++\n");
                   printf("\t\tadd\n");
                   printf("\t\tpushi 2\n");
                   printf("\t\tmod\n");
              printf("\t\t\t\t\t\t// --- Relational OR BEGIN ---\n");
                   }
                   | Logical_Expression '&''&' Relational_Expression
                   {
              printf("\t\t\t\t\t\t// +++ Relational AND BEGIN +++\n");
                   printf("\t\tmul\n");
                   printf("\t\tpushi 2\n");
                   printf("\t\tmod\n");
              printf("\t\t\t\t\t\t// --- Relational AND   END ---\n");
                   }
                   ;

Relational_Expression : Arithmetic_Expression
                      | Arithmetic_Expression '=''=' Arithmetic_Expression
                      {
                      printf("\t\tequal\t//relational equal\n");
                      }
                      | Arithmetic_Expression '!''=' Arithmetic_Expression 
                      {
                      printf("\t\tequal\n");
                      printf("\t\tnot\t//relation not equal\n");
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

Conditional : 
            If_Starter
            PL_THEN '{' Instructions '}' 
            {
            printf("\t\tjump outif%d\n",conditional_id); 
            printf("inelse%d:\n",conditional_id);
            }
            Else_Clause 
      {
     printf("\t\t\t\t\t\t// --- CONDITIONAL IF END ---\n");
     }
            | 
            If_Starter
            PL_THEN  Instruction 
            {
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
     conditional_id = number_conditions; 
     number_conditions++; 
     printf("\t\t\t\t\t\t// +++ CONDITIONAL IF BEGIN +++\n");
     printf("conditional%d:\n",conditional_id);
     }
            PL_IF 
            '(' Logical_Expressions ')' 
            {
            printf("\t\tjz inelse%d\n",conditional_id); 
            printf("inthen%d:\n",conditional_id);
            }
            ;  

Else_Clause : PL_ELSE 
            '{' Instructions '}' 
             {
            printf("outif%d:\n",conditional_id);
            }
            | PL_ELSE 
            Instruction 
            {
            printf("outif%d:\n",conditional_id);
            }
            | /*empty*/
             {
            printf("outif%d:\n",conditional_id);
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
     printf("\t\t\t\t\t\t// +++ CICLE DO BEGIN +++\n");
      int cycle_id = open_cycle(cycle_id);
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
            printf("\t\tpushi %d\t//puts on stack the address of %s\n",global_pos($2),$2 ); 
            printf("\t\tpadd\n");
            printf("\t\tpushi 0\n");
            }
            {
            printf("\t\tloadn\n\t\twritei\n");
            }
            | PL_PRINT id 
            { 
            printf("\t\tpushgp\n");
            printf("\t\tpushi %d\t//puts on stack the address of %s\n",global_pos($2),$2 ); 
            printf("\t\tpadd\n");
            }
            '[' 
            {
              printf("\t\t\t\t\t\t// +++ Matrix or Vector Dimension Start +++\n");
            } 
           Arithmetic_Expression 
           {
           if ( is_vector($2) ){
              printf("\t\t\t\t\t\t//since its a vector nothing more to do here\n");
           }
           else {
           printf("\t\tpushi %d\t\t\t\t//pushes column size of  matrix\n",get_matrix_ncols($2));
           printf("\t\tmul\n");
           }
           }
           Second_Dimension Dimension_End
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
  closing_cycles_order[number_cycles] = cycle;
  number_cycles++;
  opened_cycles = number_cycles - closed_cycles;
  return cycle;
}

int close_cycle(){
  closed_cycles++;
  int cycle_to_close = number_cycles - closed_cycles;
  if ( opened_cycles > 1 ){
  return closing_cycles_order[cycle_to_close];
  }
  else {
  return closing_cycles_order[number_cycles-1];
  }
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

int exists_var(char* varname) {
  int i, r;
  i = 0;
  while (( i < var_index ) && (strcmp(var_table[i].varname, varname)!= 0)) i++;
  if ( i == var_index ) r = 0; else r = 1;
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
          printf("Error\t (line %d): %s at %s\n", yylineno, s, yytext);
  return 1;

}

int main () {
  yyparse();
  return 0;
}
