
#!/bin/bash

# Separar as palavras, passar para minúsculas, retirar símbolos e eliminar repetidas
tr ' ' '\n' < treino.txt | tr '\r' '\n' | tr '[:upper:]' '[:lower:]' | tr -d '[:punct:]«»' | grep '^[a-z][a-z]*$' | sort | uniq > palavras_limpas.txt

# Criar o ficheiro para guardar os resultados
> abreviaturas_contracao.txt

# Ler as palavras e retirar as vogais
while read palavra; do
    # Retirar todas as vogais da palavra
    abreviatura=$(echo "$palavra" | tr -d 'aeiouáéíóúãõâê')
    
    # Só guardar se ainda tiver letras depois de retirar as vogais
    if [ -n "$abreviatura" ]; then
        echo -e "$abreviatura\t$palavra" >> abreviaturas_contracao.txt
    fi
done < palavras_limpas.txt

# Mostrar uma mensagem quando terminar
echo "Feito! Ficheiro abreviaturas_contracao.txt."
