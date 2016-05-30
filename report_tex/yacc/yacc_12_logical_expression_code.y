Logical_Expressions : Logical_Expressions Logical_Expression
                    | 
                    ;

Logical_Expression : '!' Relational_Expression 
                   {
                     printf("\t\t\t\t\t\t// +++ Logical NOT BEGIN +++\n");
                     printf("\t\tpushi 1\n");
                     printf("\t\tadd\n");
                     printf("\t\tpushi 2\n");
                     printf("\t\tmod\n");
                     printf("\t\t\t\t\t\t// --- Logical NOT END ---\n");
                   }
                   | Relational_Expression
                   | Logical_Expression '|''|' Relational_Expression 
                   {
                     printf("\t\t\t\t\t\t// +++ Logical OR BEGIN +++\n");
                     printf("\t\tadd\n");
                     printf("\t\tpushi 2\n");
                     printf("\t\tmod\n");
                     printf("\t\t\t\t\t\t// --- Logical OR END ---\n");
                   }
                   | Logical_Expression '&''&' Relational_Expression
                   {
                     printf("\t\t\t\t\t\t// +++ Logical AND BEGIN +++\n");
                     printf("\t\tmul\n");
                     printf("\t\tpushi 2\n");
                     printf("\t\tmod\n");
                     printf("\t\t\t\t\t\t// --- Logical AND END ---\n");
                   }
                   ;
