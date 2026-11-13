-- Filtrar por um Agente Regulado específico (por exemplo, a RAIZEN S.A.):
SELECT * 
FROM Petrobras_CCabecalho_10k
WHERE agente_regulado = 'RAIZEN S.A.';
GO

-- vendas do ano de 2014 na sua tabela
SELECT * 
FROM Petrobras_CCabecalho_10k
WHERE ano = '2014';
GO

--quantas vendas ocorreram em 2014
SELECT COUNT(*) AS Total_Vendas_2014
FROM Petrobras_CCabecalho_10k
WHERE ano = '2014';
GO

-- Ver agrupado por produto em 2014
SELECT produto, COUNT(*) AS Total_Registros
FROM Petrobras_CCabecalho_10k
WHERE ano = '2014'
GROUP BY produto
ORDER BY Total_Registros DESC;
GO

-- Apurar qual região vendeu mais (qual possui o maior número de registros/vendas na sua tabela)

-- Contar por Região de Origem

SELECT regiao_origem, COUNT(*) AS Total_Vendas
FROM Petrobras_CCabecalho_10k
GROUP BY regiao_origem
ORDER BY Total_Vendas DESC;
GO

-- Contar por Região de Destino

SELECT regiao_destino, COUNT(*) AS Total_Vendas
FROM Petrobras_CCabecalho_10k
GROUP BY regiao_destino
ORDER BY Total_Vendas DESC;
GO

-- Para ver apenas o 1º colocado (a que mais vendeu), basta usar o TOP 1
SELECT TOP 1 regiao_origem, COUNT(*) AS Total_Vendas
FROM Petrobras_CCabecalho_10k
GROUP BY regiao_origem
ORDER BY Total_Vendas DESC;
GO

-- Porcentagem de venda de cada região
SELECT 
    regiao_origem AS Regiao,
    COUNT(*) AS Total_Vendas,
    -- Calcula a porcentagem em relação ao total geral da tabela
    CAST(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Petrobras_CCabecalho_10k) AS DECIMAL(5,2)) AS Porcentagem_Vendas
FROM Petrobras_CCabecalho_10k
GROUP BY regiao_origem
ORDER BY Total_Vendas DESC;
GO



