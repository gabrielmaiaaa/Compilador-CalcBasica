%option noyywrap

/* Gabriel Maia Alves Araújo - 2022005689 */

%{
#include <stdio.h>
%}

/* Definição de Tokens */
NUMERO                    [0-9]
CONSTANTE_INTEIRA         {NUMERO}+
CONSTANTE_REAL            {NUMERO}+(\.{NUMERO}+) 
ALFABETO                  [a-zA-Z]
VARIAVEL                  {ALFABETO}({ALFABETO}|{NUMERO}|_)* 
CADEIA                    \'[^\']+\' 
COMENTARIOS               \{[^}]*\} 
POSSIVEIS_ERROS           [ \n\t]+

/* Gramática */
%%

"PROGRAMA"                 { printf("PROGRAMA\n"); }
"SE"                       { printf("SE\n"); }
"ENQUANTO"                 { printf("ENQUANTO\n"); }
"ENTAO"                    { printf("ENTAO\n"); }
"ESCREVA"                  { printf("ESCREVA\n"); }
"FIM_SE"                   { printf("FIM_SE\n"); }
"FIM_ENQUANTO"             { printf("FIM_ENQUANTO\n"); }
"FIM"                      { printf("FIM\n"); }
"INICIO"                   { printf("INICIO\n"); }
"LEIA"                     { printf("LEIA\n"); }
"+"                        { printf("ADICAO\n"); }
":="                       { printf("ATRIBUICAO\n"); }
"/"                        { printf("DIVISAO\n"); }
"*"                        { printf("PRODUTO\n"); }
"-"                        { printf("SUBTRACAO\n"); }
".I."                      { printf("IGUAL\n"); }
".M."                      { printf("MAIOR\n"); }
"CARACTER"                 { printf("TIPO_CARACTER\n"); }
"INTEIRO"                  { printf("TIPO_INTEIRO\n"); }
"LISTA_INT"                { printf("TIPO_LISTA_INT\n"); }
"LISTA_REAL"               { printf("TIPO_LISTA_REAL\n"); }
"REAL"                     { printf("TIPO_REAL\n"); }
"("                        { printf("ABRE_PARENTESE\n"); }
")"                        { printf("FECHA_PARENTESE\n"); }
"["                        { printf("ABRE_COLCHETE\n"); }
"]"                        { printf("FECHA_COLCHETE\n"); }
","                        { printf("VIRGULA\n"); }
{CONSTANTE_INTEIRA}        { printf("CONSTANTE_INTEIRA\n"); }
{CONSTANTE_REAL}           { printf("CONSTANTE_REAL\n"); }
{VARIAVEL}                 { printf("VARIAVEL\n"); }
{CADEIA}                   { printf("CADEIA\n"); }
{COMENTARIOS}              { printf("COMENTARIO\n"); }
.                          { /* Caractere desconhecido */ }
{POSSIVEIS_ERROS}          { /* Ignora espaços em branco */ }

%%

/*
int main(int argc, char *argv[]) {
    yylex();
    return 0;
}
*/