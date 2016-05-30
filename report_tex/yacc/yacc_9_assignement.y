Assignment : id '=' Assignement_Value 
           | Vectors
           '=' Assignement_Value 
           ;

Assignement_Value : Arithmetic_Expression
                  | Read_Stdin
                  | Function_Invocation
                  ;
