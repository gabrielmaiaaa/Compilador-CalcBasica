# Compilador-CalcBasica
Desenvolvimento de um compilador para uma liguágem hipotética CalcBasica

flex calcbasica.lex
gcc lex.yy.c calcbasica.c -o calcbasica.out
calcbasica.out < exemplos/fatorial.txt 