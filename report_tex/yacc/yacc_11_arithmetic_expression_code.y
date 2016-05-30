Arithmetic_Expression : Term 
                      | Arithmetic_Expression '+' Term { printf("\t\tadd\n");}
                      | Arithmetic_Expression '-' Term { printf("\t\tsub\n");}
                      ;

Term    : Factor 
        | Term '*' Factor  { printf("\t\tmul\n");}
        | Term '/' Factor  { printf("\t\tdiv\n");}
        | Term '%' Factor  { printf("\t\tmod\n");}
        ;

Factor  : num     
        { printf("\t\tpushi %d\n", $1); }
        | id
        {
          assert_declared_var($1, PL_INTEGER);
          printf("\t\tpushg %d\n", global_pos($1));
        }
        | Vectors { printf("\t\tloadn \n");}
        | '(' Arithmetic_Expression ')'
        ;
