void compile_error( char* message){
    yyerror(message);
    exit(0);
}