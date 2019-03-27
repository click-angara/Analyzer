
all: newdir parser rename clean

rename: a.out
	mv a.out mycomp

newdir:
	mkdir -p workdir

y.tab.c y.tab.h:	test.yacc newdir
	yacc -d test.yacc -o workdir/y.tab.c

lex.yy.c: test.lex y.tab.h
	lex -o workdir/lex.yy.c test.lex 

parser: lex.yy.c y.tab.c y.tab.h
	cc workdir/y.tab.c workdir/lex.yy.c -ll

clean:
	rm -rf workdir

clean_1:
	rm mycomp

rebuild: clean_1 all

