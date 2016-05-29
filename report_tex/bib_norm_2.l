%{

/*
********************************************************************************
*   Copyright(C) 2016 Filipe Oliveira, Universidade do Minho
*   All Rights Reserved.
*
********************************************************************************
*   Content : 2b) bibtex file normalizer and pretty-printer
********************************************************************************/

#include <stdio.h>
#include <glib.h>
#include <stdlib.h>
#include <string.h>

//HashTable
GHashTable *txt_fields_table; 
GHashTable *num_fields_table; 
GHashTable *authors_table; 
char* field_id;
char* field;
char* author_id = "author";
char* title_id = "title";
char* author_key;
char* title_key;
char* author_initial;
char* author_lastname;

//function sig
void pretty_print();

%}

LETRA [A-Za-z]
LETRA_NUM [0-9A-Za-z]
NUM [0-9]
CATEG \@{LETRA}+\{
FIELD_ID ^[^,}"][^=]*=[ \t]*
FIELD_BREAK [^=]*[ \t\n]*(\"|\})
FIELD_BREAK_NUM [^=\}]*\}?
FIELD_START [\{\"]
AUTHOR_ID ^[ \t]*[Aa][Uu][Tt][Hh][Oo][Rr][ \t]*=[ \t]*
TITLE_ID ^[ \t]*[Tt][Ii][Tt][Ll][Ee][ \t]*=[ \t]*
AUTHOR_SEP [ \t]and[ \t]
AUTHOR_BREAK [^=]+(\"|\})
 
%x INSIDE IN_AUTHOR IN_FIELD_TXT IN_FIELD_NUM AUTHOR_DIV START_AUTHOR

%%

{CATEG}[^=]*,            {
                          printf("%s\n",yytext);
                          BEGIN INSIDE;
                         }

<INSIDE>{TITLE_ID}{FIELD_START}  {   
                          yytext[yyleng-2]='\0';
                          title_key = strdup ( yytext );
                          title_key = g_strchomp ( title_key );
                          title_key = g_strchug ( title_key );
                          field_id = strdup(title_key);
                          BEGIN IN_FIELD_TXT;}

<INSIDE>{AUTHOR_ID}{FIELD_START}  {   
                          yytext[yyleng-2]='\0';
                          author_key = strdup ( yytext );
                          author_key = g_strchomp ( author_key );
                          author_key = g_strchug ( author_key );
                          BEGIN START_AUTHOR;
}

<INSIDE>{FIELD_ID}/{LETRA_NUM}  {   
                         yytext[yyleng-1]='\0';
                          field_id = strdup ( yytext );
                          field_id = g_strchomp ( field_id );
                          field_id = g_strchug ( field_id );
                          BEGIN IN_FIELD_NUM; }

<INSIDE>{FIELD_ID}{FIELD_START}  {   
                          yytext[yyleng-2]='\0';
                          field_id = strdup ( yytext );
                          field_id = g_strchomp ( field_id );
                          field_id = g_strchug ( field_id );
                          BEGIN IN_FIELD_TXT;
                          }

<INSIDE>[ \n\t]*, { BEGIN INSIDE; }
<INSIDE>[ \n\t]*\} { BEGIN INITIAL; }
<INSIDE>.|\n { BEGIN INSIDE;}

<START_AUTHOR>.          {
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
                          g_hash_table_insert (  authors_table, (void*) initial_plus_lastname,   GINT_TO_POINTER (0) );
                          BEGIN AUTHOR_DIV;
}

<IN_AUTHOR>.              { ; }

<AUTHOR_DIV>,             { BEGIN INSIDE; }

<AUTHOR_DIV>[ ]and[ ]     { BEGIN START_AUTHOR; }


<IN_FIELD_NUM>{FIELD_BREAK_NUM}[ \n\t\r]*\} {
                            yytext[yyleng-1]='\0';
                            field = strdup(yytext);
                            field = g_strchomp ( field );
                            field = g_strchug ( field );
                            g_hash_table_insert (  num_fields_table, (void*) field_id,  (void*) field );
                            pretty_print();
                            BEGIN INITIAL;
                            }

<IN_FIELD_NUM>{FIELD_BREAK_NUM}[ \n\t\r]*(#[^,=]*)?, {
                            yytext[yyleng-1]='\0';
                            field = strdup(yytext);
                            field = g_strchomp ( field );
                            field = g_strchug ( field );
                            g_hash_table_insert (  num_fields_table, (void*) field_id,  (void*) field );
                            BEGIN INSIDE;
                            }

<IN_FIELD_TXT>{FIELD_BREAK}[ \n\t\r]*\} {
                            yytext[yyleng-2]='\0';
                            field = strdup(yytext);
                            field = g_strchomp ( field );
                            field = g_strchug ( field );
                            g_hash_table_insert (  txt_fields_table, (void*) field_id,  (void*) field );
                            BEGIN INITIAL;
                            pretty_print();
                            }

<IN_FIELD_TXT>{FIELD_BREAK}[ \n\t\r]*(#[^,=]*)?, {
                            yytext[yyleng-2]='\0';
                            field = strdup(yytext);
                            field = g_strchomp ( field );
                            field = g_strchug ( field );
                            g_hash_table_insert (  txt_fields_table, (void*) field_id,  (void*) field );
                            BEGIN INSIDE;
                            }

<IN_FIELD_TXT>.|\n {;}
<IN_FIELD_NUM>.|\n {;}

{CATEG}[^\n]*\}             { printf("%s\n",yytext);}

<INITIAL>.|\n {;}

%%

void pretty_print(){
  int field_num = 0;
  char* current_value;

  GHashTableIter iter;
  gpointer key, value;

  if( title_key != NULL ){
    current_value =  g_hash_table_lookup ( txt_fields_table,(void*) title_key);
    g_hash_table_remove ( txt_fields_table, (void*) title_key);
    printf("\t%s {%s}", title_key, current_value);
    field_num++;
  }

  if ( author_key != NULL ){
    if(field_num > 0){ printf(",\n"); }
    printf("\t%s {", author_key);
    int number_authors = g_hash_table_size ( authors_table );
    int author_num = 1;
    g_hash_table_iter_init (&iter, authors_table );
    while (g_hash_table_iter_next (&iter, &key, &value)){
      if(author_num > 1 ){ printf("\n\t\tand "); }
      char* name = (char*) key;
      printf("%s", name);
      g_hash_table_iter_remove (&iter);
      author_num++;
    } 
    printf("}");
    field_num++;
  }

  int size = g_hash_table_size ( txt_fields_table );
  size += g_hash_table_size ( num_fields_table );
  g_hash_table_iter_init (&iter, txt_fields_table );
  while (g_hash_table_iter_next (&iter, &key, &value)){
    if(field_num > 0 ){ printf(",\n"); }
    char* val = (char*) value;
    char* ke = (char*) key;
    printf("\t%s {%s}", ke, val);
    g_hash_table_iter_remove (&iter);
  } 

  g_hash_table_iter_init (&iter, num_fields_table );
  while (g_hash_table_iter_next (&iter, &key, &value)){
    if(field_num > 0 ){ printf(",\n"); }
    char* val = (char*) value;
    char* ke = (char*) key;
    printf("\t%s %s", ke, val);
    g_hash_table_iter_remove (&iter);
  }
  printf("\n}\n\n");
}

int yywrap(){return 1;}

int main(){
  txt_fields_table = g_hash_table_new(g_str_hash, g_str_equal);
  num_fields_table = g_hash_table_new(g_str_hash, g_str_equal);
  authors_table = g_hash_table_new(g_str_hash, g_str_equal);
  yylex();
  return (0);
}

