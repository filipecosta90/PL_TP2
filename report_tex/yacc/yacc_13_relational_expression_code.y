Relational_Expression : Arithmetic_Expression
                      | Arithmetic_Expression '=''=' Arithmetic_Expression
                      {
                        printf("\t\tequal\t//relational equal\n");
                      }
                      | Arithmetic_Expression '!''=' Arithmetic_Expression 
                      {
                        printf("\t\t\t\t\t\t// +++ Logical NOT EQUAL BEGIN +++\n");
                        printf("\t\tequal\n");
                        printf("\t\tpushi 1\n");
                        printf("\t\tadd\n");
                        printf("\t\tpushi 2\n");
                        printf("\t\tmod\n");
                        printf("\t\t\t\t\t\t// --- Logical NOT EQUAL END ---\n");
                      }
                      | Arithmetic_Expression '>' Arithmetic_Expression 
                      {
                        printf("\t\tsup\t//relational superior\n");
                      }
                      | Arithmetic_Expression '>''=' Arithmetic_Expression 
                      {
                        printf("\t\tsupeq\t//relational superior or equal\n");
                      }
                      | Arithmetic_Expression '<' Arithmetic_Expression 
                      {
                        printf("\t\tinf\t//relational inferior\n");
                      }
                      | Arithmetic_Expression '<''=' Arithmetic_Expression 
                      {
                        printf("\t\tinfeq\t//relational inferior or equal\n");
                      }
                      | '(' Logical_Expressions ')'
                      ;
