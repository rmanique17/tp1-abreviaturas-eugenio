#!/bin/bash

# 1. Limpar o texto de teste e separar as palavras
tr ' ' '\n' < teste.txt | tr '\r' '\n' | tr '[:upper:]' '[:lower:]' | tr -d '[:punct:]«»' | grep '^[a-z][a-z]*$' > palavras_teste.txt

# 2. Contar os caracteres do ficheiro original
chars_orig=$(wc -m < teste.txt)

# 3. Testar os três ficheiros de abreviaturas
for dicionario in abreviaturas_contracao.txt abreviaturas_truncagem.txt abreviaturas_metodo3.txt; do

    # Limpar a lista antes de carregar o próximo dicionário
    unset mapa
    declare -A mapa

    # Ler as abreviaturas e as palavras correspondentes
    while IFS=$'\t' read -r abrev palavra; do
        if [[ -n "$palavra" ]]; then
            mapa["$palavra"]="$abrev"
        fi
    done < "$dicionario"

    substituidas=0
    poupados=0

    # 4. Percorrer as palavras do texto de teste
    while read -r palavra; do
        abrev="${mapa[$palavra]}"

        # Substituir apenas se a abreviatura for mais curta
        if [[ -n "$abrev" ]] && [[ ${#abrev} -lt ${#palavra} ]]; then
            substituidas=$((substituidas + 1))
            poupados=$((poupados + ${#palavra} - ${#abrev}))
        fi
    done < palavras_teste.txt

    # 5. Calcular o total de caracteres após as substituições
    chars_abrev=$((chars_orig - poupados))

    # 6. Calcular a percentagem de caracteres poupados
    poupanca=$(gawk "BEGIN {printf \"%.2f\", ($chars_orig - $chars_abrev) * 100 / $chars_orig}")

    # 7. Mostrar os resultados
    echo "----------------------------------------"
    echo "Dicionário: $dicionario"
    echo "Palavras substituídas: $substituidas"
    echo "Caracteres originais: $chars_orig"
    echo "Caracteres após substituição: $chars_abrev"
    echo "Poupança de caracteres: $poupanca%"
done
