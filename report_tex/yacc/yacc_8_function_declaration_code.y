Function_Declaration : 
                     TYPE_FUNCTION id '('')' '{'
                     {
                       assert_no_redeclared_var($2,PL_FUNCTION);
                       printf("\t\t\t\t\t\t// +++ Function Declaration Start +++\n");
                       insert_function($2);
                       printf("\t\tjump endfunction%s\n",$2);
                       printf("startfunction%s:\n",$2);
                       printf("\t\tnop\t\t// no operation\n");
                     }
                     Instructions Return_Statement 
                     '}'
                     {
                       printf("\t\tstoreg %d\t// store returned value of  %s\n",global_pos($2),$2);
                       printf("\t\treturn\n");
                       printf("endfunction%s:\n",$2);
                       printf("\t\t\t\t\t\t// --- Function Declaration End ---\n");
                     }
                     ;

Function_Invocation : 
                    PL_CALL id '(' ')' 
                    { 
                      assert_declared_var($2,PL_FUNCTION);
                      printf("\t\tpusha startfunction%s\n",$2);
                      printf("\t\tcall\n");
                      printf("\t\tpushg %d\t// pushes returned value of  %s\n",global_pos($2),$2);
                    }
                    ;
