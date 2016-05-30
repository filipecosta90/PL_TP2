Conditional : If_Starter
            PL_THEN '{' Instructions '}' 
            {
              int conditional_id = current_conditional();
              printf("\t\tjump outif%d\n",conditional_id); 
              printf("inelse%d:\n",conditional_id);
            }
            Else_Clause 
            {
              printf("\t\t\t\t\t\t// --- CONDITIONAL IF END ---\n");
            }
            | If_Starter
            PL_THEN  Instruction 
            {
              int conditional_id = current_conditional();
              printf("\t\tjump outif%d\n",conditional_id); 
              printf("inelse%d:\n",conditional_id);
            }
            Else_Clause 
            {
              printf("\t\t\t\t\t\t// --- CONDITIONAL IF END ---\n");
            }
            ;

If_Starter :
           {
             int conditional_id = open_conditional();
             printf("\t\t\t\t\t\t// +++ CONDITIONAL IF BEGIN +++\n");
             printf("conditional%d:\n",conditional_id);
           }
           PL_IF 
           '(' Logical_Expressions ')' 
           {
             int conditional_id = current_conditional();
             printf("\t\tjz inelse%d\n",conditional_id); 
             printf("inthen%d:\n",conditional_id);
           }
           ;

Else_Clause : PL_ELSE 
            '{' Instructions '}' 
            {
              int conditional_closed = close_conditional();
              printf("outif%d:\n",conditional_closed);
            }
            | PL_ELSE 
            Instruction 
            {
              int conditional_closed = close_conditional();
              printf("outif%d:\n",conditional_closed);
            }
            | /*empty*/
            {
              int conditional_closed = close_conditional();
              printf("outif%d:\n",conditional_closed);
            }
            ;
