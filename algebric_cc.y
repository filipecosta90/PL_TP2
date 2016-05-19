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

typedef struct {
  char* varname;
  int value;
} integers;

typedef struct {
  char* varname;
  int* values;
  int size;
} arrays;

typedef struct {
  char* varname;
  int** values;
  int rows;
  int cols;
} matrices;

integers table_ints[1000];
arrays table_arrays[100];
matrices table_matrices[100];

int index_ints = 0;
int index_arrays = 0;
int index_matrices = 0;

void insert_int(char* varname, int val);
void insert_array(char* varname, int size);
void insert_matrix(char* varname, int rows, int cols);

int lookup_int(char* var);
int lookup_array(char* var, int pos);
int lookup_matrix(char* var, int row, int col);

int exists_int(char* var);
int exists_array(char* var);
int exists_matrix(char* var);

int global_pos_int(char* varname);
%}

%union {int qt; char* var;}

%token <qt>num 
%token <var>string
%token TYPE_INT

/* identifiers */
%token <var>id
%token <var>id_array
%token <var>id_matrix

/* logical */
%token LOG_AND
%token LOG_OR

%type <qt>Arithmetic_Expression
%type <qt>Term
%type <qt>Factor

%token PRINT

%left '+' '-'
%left '*' '/'
%left '='

%start AlgebricScript

%%

AlgebricScript : Declarations Expressions {printf("stop\n");}
               ;

Declarations  :  Declaration ';' Declarations 
              |  {printf("start\n");}
              ;

Declaration  : TYPE_INT id '=' Arithmetic_Expression { insert_int($2, $4); }
             | TYPE_INT id '[' Arithmetic_Expression ']' {  }
             | TYPE_INT id '[' Arithmetic_Expression ']' '[' Arithmetic_Expression ']' { }
             ;

Expressions : Assignment ';' Expressions
            | Arithmetic_Expression ';' Expressions
            | Relational_Expression ';' Expressions
            | Logical_Expression ';' Expressions
            | ReadStdin ';' Expressions
            | WriteStdout ';' Expressions
            | Conditional_Expression ';' Expressions
            | Cycle_Expression ';' Expressions
            |
/*            | FunctionInvocation Expressions */
            ;

Assignment : Assig Arithmetic_Expression       { printf("store\t//takes from the stack an value v and address a, and stores v in the address a\n");}
           | id '[' Arithmetic_Expression ']'  {  }
           | id '[' Arithmetic_Expression ']' '[' Arithmetic_Expression ']'  { }
          ;

Assig: id '=' { printf("//assignement\n");
           printf("pushgp\t//puts on stack the value of gp\n");
           printf("pushi %d\t//puts on stack the address of %s\n",global_pos_int($1),$1 ); } 
     ;
Arithmetic_Expression : Term
                      | Arithmetic_Expression '+' Term {printf("add\n");}
                      | Arithmetic_Expression '-' Term {printf("sub\n");}
                      ;

Term    : Factor
        | Term '*' Factor  { $$ = $1 * $3; printf("mul\n");}
        | Term '/' Factor  {printf("div\n");}
        ;

Factor  : num     { printf("pushi %d\n", $1); }
        | id       { printf("pushg %d\n", lookup_int($1));}
        | '(' Expressions ')'	{ }
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

void insert_int(char* varname, int value) {
  table_ints[index_ints].varname = strdup(varname);
  table_ints[index_ints].value = value;
  index_ints++;
}

int exists_int(char* varname) {
  int i, r;
  i = 0;
  while ((i < index_ints) && (strcmp(table_ints[i].varname, varname)!= 0)) i++;
  if (i == index_ints) r = 0; else r = 1;
  return r;
}

int exists_array(char* varname) {
  int i, r;
  i = 0;
  while ((i < index_arrays) && (strcmp(table_arrays[i].varname, varname)!= 0)) i++;
  if (i == index_arrays) r = 0; else r = 1;
  return r;
}

int exists_matrix(char* varname) {
  int i, r;
  i = 0;
  while ((i < index_matrices) && (strcmp(table_matrices[i].varname, varname)!= 0)) i++;
  if (i == index_matrices) r = 0; else r = 1;
  return r;
}

int global_pos_int(char* varname) {
  int i, r;
  i = 0;
  while( (i < index_ints ) && (strcmp(table_ints[i].varname, varname)!= 0)) i++;
  if ( i == index_ints ) r = -1;  else r = i;
  return r;
}

int lookup_int(char* varname) {
  int i, r;
  i = 0;
  while( (i < index_ints ) && (strcmp(table_ints[i].varname, varname)!= 0)) i++;
  if ( i == index_ints ) r = 0; else r = table_ints[i].value;
  return r;
}

int lookup_array(char* varname, int pos) {
  int i, r;
  i = 0;
  while( (i < index_arrays ) && (strcmp(table_arrays[i].varname, varname)!= 0)) i++;
  if ( i == index_arrays ) r = 0; else r = (table_arrays[i].values)[pos];
  return r;
}

int lookup_matrix(char* varname, int row, int col) {
  int i, r;
  i = 0;
  while( (i < index_matrices ) && (strcmp(table_matrices[i].varname, varname)!= 0)) i++;
  if ( i == index_matrices ) r = 0; else {
    r = (table_matrices[i].values)[row][col];
  }
  return r;
}

int yyerror(char* s) {
  printf("Error: %s\n", s);
  return 1;
}

int main () {
  yyparse();
  return 0;
}
