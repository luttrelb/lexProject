%{
#include "calc.tab.h"
#include <stdlib.h>
%}

%%

C                       { return CLROP; }
M                       { return MEMOP; }
R                       { return RETOP; }
=                       { return EQLOP; }
\+                      { return ADDOP; }
-                       { return SUBOP; }
\*                      { return MULOP; }
\/                      { return DIVOP; }
\^                      { return POWOP; }
%                       { return MODOP; }
[0-9]{1,5}              { yylval.fVal = atof(yytext); return NUMBER; }
[0-9]{1,5}\.[0-9]{1,5}  { yylval.fVal = atof(yytext); return NUMBER; }
[ \t\n\r]               ;

%%


