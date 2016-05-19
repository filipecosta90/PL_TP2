%{

%}
letter  [a-zA-Z]
digit [0-9]
ignore   .|\n
%%

[\+\-()=;/*\[\]]                { return(yytext[0]); }
int                             { return (TYPE_INT); }
print                           { return (PRINT);}

&&                              { return (LOG_AND); }
\|\|                              { return (LOG_OR); }

{letter}[{letter}{digit}_]*     { yylval.var = strdup(yytext); return(id); }
{digit}+                        { yylval.qt = atoi(yytext); return(num); }
{ignore}                        { ; }

%%
int yywrap(){
return(1);
}
