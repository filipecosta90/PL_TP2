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

void insert_int(char* varname);
void insert_array(char* varname, int size);
void insert_matrix(char* varname, int rows, int cols);

int lookup_int(char* varname);
int lookup_array(char* varname, int pos);
int get_matrix_ncols(char* varname);
int lookup_matrix(char* varname, int row, int col);
int exists_var(char* var);
int global_pos(char* varname);

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
           { 
           printf("pushi %d\t//puts on stack the address of %s\n",global_pos($1),$1 ); 
          printf("pushi 0\n");
         }
          
           '=' Assignement_Value 
           {
           printf("storen\t//takes from the stack an value v an integer n and address a, and stores v in the address a[n], with n=j*k from a[j][k]\n");
           }
           | id 
           { 
           printf("pushi %d\t//puts on stack the address of %s\n",global_pos($1),$1 ); 
          }
         '[' {
         printf("\t\t\t//MATRIX OR VECTOR DIMENSION START\n");
         } 
                Arithmetic_Expression 
            {
            printf("pushi %d\t\t\t\t//pushes column size of vector or matrix\n",get_matrix_ncols($1));
            printf("mul\n");
            }
           Second_Dimension Dimension_End
           '=' Assignement_Value 
           {
           printf("storen\t//takes from the stack an value v an integer n and address a, and stores v in the address a[n], with n=j*k from a[j][k]\n");
           }
          ;

Assignement_Value : Arithmetic_Expression
                  | Read_Stdin
                  ;

Second_Dimension : ','  Arithmetic_Expression 
                 | /*empty*/ {printf("pushi 0\t//second dimension size of vector(0)\n");} 
                 ;

Dimension_End : ']' {printf("sum \t//sums both dimensions\n\t\t\t//MATRIX OR   VECTOR DIMENSION END\n");}
              ;

Read_Stdin : PL_READ '(' ')' { printf("read\natoi\n");  }
          ;
Arithmetic_Expression : Term 
                      | Arithmetic_Expression '+' Term { printf("add\n");}
                      | Arithmetic_Expression '-' Term { printf("sub\n");}
                      ;

Term    : Factor 
        | Term '*' Factor  { printf("mul\n");}
        | Term '/' Factor  { printf("div\n");}
        | Term '%' Factor  { printf("mod\n");}
        ;

Factor  : num     { printf("pushi %d\n", $1); }
        | id       { printf("pushg %d\n", lookup_int($1));}
        | '(' Arithmetic_Expression ')'
        ;

Conditional : PL_IF '(' Logical_Expressions ')' PL_THEN '{' Instructions '}' Else_Clause 
            | PL_IF '('Logical_Expressions ')' PL_THEN  Instruction Else_Clause
            ;

Else_Clause : PL_ELSE '{' Instructions '}' 
            | PL_ELSE Instruction 
            |
            ;

Logical_Expressions : Logical_Expressions Logical_Expression
                    | 
                    ;

Logical_Expression : '!' Relational_Expression {printf("not\t//logical not\n");}
                   | Relational_Expression
                   | Relational_Expression '|''|' Relational_Expression 
                   | Relational_Expression '&''&' Relational_Expression
                   ;

Relational_Expression :  Arithmetic_Expression
                      | Arithmetic_Expression '=''=' Arithmetic_Expression
                      {
                      printf("equal\t//relational equal\n");
                      }
                      | Arithmetic_Expression '!''=' Arithmetic_Expression 
                      {
                      printf("equal\n");
                      printf("not\t//relation not equal\n");
                      }
                      | Arithmetic_Expression '>' Arithmetic_Expression 
                      {
                      printf("sup\t//relational superior\n");
                      }
                      | Arithmetic_Expression '>''=' Arithmetic_Expression 
                      {
                      printf("supeq\t//relational superior or equal\n");
                      }
                      | Arithmetic_Expression '<' Arithmetic_Expression 
                      {
                      printf("inf\t//relational inferior\n");
                      }
                      | Arithmetic_Expression '<''=' Arithmetic_Expression 
                      {
                      printf("infeq\t//relational inferior or equal\n");
                      }
                      | '(' Logical_Expressions ')'
                      ;

Cycle : PL_DO '{' Instructions '}' PL_WHILE '(' Logical_Expressions ')' 
      | PL_DO Instruction PL_WHILE '(' Logical_Expressions ')'
      ;

WriteStdout : PL_PRINT id 
            {
            printf("pushi %d\n",global_pos($2));
            printf("pushi 0\n");
            }
            {
            printf("loadn\nwritei\n");
            }
            | PL_PRINT id 
            { 
            printf("pushi %d\t//puts on stack the address of %s\n",global_pos($2),$2 ); 
            }
            '[' 
            {
            printf("\t\t\t//MATRIX OR VECTOR DIMENSION START\n");
            } 
            Arithmetic_Expression 
            {
            printf("pushi %d\t\t\t\t//pushes column size of vector or matrix\n",get_matrix_ncols($2));
            printf("mul\n");
            }
           Second_Dimension Dimension_End
           {
            printf("loadn\nwritei\n");
           }
           | PL_PRINT num 
            { 
            printf("pushi %di\t//print num %d\n",$2,$2); 
            printf("writei\n"); 
            }
            | PL_PRINT string 
            { 
            printf("pushs %s\t//print string %s\n",$2,$2); 
            printf("writes\n"); 
            }
            ;
%%

#include "lex.yy.c"

void insert_int ( char* varname ) {
  var_table[var_index].varname = strdup(varname);
  var_table[var_index].value = 0;
  var_table[var_index].type = PL_INTEGER;
  var_table[var_index].size =1;
  int old_size = ia[var_index];
  var_index++;
  ia[var_index] = old_size + 1;
  printf("pushi 0\t//%s\n",varname);
}

void insert_array ( char* varname, int size ) {
  var_table[var_index].varname = strdup(varname);
  var_table[var_index].value = 0;
  var_table[var_index].type = PL_ARRAY;
  var_table[var_index].size =size;
  int old_size = ia[var_index];
  var_index++;
  ia[var_index] = old_size + size;
  printf("pushn %d\t//%s[%d]\n",size,varname,size);
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
  printf("pushn %d\t//%s[%d][%d] (size %d)\n",size,varname,rows,cols,size);
}

int exists_var(char* varname) {
  int i, r;
  i = 0;
  while (( i < var_index ) && (strcmp(var_table[i].varname, varname)!= 0)) i++;
  if ( i == var_index ) r = 0; else r = 1;
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
