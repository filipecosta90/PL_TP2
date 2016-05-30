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
