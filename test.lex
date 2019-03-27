%{
#include <stdio.h>
#include "y.tab.h"
void count();
void num();

extern void yyerror(const char *);  /* prints grammar violation message */

%}

%%

"+="            { count(); return ASSIGN; }
"-="            { count(); return ASSIGN; }
"*="            { count(); return ASSIGN; }
"/="            { count(); return ASSIGN; }
"%="            { count(); return ASSIGN; }

"if"            { count(); return IF; }
"else"          { count(); return ELSE; }
"return"        { count(); return RETURN; }
"while"         { count(); return WHILE; }
"print"         { count(); return PRINT; }

">>"            { count(); return SHIFT; }
"<<"            { count(); return SHIFT; }

"++"            { count(); return INC; }
"--"            { count(); return INC; }

"&&"            { count(); return AND; }
"||"            { count(); return OR; }

"<="            { count(); return COMP; }
">="            { count(); return COMP; }
"<"             { count(); return COMP; }
">"             { count(); return COMP; }

"=="            { count(); return EQ; }
"!="            { count(); return EQ; }

";"             { count(); return ';'; }
","             { count(); return ','; }

"{"             { count(); return '{'; }
"}"             { count(); return '}'; }
"("             { count(); return '('; }
")"             { count(); return ')'; }

"="             { count(); return ASSIGN; }

"!"             { count(); return '!'; }

"-"             { count(); return PLUSMINUS; }
"+"             { count(); return PLUSMINUS; }

"*"             { count(); return MUL; }
"/"             { count(); return MUL; }
"%"             { count(); return MUL; }


[0-9]+          { count(); return NUM; }
[a-zA-Z]+       { count(); return VAL; }

[ \t\v\f]+    	{ count(); /* whitespace separates tokens */ }
[\n]			{ count(); num(); }
%%

int yywrap(void)        /* called at end of input */
{
    return 1;           /* terminate now */
}

int column = 0;
int num_string = 1;

void num(){
	num_string++;
}

void count()
{
    int i;

    for (i = 0; yytext[i] != '\0'; i++)
        if (yytext[i] == '\n')
            column = 0;
        else if (yytext[i] == '\t')
            column += 8 - (column % 8);
        else
            column++;

    ECHO;
}

