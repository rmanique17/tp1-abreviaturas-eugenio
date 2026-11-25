#!/bin/bash

# 1. Criar o ficheiro de saída
> abreviaturas_metodo3.txt

# 2. Guardar as abreviaturas já utilizadas
declare -A usadas

while read palavra; do
    tamanho=${#palavra}

    # 3. Palavras com 3 letras ou menos ficam iguais
    if [ $tamanho -le 3 ]; then
        abreviatura="$palavra"
    else
        # 4. Juntar as 2 primeiras letras com a última
        n=2
        inicio="${palavra:0:$n}"
        fim="${palavra: -1}"
        abreviatura="${inicio}${fim}"

        # 5. Aumentar o início até a abreviatura ser única
        while [[ -n "${usadas[$abreviatura]}" ]] && [[ $n -lt $((tamanho - 1)) ]]; do
            n=$((n + 1))
            inicio="${palavra:0:$n}"
            abreviatura="${inicio}${fim}"
        done
    fi

    # 6. Guardar a abreviatura no ficheiro
    usadas[$abreviatura]="sim"
    echo -e "$abreviatura\t$palavra" >> abreviaturas_metodo3.txt

done < palavras_limpas.txt


# 7. Mensagem de confirmação
echo "Feito! Ficheiro abreviaturas_metodo3.txt gerado."
