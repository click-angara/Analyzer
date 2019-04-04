%token MUL PLUSMINUS COMP EQ ASSIGN SHIFT INC AND OR 
%token NUM VAL
%token IF ELSE WHILE PRINT RETURN

%start start
%%


statement
    : '{' '}'
    | '{' statement_list '}'
    | expression ';'
    | IF '(' expression ')' statement
    | IF '(' expression ')' statement ELSE statement
    | IF '('  ')' statement
    | IF '(' ')' statement ELSE statement
    | WHILE '(' expression ')' statement
    | WHILE '(' ')' statement
    | PRINT expression
    | ';'
    ;

unary_operator
    : PLUSMINUS
    | '!'
    ;

start 
    : statement_list RETURN ';'
    | statement_list RETURN '(' expression ')' ';'
    ;
    
statement_list
    : statement 
    | statement_list statement
    ;

expression
    : expression_1
    | expression ',' expression_1
    ;

expression_1
    : smth_1 ASSIGN expression_1
    | smth_3
    ;

smth_1
    : INC smth_1
    | unary_operator smth_10
    | smth_11
    ;

smth_3
    : smth_4
    | smth_3 OR smth_4
    ;

smth_4
    : smth_5
    | smth_4 AND smth_5
    ;

smth_5
    : smth_6
    | smth_5 EQ smth_6
    ;

smth_6
    : smth_7
    | smth_6 COMP smth_7

smth_7
    : smth_8
    | smth_7 SHIFT smth_8
    ;

smth_8
    : smth_9
    | smth_8 PLUSMINUS smth_9
    ;

smth_9 
    : smth_10
    | smth_9 MUL smth_10
    ;

smth_10
    : smth_11
    | smth_10 INC 
    | INC smth_10
    ;

smth_11
    : NUM
    | VAL
    | '(' expression ')'
    | smth_11 '(' ')'
    | smth_11 '(' smth_12 ')'
    | ';'
    ;

smth_12
    : expression_1
    | smth_12 ',' expression_1
    ;

%%
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern char yytext[];
extern int column;
extern int num_string;



void main( int argc,char *argv[] ) {
	/*	check for correct input	*/
	if (argc != 2){
		printf("invalid number of arguments\n");
		exit(0);
	}

	/*	check the file name	*/
	int end_elem = strlen(argv[1]) - 1;
	if (argv[1][end_elem] != 'z' || argv[1][end_elem - 1] != '.' ){
		printf("Invalid file name\n");
		exit(0);
	}

	freopen(argv[1], "r", stdin); 
	yyparse();
 }

yyerror(s) char *s;
{
    fflush(stdout);
    printf("\n%*s\n", column, "^");
    printf( "string -> %i\n",num_string);
}
