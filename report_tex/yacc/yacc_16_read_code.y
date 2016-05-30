WriteStdout : PL_PRINT id 
            {
              printf("\t\tpushgp\n");
              assert_declared_var($2, PL_INTEGER);
              printf("\t\tpushi %d\t//puts on stack the address of %s\n",global_pos($2),$2 ); 
              printf("\t\tpadd\n");
              printf("\t\tpushi 0\n");
              printf("\t\tloadn\n\t\twritei\n");
            }
            | PL_PRINT Vectors
            {
              printf("\t\tloadn\n\t\twritei\n");
            }
            | PL_PRINT num 
            { 
              printf("\t\tpushi %di\t//print num %d\n",$2,$2); 
              printf("\t\twritei\n"); 
            }
            | PL_PRINT string
            { 
              printf("\t\tpushs %s\t//print string %s\n",$2,$2); 
              printf("\t\twrites\n"); 
            }
            ;
