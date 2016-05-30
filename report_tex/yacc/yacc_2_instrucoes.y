%{

%}

%union {int qt; char* var;}

%token <var>id
%token <qt>num 

%token TYPE_INT

%start AlgebricScript

%%

AlgebricScript : Declarations Instructions 
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

Instructions : Instructions Instruction 
             | /*empty*/ 
             ;

Instruction : Assignment ';'
            ;

Assignment : id '=' Assignement_Value 
           | Vectors '=' Assignement_Value 
           ;

Assignement_Value : Arithmetic_Expression
                  ;

Vectors : id '[' Arithmetic_Expression Second_Dimension Dimension_End
        ;

Second_Dimension : ','  Arithmetic_Expression 
                 | /*empty*/ 
                 ;

Dimension_End : ']'
              ;

Arithmetic_Expression : Term 
                      | Arithmetic_Expression '+' Term 
                      | Arithmetic_Expression '-' Term 
                      ;

Term    : Factor 
        | Term '*' Factor  
        | Term '/' Factor 
        | Term '%' Factor
        ;

Factor  : num     
        | id
        | Vectors 
        | '(' Arithmetic_Expression ')'
        ;

Logical_Expressions : Logical_Expressions Logical_Expression
                    | 
                    ;

Logical_Expression : '!' Relational_Expression 
                   | Relational_Expression
                   | Logical_Expression '|''|' Relational_Expression 
                   | Logical_Expression '&''&' Relational_Expression
                   ;

Relational_Expression : Arithmetic_Expression
                      | Arithmetic_Expression '=''=' Arithmetic_Expression
                      | Arithmetic_Expression '!''=' Arithmetic_Expression 
                      | Arithmetic_Expression '>' Arithmetic_Expression 
                      | Arithmetic_Expression '>''=' Arithmetic_Expression 
                      | Arithmetic_Expression '<' Arithmetic_Expression 
                      | Arithmetic_Expression '<''=' Arithmetic_Expression 
                      | '(' Logical_Expressions ')'
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

