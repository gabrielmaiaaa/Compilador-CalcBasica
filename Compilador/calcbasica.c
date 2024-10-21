#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_TOKEN_LENGTH 1024

void SintaxeErro(const char *token) {
    fprintf(stderr, "ERRO em %s\n", token);
    exit(1);
}

char *proxtoken(FILE *arquivo) {
    char linha[MAX_TOKEN_LENGTH];
    if (fgets(linha, sizeof(linha), arquivo) != NULL) {
        linha[strcspn(linha, "\n")] = '\0';
        char *linha_dinamica = malloc(strlen(linha) + 1);
        if (!linha_dinamica) {
            perror("Falha na alocação de memória");
            exit(1);
        }
        strcpy(linha_dinamica, linha);
        return linha_dinamica;
    } else {
        printf("FINAL DE ARQUIVO\n");
        return NULL;
    }
}

int verifica_token(const char *token, const char *valor) {
    return strcmp(token, valor) == 0;
}

void COMENTARIO(char *token, FILE *arquivo) {
    if (verifica_token(token, "COMENTARIO")) {
        free(token);
        token = proxtoken(arquivo);
    }
}

void DECLARACOES_LINHA(char *token, FILE *arquivo);
int DECLARACOES(char *token, FILE *arquivo);
int LER(char *token, FILE *arquivo);
void EXPR_COND(char *token, FILE *arquivo);
void ALGORITMO(char *token, FILE *arquivo);
int ASD_ALGOX(char *token, FILE *arquivo);

int EXPR(char *token, FILE *arquivo) {
    if (verifica_token(token, "VARIAVEL")) {
        free(token);
        token = proxtoken(arquivo);
        if (verifica_token(token, "ADICAO") || verifica_token(token, "SUBTRACAO") ||
            verifica_token(token, "PRODUTO") || verifica_token(token, "DIVISAO")) {
            free(token);
            token = proxtoken(arquivo);
            if (verifica_token(token, "VARIAVEL") || verifica_token(token, "CONSTANTE_INTEIRA") || 
                verifica_token(token, "CONSTANTE_REAL")) {
                return 1;
            } else {
                SintaxeErro(token);
            }
        }
        return 1;
    }
    return verifica_token(token, "CONSTANTE_INTEIRA") || verifica_token(token, "CONSTANTE_REAL");
}

void DECLARACOES_LINHA(char *token, FILE *arquivo) {
    if (verifica_token(token, "VIRGULA")) {
        free(token);
        token = proxtoken(arquivo);
        if (verifica_token(token, "VARIAVEL")) {
            free(token);
            token = proxtoken(arquivo);
            DECLARACOES_LINHA(token, arquivo);
        }
    }
}

int DECLARACOES(char *token, FILE *arquivo) {
    if (verifica_token(token, "INTEIRO") || verifica_token(token, "REAL") ||
        verifica_token(token, "LISTA_INT") || verifica_token(token, "LISTA_REAL")) {
        free(token);
        token = proxtoken(arquivo);
        if (verifica_token(token, "VARIAVEL")) {
            free(token);
            token = proxtoken(arquivo);
            DECLARACOES_LINHA(token, arquivo);
            DECLARACOES(token, arquivo);
        }
    }
    return 1;
}

int LER(char *token, FILE *arquivo) {
    if (verifica_token(token, "VIRGULA")) {
        free(token);
        token = proxtoken(arquivo);
        if (verifica_token(token, "VARIAVEL")) {
            free(token);
            token = proxtoken(arquivo);
            LER(token, arquivo);
        }
    }
    return 1;
}

void EXPR_COND(char *token, FILE *arquivo) {
    if (EXPR(token, arquivo)) {
        free(token);
        token = proxtoken(arquivo);
        if (verifica_token(token, "MAIOR") || verifica_token(token, "IGUAL")) {
            free(token);
            token = proxtoken(arquivo);
            if (EXPR(token, arquivo)) {
                return;
            }
        }
    }
}

void ALGORITMO(char *token, FILE *arquivo) {
    while (token != NULL) {
        if (verifica_token(token, "LEIA")) {
            free(token);
            token = proxtoken(arquivo);
            if (verifica_token(token, "VARIAVEL")) {
                free(token);
                token = proxtoken(arquivo);
                LER(token, arquivo);
            } else {
                SintaxeErro(token);
            }
        } else if (verifica_token(token, "ESCREVA")) {
            free(token);
            token = proxtoken(arquivo);
            // Adicione a lógica para escrever a saída aqui
        } else if (verifica_token(token, "FIM")) {
            printf("Valido\n");
            break; // Encerra a análise
        } else {
            SintaxeErro(token);
        }
    }
}


int ASD_ALGOX(char *token, FILE *arquivo) {
    if (verifica_token(token, "PROGRAMA")) {
        free(token);
        token = proxtoken(arquivo);
        if (verifica_token(token, "VARIAVEL")) {
            free(token);
            token = proxtoken(arquivo);
            if (verifica_token(token, "INICIO")) {
                free(token);
                token = proxtoken(arquivo);
                COMENTARIO(token, arquivo);
                free(token);
                token = proxtoken(arquivo);
                DECLARACOES(token, arquivo);
                free(token);
                token = proxtoken(arquivo);
                COMENTARIO(token, arquivo);
                free(token);
                token = proxtoken(arquivo);
                ALGORITMO(token, arquivo);
            }
        }
    } else {
        SintaxeErro(token);
    }
    return 0;
}

// int main() {
//     FILE *arquivo = fopen("calcbasica.out", "r");
//     if (arquivo == NULL) {
//         perror("Erro ao abrir o arquivo");
//         return 1;
//     }

//     char *token = proxtoken(arquivo);
//     ASD_ALGOX(token, arquivo);

//     free(token);
//     fclose(arquivo);
//     return 0;
// }
