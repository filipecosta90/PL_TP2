%{
#include <stdio.h>

typedef struct {
  char* var;
  int val;
} pair;

pair table[100];

int t_index = 0;

void insert(char* var, int val);
int lookup(char* var);
int exists(char* var);
%}

%union {int qt; char* var;}

%token <qt>num 
%token <var>id
%token <var>structured_id
%token LOG_AND

/*
%type <qt>Termo
%type <qt>ExprA
*/
%%

AlgebricScript : Declarations Expressions
                ;

Declarations  :
              | Declarations Declaration
              ;

Declaration  : id '=' Arithmetic_Expression ';'{insert($1, 0); }
             | structured_id '[' Arithmetic_Expression ']' ';' {  }
             | structured_id '[' Arithmetic_Expression ']' '[' Arithmetic_Expression ']' ';' { }
             ;

Expressions :  Arithmetic_Expression Expressions
            | Relational_Expression Expressions
            | Logical_Expression Expressions
            | ReadStdin Expressions
            | WriteStdout Expressions
            | Conditional_Expression Expressions
            | Cycle_Expression Expressions
            |
/*            | FunctionInvocation Expressions */
            ;

Arithmetic_Expression : Term 
                      | Arithmetic_Expression '+' Term {printf("add\n");}
                      | Arithmetic_Expression '-' Term {printf("sub\n");}
                      ;

Term    : Factor
        | Term '*' Factor  {printf("mul\n");}
        | Term '/' Factor  {printf("div\n");}
        ;

Factor  : num     { printf("pushi %d\n", $1); }
        | id       { printf("pushg %d\n", lookup($1));}
        | '(' Expressions ')'	{ }
        ;

Relational_Expression :
                      ;

Logical_Expression :
                   ;

ReadStdin :
          ;

WriteStdout :
            ;

Conditional_Expression :
                       ;

Cycle_Expression :
                 ;

%%

#include "lex.yy.c"

void insert(char* var, int val) {
  table[t_index].var = strdup(var);
  table[t_index++].val = val;
}

int exists(char* var) {
  int i, r;
  i = 0;
  while ((i < t_index) && (strcmp(table[i].var, var)!= 0)) i++;
  if (i == t_index) r = 0; else r = 1;
  return r;
}

int lookup(char* var) {
  int i, r;
  i = 0;
  while((i < t_index) && (strcmp(table[i].var, var)!= 0)) i++;
  if (i == t_index) r = 0; else r = table[i].val;
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
