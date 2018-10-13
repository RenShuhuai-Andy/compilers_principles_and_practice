flex lex.l
bison -d parser.y
gcc -o parser ast.c parser.tab.c lex.yy.c
parser.exe test.c > result.txt