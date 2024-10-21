%{
#include <stdio.h>
#include <stdlib.h>

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
OPERADOR_ADICAO          "+"
OPERADOR_ATRIBUICAO      ":="
OPERADOR_DIVISAO         "\\"
OPERADOR_PRODUTO         "*"
OPERADOR_SUBTRACAO       "-"
OPERADOR_IGUAL           ".I."
OPERADOR_MAIOR           ".M."
TIPO_CADEIA              "CADEIA"
TIPO_CARACTER            "CARACTER"
TIPO_INTEIRO             "INTEIRO"
TIPO_LISTA_INT           "LISTA_INT"
TIPO_LISTA_REAL          "LISTA_REAL"
TIPO_REAL                "REAL"
ABRE                     "("
FECHA                    ")"
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
{OPERADOR_ADICAO}          { printf("TOKEN: OPERADOR_ADICAO\n"); }
{OPERADOR_ATRIBUICAO}      { printf("TOKEN: OPERADOR_ATRIBUICAO\n"); }
{OPERADOR_DIVISAO}         { printf("TOKEN: OPERADOR_DIVISAO\n"); }
{OPERADOR_PRODUTO}         { printf("TOKEN: OPERADOR_PRODUTO\n"); }
{OPERADOR_SUBTRACAO}       { printf("TOKEN: OPERADOR_SUBTRACAO\n"); }
{OPERADOR_IGUAL}           { printf("TOKEN: OPERADOR_IGUAL\n"); }
{OPERADOR_MAIOR}           { printf("TOKEN: OPERADOR_MAIOR\n"); }
{TIPO_CADEIA}              { printf("TOKEN: TIPO_CADEIA\n"); }
{TIPO_CARACTER}            { printf("TOKEN: TIPO_CARACTER\n"); }
{TIPO_INTEIRO}             { printf("TOKEN: TIPO_INTEIRO\n"); }
{TIPO_LISTA_INT}           { printf("TOKEN: TIPO_LISTA_INT\n"); }
{TIPO_LISTA_REAL}          { printf("TOKEN: TIPO_LISTA_REAL\n"); }
{TIPO_REAL}                { printf("TOKEN: TIPO_REAL\n"); }
{ABRE}                     { printf("TOKEN: ABRE\n"); }
{FECHA}                    { printf("TOKEN: FECHA\n"); }
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