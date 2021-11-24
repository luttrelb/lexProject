%{
#include <stdio.h>
#include "zoomjoystrong.h"
void yyerror(const char* msg);
extern int yylineno;
extern int yylex();
%}

%union {
	int iVal;
	double fVal;
}
%start program

%token END
%token END_STATEMENT
%token POINT
%token LINE
%token CIRCLE
%token RECTANGLE
%token SET_COLOR
%token INT
%type<iVal> INT
%token FLOAT
%type<fVal> FLOAT

%%
program:		statement_list END END_STATEMENT
	;
statement_list:	statement
		|	statement statement_list
		;
statement:	POINT INT INT END_STATEMENT {point($2, $3);}
	|	LINE INT INT INT INT END_STATEMENT {line($2, $3, $4, $5);}
	|	CIRCLE INT INT INT END_STATEMENT {circle($2, $3, $4);}
	|	RECTANGLE INT INT INT INT END_STATEMENT {rectangle($2, $3, $4, $5);}
	|	SET_COLOR INT INT INT END_STATEMENT {set_color($2, $3, $4);}
	;
%%	

void yyerror(const char* msg){
	fprintf(stderr, "Error on line %d.\n%s\n", yylineno, msg);
}

int main (int argc, char** argv){
	setup();
	yyparse();
	finish();
	return 0;
}
