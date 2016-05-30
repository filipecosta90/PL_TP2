Declaration  : 
             TYPE_INT id  
             { 
               assert_no_redeclared_var($2,PL_INTEGER);
               insert_int($2); 
             }
             | TYPE_INT id '[' num  ',' num  ']' 
             { 
               assert_no_redeclared_var($2,PL_MATRIX);
               insert_matrix($2,$4,$6); 
             }
             | TYPE_INT id '[' num  ']' 
             { 
               assert_no_redeclared_var($2,PL_ARRAY);
               insert_array($2, $4); 
             }
             ;
