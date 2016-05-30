Vectors : id
        { 
        if ( is_vector($1) ){
          assert_declared_var($1,PL_ARRAY);
        }
        else{
          assert_declared_var($1,PL_MATRIX);
        }
          printf("\t\tpushgp\n");
          printf("\t\tpushi %d\t//puts on stack the address of %s\n",global_pos($1),$1 ); 
          printf("\t\tpadd\n");
          printf("\t\t\t\t\t\t// +++ Matrix or Vector Dimension Start +++\n");
        }
        '[' 
        Arithmetic_Expression 
        {
        if ( is_vector($1) ){
        }
        else {
          printf("\t\tpushi %d\t\t\t\t//pushes column size of vector or matrix\n",get_matrix_ncols($1));
          printf("\t\tmul\n");
        }
        }
        Second_Dimension Dimension_End
        ; 

Second_Dimension : ','  Arithmetic_Expression 
                 | /*empty*/ {printf("\t\tpushi 0\t\t//second dimension size of vector(0)\n");} 
                 ;

Dimension_End : ']'
              {
                printf("\t\tadd\t\t//sums both dimensions\n");
                printf("\t\t\t\t\t\t// --- Matrix or Vector Dimension End ---\n");
              }
              ;
