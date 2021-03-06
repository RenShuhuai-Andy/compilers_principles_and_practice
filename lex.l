%{
#include "parser.tab.h"
#include "string.h"
#include "def.h"
#include "stdio.h"
int yycolumn=1;
#define YY_USER_ACTION yylloc.first_line=yylloc.last_line=yylineno; yylloc.last_column=yycolumn+yyleng-1; yycolumn+=yyleng;
typedef union{
    int type_int;
    int type_float;
    int type_double;
    int type_char;
    char type_id[32];
    struct node *pr;
}YYLVAL;
#define YYSTYPE YYLVAL

%}
%option yylineno

id [A-Za-z][A-Za-z0-9]*
int [0-9]+
float ([0-9]*\.[0-9]+)|([0-9]+\.)
double ([0-9]*\.[0-9]+)|([0-9]+\.)
char '.'|[0-9]+

%%
{int}       {yylval.type_int=atoi(yytext);return INT;}
{float}     {yylval.type_float=atof(yytext);return FLOAT;}
{double}    {yylval.type_double=atof(yytext);return DOUBLE;}//{yylval.type_double=atod(yytext);return DOUBLE;}//有atod函数吗？
{char}      {yylval.type_char=yytext[1];return CHAR;}//有问题
"int"       {strcpy(yylval.type_id, yytext);return TYPE;}
"float"     {strcpy(yylval.type_id, yytext);return TYPE;}
"double"    {strcpy(yylval.type_id, yytext);return TYPE;}
"char"      {strcpy(yylval.type_id, yytext);return TYPE;}
"struct"    {strcpy(yylval.type_id, yytext);return STRUCT;}

"return"    {return RETURN;}
"if"        {return IF;}
"else"      {return ELSE;}
"while"     {return WHILE;}

{id}        {strcpy(yylval.type_id, yytext);return ID;}//由于关键词的形式也符合标识符的规则，所以把关键字的处理全部放在标识符的前面
";"         {return SEMI;}
","         {return COMMA;}
">"|"<"|">="|"<="|"=="|"!=" {strcpy(yylval.type_id, yytext);return RELOP;}
"="         {return ASSIGNOP;}
"++"        {return INC;}
"+="        {return COMP_PLUS;}
"+"         {return PLUS;}
"--"        {return DEC;}
"-="        {return COMP_MINUS;}
"-"         {return MINUS;}
"*"         {return STAR;}
"/"         {return DIV;}//为什么这个可以放在"//"前面？？ "//"还可以放在.后面？？？
"&&"        {return AND;}
"||"        {return OR;}
"!"         {return NOT;}
"("         {return LP;}
")"         {return RP;}
"["         {return LB;}
"]"         {return RB;}
"{"         {return LC;}
"}"         {return RC;}
[\n]        {yycolumn=1;}
[ \r\t]     {} 
(\/\/).*    {}//匹配注释//
\/\*.*?(\n)*\*\/ {}//匹配注释/**/ 有问题，贪婪方法无效？？？
.           {printf("Error type A :Mysterious character \"%s\"\n\t at Line %d\n",yytext,yylineno);}
%%

/* 和bison联用时，不需要这部分
void main()
{
yylex();
return 0;
}
*/

int yywrap()
{
return 1;
}

