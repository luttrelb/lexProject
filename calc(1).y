%{
#include <stdio.h>
#include <math.h>
double total = 0;
double memory = 0;
void yyerror(const char* msg);
extern int yylineno;
extern int yylex();
%}

%union {
    double fVal;
}

%token NUMBER
%token ADDOP
%token SUBOP
%token MULOP
%token DIVOP
%token MODOP
%token POWOP
%token CLROP
%token EQLOP
%token MEMOP
%token RETOP
%type<fVal> NUMBER
%start program

%%

program:            statement_list
       ;
statement_list:     statement
              |     statement statement_list
              ;
statement:          CLROP                       { total = 0; }
         |          EQLOP                       { printf("%f\n", total); }
         |          MEMOP                       { memory = total; }
         |          ADDOP NUMBER                { total += $2; }
         |          SUBOP NUMBER                { total -= $2; }
         |          MULOP NUMBER                { total *= $2; }
         |          DIVOP NUMBER                { total /= $2; }
         |          POWOP NUMBER                { total = pow(total, $2); }
         |          MODOP NUMBER                { total = total * $2 / 100.0; }
         |          ADDOP RETOP                 { total += memory; }
         |          SUBOP RETOP                 { total -= memory; }
         |          MULOP RETOP                 { total *= memory; }
         |          DIVOP RETOP                 { total /= memory; }
         |          POWOP RETOP                 { total = pow(total, memory); }
         |          MODOP RETOP                 { total = total * memory / 100.0; }
         ;

%%

void yyerror(const char* msg) {
    fprintf(stderr, "Error on line %d.\n%s\n", yylineno, msg);
}

int main(int argc, char** argv) {
    yyparse();
}
