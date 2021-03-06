#!/bin/bash

echo "producing examples"

./algebric < examples_algebra/3_numeros.txt > examples_vm/3_numeros.vm
./algebric < examples_algebra/somatorio.txt > examples_vm/somatorio.vm
./algebric < examples_algebra/sequencia.txt > examples_vm/sequencia.vm
./algebric < examples_algebra/array_crescente.txt > examples_vm/array_crescente.vm
./algebric < examples_algebra/media_maximo_matriz.txt > examples_vm/media_maximo_matriz.vm
./algebric < examples_algebra/funcao.txt > examples_vm/funcao.vm
./algebric < examples_algebra/teste_ifs.txt > examples_vm/teste_ifs.vm

echo "error examples"
echo "file variavel_nao_declarada"
./algebric < examples_algebra/variavel_nao_declarada.txt > examples_vm/variavel_nao_declarada.vm
echo "file variavel_re_declarada"
./algebric < examples_algebra/variavel_re_declarada.txt > examples_vm/variavel_re_declarada.vm
echo "file erro_sintatico"
./algebric < examples_algebra/erro_sintatico.txt > examples_vm/erro_sintatico.vm

echo "done"
