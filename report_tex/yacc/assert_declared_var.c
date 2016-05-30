void assert_declared_var(char* varname, var_type type){
    if ( !exists_var(varname, type) ){
        compile_error("accessing non declared VAR");
    }
}