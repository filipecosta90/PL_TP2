Vectors : id
        '[' 
        Arithmetic_Expression 
        Second_Dimension Dimension_End
        ; 

Second_Dimension : ','  Arithmetic_Expression 
                 | /*empty*/ 
                 ;

Dimension_End : ']'
              ;
