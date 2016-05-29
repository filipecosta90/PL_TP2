%{

/*
********************************************************************************
*   Copyright(C) 2016 Filipe Oliveira, Universidade do Minho
*   All Rights Reserved.
*
********************************************************************************
*   Content : Simple bibtex category counter (phDThesis, Misc, InProceeding,
*             etc.), that occur in a document
********************************************************************************/

#include <stdio.h>
#include <glib.h>
#include <stdlib.h>
#include <string.h>

//HashTable
GHashTable *table; 

%}

LETRA [A-Za-z]
CATEG \@{LETRA}+\{
LETRA_NUM [0-9A-Za-z]
ID ({LETRA_NUM}|:)+

%%
{CATEG}/[^=]*,      {
              yytext++; yytext[yyleng-2]='\0';
              char* key = g_ascii_strdown (yytext, yyleng-2);
              if ( g_hash_table_contains ( table ,(void*) key ) ){
                int value;
                value = GPOINTER_TO_INT( g_hash_table_lookup ( table,(void*) key));
                value++;
                g_hash_table_replace (  table, (void*) key,GINT_TO_POINTER(value) );
              }
              else {
                int value = 1;
                gboolean add_result = g_hash_table_insert (  table, (void*) key,  GINT_TO_POINTER(value) );
              }
             }
.|\n|\t { ; }
%%

int yywrap(){return 1;}

static void print_key_value(gpointer key, gpointer value, gpointer userdata)
{
        int val = (int) value;
        char* ke = (char*) key;
        printf("<li>%s : %d</li>\n", ke, val);
}


int main(){
  table = g_hash_table_new(g_str_hash, g_str_equal);
  yylex();
  printf("<!DOCTYPE html>\n<html>\n<body>\n<ul>\n");
  g_hash_table_foreach(table,print_key_value, NULL );
  printf("</ul>\n</body>\n</html>\n");
  return (0);
}

