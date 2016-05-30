Logical_Expressions : Logical_Expressions Logical_Expression
                    |
                    ;

Logical_Expression : '!' Relational_Expression 
                   | Relational_Expression
                   | Logical_Expression '|''|' Relational_Expression 
                   | Logical_Expression '&''&' Relational_Expression
                   ;
