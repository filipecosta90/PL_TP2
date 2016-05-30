// declaracoes inciais
int a;
int b;
int c;
int maior;

// operacoes de atribuicao
a = 15;
b = 7 * 4;
c = 120 % 1;

// instrucoes condicionais
if ( a >= b && a >= c ) then {
  maior = a;
}
else {
  if ( b > a && b >= c  ) then {
    maior = b;
  }
  else {
    // esta condicao era desnecessaria 
    // mas desta forma provamos o correcto aninhamento de condicionais
    if (c > a && c > b ) then {
      maior = c;
    }
    // este condicional nao tem o fluxo else
  }
}
