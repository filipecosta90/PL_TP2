Assignment : id '=' Assignement_Value 
           {
             assert_declared_var($1, PL_INTEGER );
             printf("\t\tstoreg %d\t// store var %s\n",global_pos($1),$1);
           }
           | Vectors
           '=' Assignement_Value 
           {
             printf("\t\tstoren\n");
           }
           ;

Assignement_Value : Arithmetic_Expression
                  | Read_Stdin
                  | Function_Invocation
                  ;
