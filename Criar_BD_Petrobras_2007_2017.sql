-- ============================================================================
-- PROJETO: Análise Preditiva e Logística de Vendas de Combustíveis (ANP)
-- SGBD: Microsoft SQL Server (T-SQL)
-- OBJETIVO: Criação da estrutura relacional (DDL) e ingestão via BULK INSERT
-- ============================================================================

DROP TABLE IF EXISTS Petrobras_CCabecalho_10k;
GO

CREATE TABLE Petrobras_CCabecalho_10k (
    data_time       VARCHAR(50),
    ano             VARCHAR(50),
    mes             VARCHAR(50),
    agente_regulado VARCHAR(MAX),
    produto         VARCHAR(100),
    regiao_origem   VARCHAR(50),
    uf_origem       VARCHAR(50),
    regiao_destino  VARCHAR(50),
    uf_destino      VARCHAR(50),
    tipo_posto      VARCHAR(255),
    valor           VARCHAR(50),
    data_clean      VARCHAR(50),
    codigo          VARCHAR(50)
);
GO

-- Ingestão em lote (Bulk Load) a partir do arquivo CSV delimitado por ponto e vírgula
BULK INSERT Petrobras_CCabecalho_10k
FROM 'C:\SQL_Import\Petrobras_CCabecalho_10k.csv'
WITH (
    FIRSTROW = 1,
    FIELDTERMINATOR = ';',
    ROWTERMINATOR = '\n',
    TABLOCK
);
GO

-- Validação inicial da carga
SELECT TOP 10 * 
FROM Petrobras_CCabecalho_10k;
GO