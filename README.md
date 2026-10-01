# ⛽ Projeto — Análise Preditiva e Logística de Vendas de Combustíveis (Petrobras / ANP)

Este projeto foi concebido para desenvolver um pipeline preditivo de ponta a ponta focado na análise e classificação de padrões de consumo e movimentação de derivados de petróleo no Brasil. Utilizando dados abertos históricos da Agência Nacional do Petróleo, Gás Natural e Biocombustíveis (ANP - Dados Abertos) cobrindo o período de 2007 a 2017, o objetivo principal foi estruturar uma solução robusta de Machine Learning capaz de prever faixas de consumo (baixo, médio e alto) para apoiar decisões logísticas e operacionais.

O propósito final da arquitetura desenvolvida não se limitou a analisar o comportamento retrospectivo, mas sim garantir um modelo validado, isento de vazamento de dados (data leakage), e pronto para entrar em produção, permitindo a ingestão e predição em horizontes temporais futuros (como de 2018 a 2025) com alta confiabilidade para a tomada de decisão empresarial.
---

### 🔹Arquitetura e Engenharia de Dados

📊 Fonte: ANP – Dados Abertos
📦 Movimentação de derivados de petróleo

- Arquivo: Combustíveis líquidos
  Escolher o link Dados abertos (.zip) (atualizado em 03/09/2026)

- Link direto para download: **https://www.gov.br/anp/pt-br/centrais-de-conteudo/dados-abertos/arquivos/mdpg/liquidos.zip** - (Pasta zipada. Nome do arquivo: **Liquidos_Vendas_Historico_2007_a_2017.csv**, com **710.832 linhas**).

A base primária extraída da ANP continha 710.832 registros sem cabeçalho nativo (Liquidos_Vendas_Historico_2007_a_2017.csv). O processo de engenharia de dados envolveu etapas rigorosas:

- Inclusão e Limpeza: Aplicação manual de cabeçalhos estruturados contendo variáveis como ano, mes, Agente regulado, nome_produto, regiao_origem, uf_origem, regiao_destino, uf_destino, mercado_destinatario e quant_vendas.

- Engenharia de Atributos: Criação da variável temporal date_time e remoção de colunas redundantes ou de baixa interpretabilidade (codigo_produto).

---

🧮 **Desafios Técnicos e Mitigação de Riscos**

O cenário original apresentava um dataset altamente desbalanceado. O principal risco técnico mapeado foi o data leakage decorrente da aplicação incorreta de reamostragem (SMOTE) antes da divisão do conjunto de dados. Para mitigar esse risco, adotou-se:

1. Divisão Segura: Separação inicial em Treino e Teste via amostragem estratificada (train_test_split com stratify=y).

2. Pipeline Integrado: Encapsulamento do pré-processamento, encoding (TargetEncoder) e balanceamento (SMOTE) dentro de pipelines fechados, garantindo que o aprendizado ocorresse estritamente sobre as dobras de treino.

---

## 📁 Estrutura do Projeto

O repositório está organizado com os seguintes arquivos e artefatos principais:

├── Petrobras_Vendas_2007_a_2017.ipynb            # Jupyter Notebook principal com todo o código e análise
├── Análise Preditiva e Logística de Vendas.pptx  # Apresentação do Relatório executivo do projeto (slides)
├── README.md                                     # Documentação principal do projeto
├──.gitignore                                     # Arquivos e pastas ignorados 
└── requirements.txt                              # Dependências e bibliotecas utilizadas

---

## 🎯 Objetivos

1. Comparar **Random Forest** e **XGBoost** em cenários desbalanceados.  
2. Avaliar trade-off entre desempenho preditivo e custo computacional.  
3. Identificar variáveis mais relevantes para o consumo de combustíveis.  
4. Gerar artefatos finais para integração com **Power BI** e relatórios executivos.  

---

## ⚙️ Metodologia

- 🧹 **Pré-processamento:** limpeza, criação de cabeçalho, tratamento de valores negativos, encoding categórico (TargetEncoder).  
- 🤖 **Modelagem:** Random Forest e XGBoost com SMOTE para balanceamento.  
- 🔧 **Otimização:** GridSearchCV para ajuste de hiperparâmetros.  
- 📊 **Validação:** métricas de acurácia, precisão, recall e F1-Score ponderado.  
- 💾 **Exportação:** modelo vencedor (`.pkl`) e tabela de importância (`.csv`).  

---

#### 📉 Redução da Base de Dados

- A base original possuía **710.832 registros (2007–2017)**.  
Para viabilizar o uso de algoritmos intensivos (como **GridSearchCV** e **SMOTE**) e reduzir o custo computacional, foi realizada uma **amostragem estratificada** para **100.000 registros**, mantendo representatividade temporal e estatística.

### 🔎 Justificativa da Redução

- ⚙️ **Eficiência Computacional:**  

  - Algoritmos como Random Forest e XGBoost, combinados com SMOTE e otimização de hiperparâmetros, exigem alto poder de processamento.  
  - A redução garante tempos de execução viáveis em ambiente local sem comprometer a análise.

> ⚠️ **Observação:** 
> Embora o arquivo original cubra o período de **2007 a 2017**, a amostragem aleatória resultou em registros predominantemente entre **2007 e 2016**, mantendo representatividade estatística e eficiência computacional.


- 📊 **Preservação Estatística:**  
  - A amostragem manteve a **variabilidade temporal** (2007–2017).  
  - Preservou a **representatividade das classes** (Baixo, Médio e Alto consumo).  
  - Conservou a **distribuição real dos dados**, evitando distorções.

- ⚖️ **Trade-off:**  
  - Menor custo computacional.  
  - Manutenção da qualidade analítica.  
  - Base reduzida, mas ainda robusta para treinar e validar modelos de ML.


---

## 📊 Resultados Consolidados

| Duelo | Modelo                          | Acurácia | F1-Score |
|-------|---------------------------------|----------|----------|
| 1     | Random Forest (SMOTE)           | 0,77     | 0,78     |
|       | XGBoost (SMOTE)                 | 0,84     | 0,84     |
| 2     | Random Forest (SMOTE)           | 0,77     | 0,78     |
|       | XGBoost (SMOTE)                 | 0,85     | 0,84     |
| 3     | Random Forest (SMOTE + Tunado)  | 0,83     | 0,83     |
|       | XGBoost (SMOTE + Tunado)        | 0,81     | 0,79     |

🏆 **Modelo Campeão:** Random Forest otimizado (Duelo 3)  
- F1-Score: **0,8260**  
- Acurácia: **0,8197**  

---

## 📈 Médias Gerais

- 📊 **Média Geral de Acurácia (todos os duelos/modelos):** 0,8118 (~81%).  
- 🧮 **Média por Duelo:**  
  - Duelo 1 → 0,8068  
  - Duelo 2 → 0,8090  
  - Duelo 3 → 0,8197  
- 🔢 **Média por Modelo:**  
  - Random Forest → 0,7913  
  - XGBoost → 0,8323  

🔎 Interpretação:  
- O **XGBoost** manteve a melhor média geral de acurácia (83,23%), mostrando consistência superior ao longo das etapas.  
- O **Random Forest**, apesar de média inferior (79,13%), apresentou pico expressivo no Duelo 3 após otimização, alcançando 83%.  
- A progressão ascendente das médias por duelo comprova que os ajustes e tunagens elevaram a qualidade preditiva global.  
- O ecossistema preditivo manteve estabilidade (~81%) e robustez, com o **Random Forest otimizado** sendo o modelo campeão final para extração de importância de variáveis e integração com Power BI.  

---

## 🔄 Pipeline de Dados e Evolução dos Arquivos Gerados

O projeto adota uma abordagem em camadas (estilo ETL), onde a base de dados bruta da ANP evolui de forma rastreável até se transformar em ativos prontos para consumo preditivo e visualização de negócios. Abaixo está a rastreabilidade de cada arquivo gerado no pipeline:

1. **`vendas_2007_a_2017_tratado1.csv` (Versão 1.0 — Inserção de Cabeçalho)**
   * *O que é:* O arquivo original bruto da ANP não possuía identificação nas colunas.
   * *Propósito:* A primeira etapa adicionou programaticamente o esquema estrutural correto de 11 colunas e converteu o separador e o padrão decimal para o formato analítico padrão.

2. **`vendas_2007_a_2017_tratado_semcodif.csv` (Versão 2.0 — Limpeza e Padronização)**
   * *O que é:* Base intermediária higienizada.
   * *Propósito:* Correção de registros negativos de vendas (`.clip(lower=0)`), remoção de espaços em branco e criação da variável temporal `date_time` (removendo colunas redundantes como o código do produto).

3. **`vendas_2007_a_2017_final_100k.csv` (Versão 3.0 — Amostragem e Power BI)**
   * *O que é:* Base reduzida e otimizada.
   * *Propósito:* Realizada uma amostragem estratificada para **100.000 registros**, garantindo viabilidade computacional para algoritmos intensivos de Machine Learning sem perder a representatividade estatística. Serve como fonte nativa para os dashboards do Power BI.

4. **`Vendas_2007_a_2017_100k_ML.csv` (Versão 4.0 — Target Encoding e ML Ready)**
   * *O que é:* A matriz final pronta para o aprendizado de máquina.
   * *Propósito:* Consolidação das variáveis numéricas, criação do target categórico `faixa_consumo` (*Baixo*, *Médio*, *Alto*) e aplicação de *Target Encoding* nas colunas categóricas.

5. **`melhor_modelo_random_forest.pkl` & `importancia_recursos_modelo.csv` (Outputs Finais)**
   * *O que são:* Os artefatos de saída da modelagem.
   * *Propósito:* O arquivo `.pkl` armazena o **Random Forest Otimizado** (modelo campeão com F1-Score de 0,8260) para reuso em novas predições, enquanto o arquivo `.csv` exporta a matriz de importância dos recursos (`Feature Importance`) estruturada para alimentar visualizações gerenciais.

---

## 📁 Artefatos Finais   

- 📂 `Vendas_2007_a_2017_100k_ML.csv` → dataset final para ML.  
- 🧠 `melhor_modelo_random_forest.pkl` → modelo vencedor salvo.  
- 📊 `importancia_recursos_modelo.csv` → tabela de importância pronta para Power BI.  

---

## 💻 Como Usar o Modelo Salvo (.pkl)

Para carregar o modelo vencedor e realizar novas predições em novos conjuntos de dados (como novos períodos logísticos), utilize o seguinte script em Python:
```python
import joblib
import pandas as pd

# 1. Carregar o modelo treinado salvo na pasta outputs
modelo_carregado = joblib.load("outputs/melhor_modelo_random_forest.pkl")

# 2. Carregar novos dados (ex: período de 2018 a 2025)
# Certifique-se de aplicar o mesmo pré-processamento e encoding utilizados no treino
novos_dados = pd.read_csv("caminho/para/novos_dados.csv")

# 3. Realizar predições
predicoes = modelo_carregado.predict(novos_dados)

# 4. Visualizar os resultados das classes previstas (Baixo, Médio, Alto)
print(predicoes)
```
---

## 🚀 Conclusão

* O projeto demonstrou a eficácia do uso de **Machine Learning** para prever padrões de consumo de combustíveis.
* O **Random Forest otimizado** consolidou-se como modelo campeão, garantindo robustez, estabilidade e aplicabilidade em segmentações logísticas.

---

📊 **Próximos Passos (Business Intelligence):**
Posteriormente, será integrado e apresentado um dashboard interativo em Power BI, utilizando a base de importância dos recursos.

---

## ✍️ Autoria

Projeto desenvolvido com foco em aplicações reais na indústria energética brasileira.

**Maria Santos** — Analista/Cientista de Dados — Autônoma  
Campinas/SP, Brasil  
Data: **09/2026**
