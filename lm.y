%{
#include <stdio.h>
%}

%union {int value; int*array; int**matrix; char* string; }

%token BEGIN END
%token INT_DECL VEC_DECL MAT_DECL
%token <array>VECTOR
%token <matrix>MATRIX
%token <string>VARNAME
%token <value>number
%%


Mathscript : BEGIN Expressions END { }
      ;

Expressions : Expression ';' RemainingExp  {  }
      ;

RemainingExp : Expression ';' RemainingExp {}
      | 
      ;

Expression : Declaration
           | DeclararionStruct
           | BasicAlgorithm
           | ReadStdin
           | WriteStdout
           | Conditional
           | Cycle
           | FunctionDefinition
           | FunctionInvocation
           ;

Declaration : INT_DECL VARNAME '=' number ';'
            | INT_DECL VARNAME ';'
            ;
DeclarationStruct : VEC_DECL'['number']' VARNAME ';'
            | MAT_DECL'['number']''['number']' VARNAME ';'
            ;

BasicAlgorithm : 



%%

#include "lex.yy.c"


int yyerror( char* msg ){
  printf("erro sintatico %s\n", msg);
  return 0;
}

int main(){
  yyparse();
  printf("N Pal: %d\nN Num:%d (%d)\n", n_pal, n_num, t_num );
  return 0;
}
