#!/bin/bash

# 1. Criar o ficheiro de saída
> abreviaturas_truncagem.txt

# 2. Guardar as abreviaturas já utilizadas
declare -A usadas

# 3. Ler as palavras do ficheiro anterior
while read palavra; do
    tamanho=1
    tamanho_max=${#palavra}

    # Começar com a primeira letra da palavra
    abreviatura="${palavra:0:$tamanho}"

    # 4. Aumentar o número de letras se a abreviatura já existir
    while [[ -n "${usadas[$abreviatura]}" ]] && [[ $tamanho -lt $tamanho_max ]]; do
        tamanho=$((tamanho + 1))
        abreviatura="${palavra:0:$tamanho}"
    done

    # 5. Guardar a abreviatura para não se repetir
    usadas[$abreviatura]="sim"

    # Escrever a abreviatura e a palavra no ficheiro
    echo -e "$abreviatura\t$palavra" >> abreviaturas_truncagem.txt

done < palavras_limpas.txt

# 6. Mostrar uma mensagem no final
echo "Feito! Ficheiro abreviaturas_truncagem.txt gerado."
