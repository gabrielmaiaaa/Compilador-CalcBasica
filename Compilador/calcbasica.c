// Gabriel Maia Alves Araújo - 2022005689 

#include <stdio.h>  
#include <stdlib.h> 
#include <string.h> 

void SintaxeErro(const char *token) {
    printf("Ocorreu erro na seguinte linha: %s\n", token);
    exit(1);
}

// Função que verifica se o token é válido e retorna o token
char *proxtoken(FILE *arquivo) {
    static char linha[1024];
    if (fgets(linha, sizeof(linha), arquivo) != NULL) {
        linha[strcspn(linha, "\n")] = '\0';
        printf("%s\n", linha);
        return linha;
    } else {
        printf("Erro: arquivo vazio ou leitura falhou\n");
        return NULL;
    }
}

// Função criada para reduzir linhas de código
int compara_token(const char *token, const char *comparacao) {
    return strcmp(token, comparacao) == 0;
}

// Todas as linhas descritas em funções	separadas
int VARIAVEL(char *token) { return compara_token(token, "VARIAVEL"); }
int VIRGULA(char *token) { return compara_token(token, "VIRGULA"); }
int INICIO(char *token) { return compara_token(token, "INICIO"); }
int LEIA(char *token) { return compara_token(token, "LEIA"); }
int ESCREVA(char *token) { return compara_token(token, "ESCREVA"); }
int CADEIA(char *token) { return compara_token(token, "CADEIA"); }
int ATRIBUICAO(char *token) { return compara_token(token, "ATRIBUICAO"); }
int COMPARACAO(char *token) { return compara_token(token, "MAIOR") || compara_token(token, "IGUAL"); }
void COMENTARIO(char *token, FILE *arquivo) {
    if (compara_token(token, "COMENTARIO")) {
        token = proxtoken(arquivo);
        COMENTARIO(token, arquivo);
    }
    proxtoken(arquivo);
}
int TIPO(char *token) {
    return compara_token(token, "TIPO_INTEIRO") || 
           compara_token(token, "TIPO_REAL") || 
           compara_token(token, "TIPO_CARACTER") || 
           compara_token(token, "TIPO_LISTA_INT") || 
           compara_token(token, "TIPO_LISTA_REAL");
}
int CONSTANTE_INTEIRA(char *token) { return compara_token(token, "CONSTANTE_INTEIRA"); }
int CONSTANTE_REAL(char *token) { return compara_token(token, "CONSTANTE_REAL"); }
int OPERADOR(char *token) {
    return compara_token(token, "ADICAO") || 
           compara_token(token, "SUBTRACAO") || 
           compara_token(token, "PRODUTO") || 
           compara_token(token, "DIVISAO");
}
int SE(char *token) { return compara_token(token, "SE"); }
int ENQUANTO(char *token) { return compara_token(token, "ENQUANTO"); }
int ENTAO(char *token) { return compara_token(token, "ENTAO"); }
int FIM_ENQUANTO(char *token) { return compara_token(token, "FIM_ENQUANTO"); }
int FIM_SE(char *token) { return compara_token(token, "FIM_SE"); }
int FIM(char *token) { return compara_token(token, "FIM"); }
int ABRE_PARENTESE(char *token) { return compara_token(token, "ABRE_PARENTESE"); }
int FECHA_PARENTESE(char *token) { return compara_token(token, "FECHA_PARENTESE"); }
int ABRE_COLCHETE(char *token) { return compara_token(token, "ABRE_COLCHETE"); }
int FECHA_COLCHETE(char *token) { return compara_token(token, "FECHA_COLCHETE"); }

int PROCESSAR(char *token, FILE *arquivo) {
    if (VARIAVEL(token) || CONSTANTE_INTEIRA(token) || CONSTANTE_REAL(token)) {
        token = proxtoken(arquivo);
        if (OPERADOR(token)) {
            token = proxtoken(arquivo);
            if (VARIAVEL(token) || CONSTANTE_INTEIRA(token) || CONSTANTE_REAL(token)) {
                return 1; 
            } else {
                SintaxeErro(token);
            }
        }
        return 1;
    }
    return 0; 
}

int DECLARACOES(char *token, FILE *arquivo) {
    while (TIPO(token)) {
        token = proxtoken(arquivo);
        if (!VARIAVEL(token)) {
            SintaxeErro(token);
        }
        token = proxtoken(arquivo);
    }
    return 1;
}

int VERIFICAR(char *token, FILE *arquivo) {
    while (VIRGULA(token)) {
        token = proxtoken(arquivo);
        if (!VARIAVEL(token)) {
            SintaxeErro(token);
        }
        token = proxtoken(arquivo);
    }
    return 1;
}

void CONDICIONAL(char *token, FILE *arquivo) {
    if (PROCESSAR(token, arquivo)) {
        token = proxtoken(arquivo);
        if (COMPARACAO(token)) {
            token = proxtoken(arquivo);
            if (!PROCESSAR(token, arquivo)) {
                SintaxeErro(token);
            }
        }
    }
}

void EXECUTAR_PROGRAMA(char *token, FILE *arquivo) {
    while (1) {
        if (LEIA(token)) {
            token = proxtoken(arquivo);
            if (!VARIAVEL(token)) {
                SintaxeErro(token);
                return; 
            }
            VERIFICAR(token, arquivo);

        } else if (ESCREVA(token)) {
            token = proxtoken(arquivo);
            if (CADEIA(token)) {
                token = proxtoken(arquivo);
                if (VIRGULA(token)) {
                    token = proxtoken(arquivo);
                    if (!VARIAVEL(token)) {
                        SintaxeErro(token);
                        return; 
                    }
                }
            } else if (VARIAVEL(token)) {
                token = proxtoken(arquivo);
                if (VIRGULA(token)) {
                    token = proxtoken(arquivo);
                    if (!VARIAVEL(token)) {
                        SintaxeErro(token);
                        return; 
                    }
                }
            }

        } else if (SE(token)) {
            token = proxtoken(arquivo);
            CONDICIONAL(token, arquivo);

            token = proxtoken(arquivo);
            if (ENTAO(token)) {
                token = proxtoken(arquivo);
                EXECUTAR_PROGRAMA(token, arquivo); 
            }

            if (FIM_SE(token)) {
                token = proxtoken(arquivo);
                continue; 
            }

        } else if (ENQUANTO(token)) {
            token = proxtoken(arquivo);
            CONDICIONAL(token, arquivo); 

            token = proxtoken(arquivo);
            if (ENTAO(token)) {
                do {
                    EXECUTAR_PROGRAMA(token, arquivo);
                    token = proxtoken(arquivo); 
                } while (PROCESSAR(token, arquivo)); 
            }

            if (FIM_ENQUANTO(token)) {
                token = proxtoken(arquivo);
                continue; 
            }

        } else if (FIM(token)) {
            printf("Compilacao finalizada com sucesso\n");
            return; 
        }

        token = proxtoken(arquivo); 
    }
}


int main() {
    FILE *arquivo = fopen("fatorial.out", "r"); // só trocar fatorial.out para operacao.out
    if (!arquivo) {
        printf("Erro ao abrir o arquivo\n");
        return 1;
    }

    char *token = proxtoken(arquivo);

    if (compara_token(token, "PROGRAMA")) {
        while (1) {
            token = proxtoken(arquivo);
            if (VARIAVEL(token)) {
                continue;
            } else if (INICIO(token)) {
                break;
            } else {
                SintaxeErro(token);
            }
        }
        DECLARACOES(token, arquivo);
        EXECUTAR_PROGRAMA(token, arquivo);
    } else {
        SintaxeErro(token);
    }

    fclose(arquivo);
    return 0;
}
