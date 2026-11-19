
#!/bin/bash

> abreviaturas_metodo3.txt

# Guardar as abreviaturas que já foram utilizadas
declare -A usadas

while read palavra; do
    tamanho=${#palavra}

    # Se a palavra tiver 3 letras ou menos, fica igual
    if [ $tamanho -le 3 ]; then
        abreviatura="$palavra"
    else
        # Juntar as duas primeiras letras com a última
        n=2
        inicio="${palavra:0:$n}"
        fim="${palavra: -1}"
        abreviatura="${inicio}${fim}"

        # Se já existir, acrescentar mais uma letra ao início
        while [[ -n "${usadas[$abreviatura]}" ]] && [[ $n -lt $((tamanho - 1)) ]]; do
            n=$((n + 1))
            inicio="${palavra:0:$n}"
            abreviatura="${inicio}${fim}"
        done
    fi

    # Guardar a abreviatura e escrever o resultado no ficheiro
    usadas[$abreviatura]="sim"
    echo -e "$abreviatura\t$palavra" >> abreviaturas_metodo3.txt

done < palavras_limpas.txt


echo "Feito! Ficheiro abreviaturas_metodo3.txt gerado."
