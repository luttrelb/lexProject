%{
#include <stdio.h>
#include "zoomjoystrong.tab.h"
%}
%option yylineno
%%
[ \t\n\r]+   ;
end {return END;}
; {return END_STATEMENT;}
[0-9]+ {yylval.iVal = atoi(yytext); return INT;}
[0-9]+\.[0-9]+ {yylval.fVal = atof(yytext); return FLOAT;}
point {return POINT;}
line {return LINE;}
circle {return CIRCLE;}
rectangle {return RECTANGLE;}
set_color {return SET_COLOR;}
%%

