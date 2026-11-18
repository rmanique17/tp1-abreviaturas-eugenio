
#!/bin/bash

# Criar o ficheiro onde vão ficar os resultados
> abreviaturas_truncagem.txt

# Guardar as abreviaturas que já foram utilizadas
declare -A usadas

# Ler as palavras do ficheiro anterior, uma de cada vez
while read palavra; do
    tamanho=1
    tamanho_max=${#palavra}
    
    # Começar por usar apenas a primeira letra da palavra
    abreviatura="${palavra:0:$tamanho}"
    
    # Se a abreviatura já existir, acrescentar mais uma letra
    while [[ -n "${usadas[$abreviatura]}" ]] && [[ $tamanho -lt $tamanho_max ]]; do
        tamanho=$((tamanho + 1))
        abreviatura="${palavra:0:$tamanho}"
    done
    
    # Guardar a abreviatura para não voltar a ser utilizada
    usadas[$abreviatura]="sim"
    
    # Escrever a abreviatura e a palavra no ficheiro
    echo -e "$abreviatura\t$palavra" >> abreviaturas_truncagem.txt

done < palavras_limpas.txt

# Mostrar uma mensagem no final
echo "Feito! Ficheiro abreviaturas_truncagem.txt gerado."
