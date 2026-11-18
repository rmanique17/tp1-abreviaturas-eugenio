#!/bin/bash

# 1. Contar o número total de linhas do ficheiro so.txt
total_linhas=$(wc -l < so.txt)

# 2. Calcular 80% das linhas para treino
linhas_treino=$((total_linhas * 80 / 100))

# 3. Calcular o resto (20%) para teste
linhas_teste=$((total_linhas - linhas_treino))

# 4. Extrair os dados para os novos ficheiros
head -n $linhas_treino so.txt > treino.txt
tail -n $linhas_teste so.txt > teste.txt

# 5. Mensagem de confirmação
echo "Divisão automática concluída!"
echo "Treino (80%): $linhas_treino linhas."
echo "Teste (20%): $linhas_teste linhas."
