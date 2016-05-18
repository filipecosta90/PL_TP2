

LETTER [a-zA-Z]
DIGIT [0-9]

%%

[,]                               { return (yytext[0]); }
(?i:BEGIN)                        { return (BEGIN); }
(?i:END)                          { return (END); }
{DIGIT}+                       { yylval.valor = atoi(yytext); return (pal); }
{LETTER}+                        { yylval.nome = strdup(yytext); return (num);} 
.|\n                              { ; }

%%

int yywrap(){
  return 1;
}
