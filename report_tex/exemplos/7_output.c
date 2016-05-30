// declaracoes iniciais
int a;
int b;
int c;
int maior;

// leitura do standard input 
// e atribuicao do valor lido a variaveis
print "a: "; // escrita no standard output de uma string
a = read();
print "b: "; // escrita no standard output de uma string
b = read();
print "c: "; // escrita no standard output de uma string
c = read();

print "maior: "; // escrita no standard output de uma string
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

// escrita no standard output de uma variavel do tipo inteiro atomica
print maior;
