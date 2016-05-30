Function_Declaration : 
                     TYPE_FUNCTION id '('')' '{'
                     Instructions Return_Statement 
                     '}'
                     ;

Function_Invocation : 
                    PL_CALL id '(' ')' 
                    ;
