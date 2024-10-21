/* Gabriel Maia Alves Araújo - 2022005689 */

%{
#include <stdio.h>
#include <stdlib.h

int yywrap(void) { return 1; }
void yyerror(const char *s)
%}

/* Definicção dos Tokens */
PROGRAMA                 "PROGRAMA"
SE                       "SE"
ENQUANTO                 "ENQUANTO"
ENTAO                    "ENTAO"
ESCREVA                  "ESCREVA"
FIM_SE                   "FIM_SE"
FIM_ENQUANTO             "FIM_ENQUANTO"
FIM                      "FIM"
INICIO                   "INICIO"
LEIA                     "LEIA"
ADICAO                   "+"
ATRIBUICAO               ":="
DIVISAO                  "\"
PRODUTO                  "*"
SUBTRACAO                "-"
IGUAL                    ".I."
MAIOR                    ".M."
TIPO_CADEIA              "CADEIA"
TIPO_CARACTER            "CARACTER"
TIPO_INTEIRO             "INTEIRO"
TIPO_LISTA_INT           "LISTA_INT"
TIPO_LISTA_REAL          "LISTA_REAL"
TIPO_REAL                "REAL"
ABRE_PARENTESE           "("
FECHA_PARENTESE          ")"
VIRGULA                  ","
DIGITO                   ([0-9])
CONSTANTE_INTEIRA        ({DIGITO}+)
CONSTANTE_REAL           ({DIGITO}+(","{DIGITO}+)?)
LETRA                    ([a-zA-Z])
PALAVRA                  ([a-zA-Z_-])
VARIAVEL                 ({LETRA}({PALAVRA}|{CONSTANTE_INTEIRA})*)
VARIAVEL_LISTA           ({VARIAVEL}"["({VARIAVEL}|{CONSTANTE_INTEIRA})"]")
CADEIA                   (\'[^'\r\n]+\')
COMENTARIO               (\{.*\})
WHITESPACES              ([ \t\n\r]+)

%%
/* Gramática */
{PROGRAMA}                 { printf("TOKEN: PROGRAMA\n"); }
{SE}                       { printf("TOKEN: SE\n"); }
{ENQUANTO}                 { printf("TOKEN: ENQUANTO\n"); }
{ENTAO}                    { printf("TOKEN: ENTAO\n"); }
{ESCREVA}                  { printf("TOKEN: ESCREVA\n"); }
{FIM_SE}                   { printf("TOKEN: FIM_SE\n"); }
{FIM_ENQUANTO}             { printf("TOKEN: FIM_ENQUANTO\n"); }
{FIM}                      { printf("TOKEN: FIM\n"); }
{INICIO}                   { printf("TOKEN: INICIO\n"); }
{LEIA}                     { printf("TOKEN: LEIA\n"); }
{ADICAO}                   { printf("TOKEN: ADICAO\n"); }
{ATRIBUICAO}               { printf("TOKEN: ATRIBUICAO\n"); }
{DIVISAO}                  { printf("TOKEN: DIVISAO\n"); }
{PRODUTO}                  { printf("TOKEN: PRODUTO\n"); }
{SUBTRACAO}                { printf("TOKEN: SUBTRACAO\n"); }
{IGUAL}                    { printf("TOKEN: IGUAL\n"); }
{MAIOR}                    { printf("TOKEN: MAIOR\n"); }
{TIPO_CADEIA}              { printf("TOKEN: TIPO_CADEIA\n"); }
{TIPO_CARACTER}            { printf("TOKEN: TIPO_CARACTER\n"); }
{TIPO_INTEIRO}             { printf("TOKEN: TIPO_INTEIRO\n"); }
{TIPO_LISTA_INT}           { printf("TOKEN: TIPO_LISTA_INT\n"); }
{TIPO_LISTA_REAL}          { printf("TOKEN: TIPO_LISTA_REAL\n"); }
{TIPO_REAL}                { printf("TOKEN: TIPO_REAL\n"); }
{ABRE_PARENTESE}           { printf("TOKEN: ABRE_PARENTESE\n"); }
{FECHA_PARENTESE}          { printf("TOKEN: FECHA_PARENTESE\n"); }
{VIRGULA}                  { printf("TOKEN: VIRGULA\n"); }
{DIGITO}                   { printf("TOKEN: DIGITO\n"); }
{CONSTANTE_INTEIRA}        { printf("TOKEN: CONSTANTE_INTEIRA\n"); }
{CONSTANTE_REAL}           { printf("TOKEN: CONSTANTE_REAL\n"); }
{LETRA}                    { printf("TOKEN: LETRA\n"); }
{PALAVRA}                  { printf("TOKEN: DIGITO\n"); }
{VARIAVEL}                 { printf("TOKEN: VARIAVEL\n"); }
{VARIAVEL_LISTA}           { printf("TOKEN: VARIAVEL_LISTA\n"); }
{CADEIA}                   { printf("TOKEN: CADEIA\n"); }
{COMENTARIO}               // Pula os trechos comentados
{WHITESPACES}              // Ignora espacos em branco, tabulações e quebras de linha

%%

int main(int argc, char *argv[]) {
    yylex();
    return 0;
}

void yyerror(const char *s) { 
    fprintf(stderr, "Error: %s\n", s); 
}