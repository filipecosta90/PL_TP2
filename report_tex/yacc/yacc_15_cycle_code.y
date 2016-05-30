Cycle : PL_DO 
      {
        int cycle_id = open_cycle();
        printf("\t\t\t\t\t\t// +++ CICLE DO BEGIN +++\n");
        printf("cycle%d:\t//do\n",cycle_id);
      }
      '{' Instructions '}' PL_WHILE '(' Logical_Expressions ')' 
      {
        int cycle_closed = close_cycle();
        printf("\t\tjz endcycle%d\t//while\n",cycle_closed);
        printf("\t\tjump cycle%d\n",cycle_closed);
        printf("endcycle%d:\n",cycle_closed);
        printf("\t\t\t\t\t\t// --- CICLE DO END ---\n");
      }
      | PL_DO 
      {
        int cycle_id = open_cycle();
        printf("\t\t\t\t\t\t// +++ CICLE DO BEGIN +++\n");
        printf("cycle%d:\t//do\n",cycle_id);
      }
      Instruction PL_WHILE '(' Logical_Expressions ')' 
      {
        int cycle_closed = close_cycle();
        printf("\t\tjz endcycle%d\t//while\n",cycle_closed);
        printf("\t\tjump cycle%d\n",cycle_closed);
        printf("endcycle%d:\n",cycle_closed);
        printf("\t\t\t\t\t\t// --- CICLE DO END ---\n");
      }
      ;
