void assert_no_redeclared_var( char* varname ,var_type type){
    if ( exists_var(varname, type) ){
        compile_error("re-declaring VAR");
    }
}