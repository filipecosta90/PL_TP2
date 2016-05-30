%{

%}

letter    [a-zA-Z]
digit     [0-9]
ignore    [\ \t\r\n]

%option yylineno

%%

[\%\,\{\}\+\-\(\)\=\>\<\!\;\/\*\[\]\|\&\_]     { return(yytext[0]); }
do                                             { return (PL_DO); }
while                                          { return (PL_WHILE); }
if                                             { return (PL_IF); }
then                                           { return (PL_THEN); }
else                                           { return (PL_ELSE); }
int                                            { return (TYPE_INT); }
declare                                        { return (TYPE_FUNCTION); }
print                                          { return (PL_PRINT);}
read                                           { return (PL_READ);}
call                                           { return (PL_CALL);}
return                                         { return (PL_RETURN);}

{letter}({letter}|{digit}|\_)*                 { yylval.var = strdup(yytext); return(id); }
{digit}+                                       { yylval.qt = atoi(yytext); return(num); }
\"[^"]+\"                                      { yylval.var = strdup(yytext); return(string); }
\/\/[^\n]*                                     { printf("%s\n",yytext);  }
{ignore}                                       { ; }

%%

int yywrap(){
  return(1);
}
