%{

%}

%union {int qt; char* var;}

%token <var>id
%token <qt>num 
%token <var>string

%token TYPE_INT
%token TYPE_FUNCTION

%token PL_IF PL_THEN PL_ELSE
%token PL_DO PL_WHILE
%token PL_PRINT 
%token PL_READ
%token PL_CALL
%token PL_RETURN

%start AlgebricScript

%%

AlgebricScript : Declarations Function_Declarations Instructions 
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
             | TYPE_INT id '[' num  ',' num  ']' 
             | TYPE_INT id '[' num  ']' 
             ;


Function_Declaration : 
                     TYPE_FUNCTION id '('')' '{'
                     Instructions 
                     Return_Statement '}'
                     ;

Function_Invocation : 
                    PL_CALL id '(' ')' 
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
           | Vectors '=' Assignement_Value 
           ;

Assignement_Value : Arithmetic_Expression
                  | Read_Stdin
                  | Function_Invocation
                  ;
Vectors : id '[' Arithmetic_Expression Second_Dimension Dimension_End
        ; 

Second_Dimension : ','  Arithmetic_Expression 
                 | /*empty*/ 
                 ;

Dimension_End : ']'
              ;

Read_Stdin : PL_READ '(' ')' 
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

Conditional : If_Starter
            PL_THEN '{' Instructions '}' 
            Else_Clause 
            | If_Starter
            PL_THEN  Instruction 
            Else_Clause 
            ;

If_Starter :
           PL_IF 
           '(' Logical_Expressions ')' 
           ;

Else_Clause : PL_ELSE '{' Instructions '}' 
            | PL_ELSE Instruction 
            | /*empty*/
            ;

Cycle : PL_DO '{' Instructions '}' PL_WHILE '(' Logical_Expressions ')' 
      | PL_DO Instruction PL_WHILE '(' Logical_Expressions ')' 
      ;

WriteStdout : PL_PRINT id 
            | PL_PRINT Vectors
            | PL_PRINT num 
            | PL_PRINT string
            ;
%%

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

