
#!/bin/bash

# Separar as palavras do ficheiro de teste, passar para minúsculas e retirar símbolos
tr ' ' '\n' < teste.txt | tr '\r' '\n' | tr '[:upper:]' '[:lower:]' | tr -d '[:punct:]«»' | grep '^[a-z][a-z]*$' > palavras_teste.txt
# Contar os caracteres do ficheiro original
chars_orig=$(wc -m < teste.txt)

# Verificar os três ficheiros de abreviaturas
for dicionario in abreviaturas_contracao.txt abreviaturas_truncagem.txt abreviaturas_metodo3.txt; do

    # Limpar os dados anteriores antes de ler o próximo ficheiro
    unset mapa
    declare -A mapa

    # Ler as abreviaturas e as respetivas palavras
    while IFS=$'\t' read -r abrev palavra; do
        if [[ -n "$palavra" ]]; then
            mapa["$palavra"]="$abrev"
        fi
    done < "$dicionario"

    substituidas=0
    poupados=0

    # Percorrer todas as palavras do ficheiro de teste
    while read -r palavra; do
        abrev="${mapa[$palavra]}"

        # Substituir a palavra apenas se a abreviatura for mais pequena
        if [[ -n "$abrev" ]] && [[ ${#abrev} -lt ${#palavra} ]]; then
            substituidas=$((substituidas + 1))
            poupados=$((poupados + ${#palavra} - ${#abrev}))
        fi
    done < palavras_teste.txt

    chars_abrev=$((chars_orig - poupados))

    # Calcular a percentagem de caracteres poupados 
poupanca=$(gawk "BEGIN {printf \"%.2f\", ($chars_orig - $chars_abrev) * 100 / $chars_orig}")

    echo "----------------------------------------"
    echo "Dicionário: $dicionario"
    echo "Palavras substituídas: $substituidas"
    echo "Caracteres originais: $chars_orig"
    echo "Caracteres após substituição: $chars_abrev"
    echo "Poupança de caracteres: $poupanca%"
done
