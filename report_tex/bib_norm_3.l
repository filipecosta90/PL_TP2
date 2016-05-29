%{

/*
********************************************************************************
*   Copyright(C) 2016 Filipe Oliveira, Universidade do Minho
*   All Rights Reserved.
*
********************************************************************************
*   Content : 2c) bibtex co-authoring graph builder for a given normalized.
*             author name.
********************************************************************************/

#include <stdio.h>
#include <glib.h>
#include <stdlib.h>
#include <string.h>

//HashTable
GHashTable *authors_table; 
GHashTable *coauthors_table; 
char* author_key;
char* author_initial;
char* author_lastname;
char* author_name; 
//function sig
void print_graph();
void check_authors();

%}

LETRA [A-Za-z]
LETRA_NUM [0-9A-Za-z]
NUM [0-9]
CATEG \@{LETRA}+\{
FIELD_START [\{\"]
AUTHOR_ID [ \t]*[Aa][Uu][Tt][Hh][Oo][Rr][ \t]*=[ \t]*
AUTHOR_SEP [ \t]and[ \t]
AUTHOR_BREAK [^=]+(\"|\})
 
%x INSIDE IN_AUTHOR IN_FIELD_TXT IN_FIELD_NUM AUTHOR_DIV START_AUTHOR

%%

{CATEG}[^=]*,           { BEGIN INSIDE; }

<INSIDE>{AUTHOR_ID}{FIELD_START}  {   
                          yytext[yyleng-2]='\0';
                          author_key = strdup ( yytext );
                          author_key = g_strchomp ( author_key );
                          author_key = g_strchug ( author_key );
                          BEGIN START_AUTHOR;
}

<INSIDE>[ \n\t]*,       { BEGIN INSIDE; }
<INSIDE>[ \n\t]*\}      { BEGIN INITIAL; }

<INSIDE>.|\n              { BEGIN INSIDE;}

<START_AUTHOR>.           {
                          author_initial = (char*) malloc ( 4* sizeof(char));
                          author_initial[0] = yytext[0];
                          author_initial[1] = '.';
                          author_initial[2]=' ';
                          author_initial[3]='\0';
                          BEGIN IN_AUTHOR;
                         }

<IN_AUTHOR>[^= \n\t]*/[ ]and[ ]     {   
                          author_lastname = strdup ( yytext );
                          author_lastname = g_strchomp ( author_lastname );
                          author_lastname = g_strchug ( author_lastname );
                          char *initial_plus_lastname;
                          int size = strlen(author_lastname);
                          size += strlen( author_initial) + 1;
                          initial_plus_lastname = (char*) malloc ( size * sizeof(char));
                          strcpy(initial_plus_lastname, author_initial);
                          strcat(initial_plus_lastname, author_lastname);
                          g_hash_table_insert (  authors_table, (void*) initial_plus_lastname,   GINT_TO_POINTER (0) );
                          BEGIN AUTHOR_DIV;
                          }

<IN_AUTHOR>[^= \n\t]*[ \t]?(\"|\})/,    { 
                          yytext[yyleng-1]='\0';
                          author_lastname = strdup ( yytext );
                          author_lastname = g_strchomp ( author_lastname );
                          author_lastname = g_strchug ( author_lastname );
                          char *initial_plus_lastname;
                          int size = strlen(author_lastname);
                          size += strlen( author_initial) + 1;
                          initial_plus_lastname = (char*) malloc ( size * sizeof(char));
                          strcpy(initial_plus_lastname, author_initial);
                          strcat(initial_plus_lastname, author_lastname);
                          g_hash_table_insert (  authors_table, (void*) initial_plus_lastname,   GINT_TO_POINTER (1) );
                          BEGIN AUTHOR_DIV;
}

<IN_AUTHOR>.              { ; }
<AUTHOR_DIV>,             { check_authors(); BEGIN INSIDE; }
<AUTHOR_DIV>[ ]and[ ]             { BEGIN START_AUTHOR; }
<INITIAL>.|\n {;}

%%

void check_authors(){
  if ( g_hash_table_contains ( authors_table ,(void*) author_name ) ){
    g_hash_table_remove( authors_table, author_name );
    GHashTableIter iter;
    gpointer key, value;
    g_hash_table_iter_init (&iter, authors_table );
    while (g_hash_table_iter_next (&iter, &key, &value)){
      char* coauthor_name = (char*) key;
      int number_entries = 0;
      if ( g_hash_table_contains ( coauthors_table ,key ) ){
        number_entries = GPOINTER_TO_INT( g_hash_table_lookup ( coauthors_table , key));
        number_entries++;
        g_hash_table_replace (  coauthors_table, key, GINT_TO_POINTER( number_entries ) );
      }
      else{
        number_entries++;
        g_hash_table_insert (  coauthors_table, key,   GINT_TO_POINTER (number_entries) );
      }
    }
  }
  g_hash_table_remove_all( authors_table );
}

void graph_print(){

  GHashTableIter iter;
  gpointer key, value;
  g_hash_table_iter_init (&iter, coauthors_table );

  printf( "digraph pl_2_2_a {\n//title\nlabelloc=\"t\";\nlabel=\"%s Document collaboration and co-authoring diagram\";rankdir=TB;\nresolution=300;size=\"8,5\";", author_name);
  printf("\"%s\"[shape = box,style=filled,color=\"red\", style=rounded, fontsize=16 fontname=helvetica];\n", author_name);
  printf("node [shape = box, style=rounded, fontsize=12 fontname=helvetica]");
  while (g_hash_table_iter_next (&iter, &key, &value))
  {
    char* coauthor_name = g_str_to_ascii ((char*) key, "C");
    int number_entries = GPOINTER_TO_INT( value );
    printf("\"%s\" -> \"%s\" [ label = \"%d\" ]\n", author_name, coauthor_name, number_entries );
  }
  printf("}\n");
} 

int yywrap(){return 1;}

int main(int argc, char** argv){
  authors_table = g_hash_table_new(g_str_hash, g_str_equal);
  coauthors_table = g_hash_table_new(g_str_hash, g_str_equal);
  author_name = strdup(argv[1]);
  yylex();
  graph_print();
  return (0);
}

