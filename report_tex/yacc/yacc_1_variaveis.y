%{

%}

%union {int qt; char* var;}

%token <var>id
%token <qt>num 

%token TYPE_INT

%nonassoc PL_THEN
%nonassoc PL_ELSE 

%start AlgebricScript

%%

AlgebricScript : Declarations 
               ;

Declarations  : 
              Declarations Declaration ';'
              | /*empty*/ 
              ;

Declaration  : 
             TYPE_INT id  
             | TYPE_INT id '[' num  ',' num  ']' 
             | TYPE_INT id '[' num  ']' 
             ;
%%

#include "lex.yy.c"

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

