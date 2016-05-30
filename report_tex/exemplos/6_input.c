// declaracoes iniciais
int a;
int b;
int c;
int maior;

// leitura do standard input 
// e atribuicao do valor lido a variaveis
a = read();
b = read();
c = read();

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
  }
}
