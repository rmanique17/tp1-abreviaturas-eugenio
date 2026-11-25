#!/bin/bash

# 1. Limpar o texto, passar para minúsculas e eliminar palavras repetidas
tr ' ' '\n' < treino.txt | tr '\r' '\n' | tr '[:upper:]' '[:lower:]' | tr -d '[:punct:]«»' | grep '^[a-z][a-z]*$' | sort | uniq > palavras_limpas.txt

# 2. Criar o ficheiro de saída
> abreviaturas_contracao.txt

# 3. Ler as palavras e retirar as vogais
while read palavra; do
    # Retirar as vogais da palavra
    abreviatura=$(echo "$palavra" | tr -d 'aeiouáéíóúãõâê')

    # Guardar apenas se a abreviatura não ficar vazia
    if [ -n "$abreviatura" ]; then
        echo -e "$abreviatura\t$palavra" >> abreviaturas_contracao.txt
    fi
done < palavras_limpas.txt

# 4. Mensagem de confirmação
echo "Feito! Ficheiro abreviaturas_contracao.txt."
