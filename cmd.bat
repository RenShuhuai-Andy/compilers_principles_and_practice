REM flex lex.l
REM bison -d parser.y
REM gcc -o parser ast.c parser.tab.c lex.yy.c
parser.exe test.c > result.txt