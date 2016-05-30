%{

%}

letter    [a-zA-Z]
digit     [0-9]
ignore    [\ \t\r\n]

%option yylineno

%%

[\%\,\{\}\+\-\(\)\=\>\<\!\;\/\*\[\]\|\&\_]     { return(yytext[0]); }
int                                            { return (TYPE_INT); }

{letter}({letter}|{digit}|\_)*                 { yylval.var = strdup(yytext); return(id); }
{digit}+                                       { yylval.qt = atoi(yytext); return(num); }
\/\/[^\n]*                                     { printf("%s\n",yytext);  }
{ignore}                                       { ; }

%%

int yywrap(){
  return(1);
}
