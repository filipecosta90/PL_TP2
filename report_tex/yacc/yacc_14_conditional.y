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

Else_Clause : PL_ELSE 
            '{' Instructions '}' 
            | PL_ELSE 
            Instruction 
            | /*empty*/
            ;
