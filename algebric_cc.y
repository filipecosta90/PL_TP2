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
int lookup_matrix(char* varname, int row, int col);
int exists_var(char* var);
int global_pos(char* varname);
%}

%union {int qt; char* var;}

%token <qt>num 
%token <var>string
%token TYPE_INT

/* identifiers */
%token <var>id
%token <var>id_array
%token <var>id_matrix

%type <qt>Arithmetic_Expression
%type <qt>Term
%type <qt>Factor

%token PRINT

%start AlgebricScript

%%

AlgebricScript : Declarations  {printf("start\n");} Instructions {printf("stop\n");}
               ;

Declarations  : Declarations Declaration ';'
              |
              ;

Declaration  : TYPE_INT id  { insert_int($2); }
             | TYPE_INT id '[' num  ']' { insert_array($2, $4); }
             | TYPE_INT id '[' num  ']''[' num  ']' { insert_matrix($2,$4,$7); }
             ;

Instructions : Instructions Assignment ';'
             | Instructions ReadStdin ';'
            | Instructions WriteStdout ';' 
            | Instructions Conditional_Expression ';' 
            | Instructions Cycle_Expression ';' 
            |
/*            | FunctionInvocation Expressions */
            ;

Assignment : id { printf("//assignement\n"); printf("pushgp\t//puts on stack the value of gp\n"); 
                  printf("pushi %d\t//puts on stack the address of %s\n",global_pos($1),$1 ); 
                } 
                '=' Arithmetic_Expression { printf("store 0\t//takes from the stack an value v and address a, and stores v in the address a\n");}
           | id 
                { printf("//assignement\n"); printf("pushgp\t//puts on stack the value of gp\n"); 
                  printf("pushi %d\t//puts on stack the address of %s\n",global_pos($1),$1 );
                  printf("\t//puts on stack the value of n\n");
                } 
                '[' Arithmetic_Expression ']'  
               '=' Arithmetic_Expression { printf("storen\t//takes from the stack an value v an integer n and address a, and stores v in the address a[n]\n");}
           | id  
                { printf("//assignement\n"); printf("pushgp\t//puts on stack the value of gp\n"); 
                  printf("pushi %d\t//puts on stack the address of %s\n",global_pos($1),$1 );
                  printf("\t//puts on stack the value of j and k\n");
                }
                '[' Arithmetic_Expression ']' '[' Arithmetic_Expression ']'
                {
                 printf("mul \t//puts on stack the value of n, being n= j*k from a[j][k]\n");
                }
                '=' Arithmetic_Expression { printf("storen\t//takes from the stack an value v an integer n and address a, and stores v in the address a[n], with n=j*k from a[j][k]\n");}
          ;

Arithmetic_Expression : Term
                      | Arithmetic_Expression '+' Term {printf("add\n");}
                      | Arithmetic_Expression '-' Term {printf("sub\n");}
                      ;

Term    : Factor
        | Term '*' Factor  { printf("mul\n");}
        | Term '/' Factor  { printf("div\n");}
        ;

Factor  : num     { printf("pushi %d\n", $1); }
        | id       { printf("pushg %d\n", lookup_int($1));}
        | '(' Instructions ')'	{ }
        ;

Relational_Expression :
                      ;

Logical_Expression :
                   ;

ReadStdin :
          ;

WriteStdout : PRINT id { printf("pushg %d\n",lookup_int($2)); printf("writei\n"); }
            | PRINT num { printf("pushi %d\n",$2); printf("writei\n"); }
            ;

Conditional_Expression :
                       ;

Cycle_Expression :
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
  printf("Error: %s\n", s);
  return 1;
}

int main () {
  yyparse();
  return 0;
}
