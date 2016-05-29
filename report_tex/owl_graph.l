%{

/*
********************************************************************************
*   Copyright(C) 2016 Filipe Oliveira, Universidade do Minho
*   All Rights Reserved.
*
********************************************************************************
*   Content : 2.1) Simple OWL Ontology Graphic Viewer 
*             
*
********************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* relation;
char* begin;
char* end;
char* data;
char* class;
char* value;
char* class_class;
char* class_subclass;

void print_prop();
void print_data();
void print_class();
%}

LETRA [A-Za-z]
LETRA_NUM [0-9A-Za-z]
NUM [0-9]
OBJ_PROP_AXIOM SubObjectPropertyOf|EquivalentObjectProperties|DisjointObjectProperties|InverseObjectProperties|ObjectPropertyDomain|ObjectPropertyRange|FunctionalObjectProperty|InverseFunctionalObjectProperty|ReflexiveObjectProperty|IrreflexiveObjectProperty|SymmetricObjectProperty|AsymmetricObjectProperty|TransitiveObjectProperty
DAT_PROP_AXIOM SubDataPropertyOf|EquivalentDataProperties|DisjointDataProperties|DataPropertyDomain|DataPropertyRange|FunctionalDataProperty
CLA_PROP_AXIOM SubClassOf|EquivalentClasses|DisjointClasses|DisjointUnion

%x IN_PROP IN_DATA RELATION RELATION_BEG_END DATA DATA_BEG_END VALUE IN_CLASS CLASS_BEG_END 

%%

[^<> ]*<{DAT_PROP_AXIOM}> { BEGIN IN_DATA; }
[^<> ]*<{OBJ_PROP_AXIOM}> { BEGIN IN_PROP; }
[^<> ]*<{CLA_PROP_AXIOM}> { BEGIN IN_CLASS; }

<IN_CLASS>[^<>]*<Class[ \t\n]*IRI=\" {BEGIN CLASS_BEG_END;}
<IN_CLASS><\/{CLA_PROP_AXIOM} {BEGIN INITIAL;}
<IN_CLASS>.|\n {;}

<CLASS_BEG_END>[^">]+/\" {
                  if ( class_subclass == NULL ){
                    class_subclass = strdup(yytext);
                  }
                  else{
                    class_class = strdup(yytext);
                    print_class();
                  } 
                }

<CLASS_BEG_END>\/> { BEGIN IN_CLASS;  }
<CLASS_BEG_END>.|\n {;}

<DATA>[^">]+/\" {data=strdup(yytext);} 
<DATA>\/> {BEGIN IN_DATA;}
<DATA>.|\n {;}

<IN_DATA>[^<>]*<DataProperty[ \t\n]*IRI=\" { BEGIN DATA;}
<IN_DATA>[^<>]*<Class[ \t\n]*IRI=\" { BEGIN DATA_BEG_END;}
<IN_DATA>[^<>]*<Datatype[ \t\n]*abbreviatedIRI=\" {  BEGIN VALUE;}
<IN_DATA><\/{DAT_PROP_AXIOM} {BEGIN INITIAL;}
<IN_DATA>.|\n {;}

<VALUE>[^"<>]+/\" { value = strdup(yytext); print_data(); }
<VALUE>\/> {BEGIN IN_DATA;}
<VALUE>.|\n {;}

<DATA_BEG_END>[^">]+/\" { class = strdup(yytext); }
<DATA_BEG_END>\/> {BEGIN IN_DATA;}
<DATA_BEG_END>.|\n {;}

<IN_PROP>[^<>]*<ObjectProperty[ \t\n]*IRI=\" { BEGIN RELATION;  }
<IN_PROP>[^<>]*<Class[ \t\n]*IRI=\" {  BEGIN RELATION_BEG_END;}
<IN_PROP><\/{OBJ_PROP_AXIOM} { BEGIN INITIAL;}
<IN_PROP>.|\n {;}

<RELATION>[^"<>]+/\" { relation=strdup(yytext);} 
<RELATION>\/> { BEGIN IN_PROP;}
<RELATION>.|\n {;}

<RELATION_BEG_END>[^"<>]+/\" {
                              if ( begin == NULL ){
                                begin = strdup(yytext);
                              }
                              else{
                                end = strdup(yytext);
                                print_prop();
                              } 
                            }

<RELATION_BEG_END>\/> { BEGIN IN_PROP;}
<RELATION_BEG_END>.|\n { ;}

<INITIAL>.|\n {;}

%%

void print_class(){
  printf("\"%s\" [shape = box, style=rounded, fontsize=12 fontname=helvetica];\n", class_subclass);
  printf("\"%s\" [shape = box, style=rounded, fontsize=12 fontname=helvetica];\n", class_class);
  printf("\"%s\" -> \"%s\" [ label = \"SubClassOf\" , fontsize=8 , fontcolor=\"blue\", color=\"blue\" ]\n", class_subclass, class_class );
  class_subclass=NULL;
  class_class=NULL;
}

void print_data(){
  printf("\"%s\" [shape = box, style=rounded, fontsize=12 fontname=helvetica];\n", class);
  printf("\"%s\" [shape = box, style=filled,color=\"red\", fontsize=12 fontname=helvetica];\n", value);
  printf("\"%s\" -> \"%s\" [ label = \"%s\" ]\n", class, value, data );
  class=NULL;
  value=NULL;
  data=NULL;
}

void print_prop(){
  printf("\"%s\" [shape = box, style=rounded, fontsize=12 fontname=helvetica];\n", begin);
  printf("\"%s\" -> \"%s\" [ label = \"%s\" ]\n", begin, end, relation );
  begin=NULL;
  relation=NULL;
  end=NULL;
}

void graph_print(){
  printf( "digraph pl_2_1 {\n//title\nlabelloc=\"t\";\nlabel=\"OWL concept diagram\";rankdir=TB;\nresolution=300;size=\"8,5\";\n");
} 

int yywrap(){return 1;}

int main(int argc, char** argv){
  graph_print();
  yylex();
  printf("}\n");
  return (0);
}

