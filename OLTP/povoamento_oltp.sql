CREATE DATABASE bd_zenatu

USE bd_zenatu

DROP TABLE IF EXISTS TB_PEDIDO
DROP TABLE IF EXISTS TB_ENCOMENDA
DROP TABLE IF EXISTS TB_CLIENTE
DROP TABLE IF EXISTS TB_ASSINATURA
DROP TABLE IF EXISTS TB_TIPO_VALOR
DROP TABLE IF EXISTS TB_PRODUTO

DROP TABLE TB_PEDIDO
DROP TABLE TB_ENCOMENDA
DROP TABLE TB_CLIENTE
DROP TABLE TB_ASSINATURA
DROP TABLE TB_TIPO_VALOR
DROP TABLE TB_PRODUTO

CREATE TABLE TB_CLIENTE(
	ID_CLIENTE INT NOT NULL PRIMARY KEY,
	NOME VARCHAR(50) NOT NULL,
	RUA VARCHAR(100) NOT NULL,
	NUMERO VARCHAR(100) NOT NULL,
	REFERENCIA VARCHAR(100) NOT NULL,
	TELEFONE VARCHAR (13) NOT NULL,
	CELULAR VARCHAR (13) NOT NULL,
	EMAIL VARCHAR(50) NOT NULL,
	CPF VARCHAR(11) NOT NULL,
	CIDADE VARCHAR(50) NULL,
	ESTADO VARCHAR(50) NULL,
	UNIQUE (CPF,EMAIL)
)

CREATE TABLE TB_ASSINATURA(
	ID_ASSINATURA INT NOT NULL PRIMARY KEY,
	VALOR_MENSALIDADE NUMERIC(10,2) NOT NULL,
	DATA_INICIO DATETIME NOT NULL,
	DATA_CANCELAMENTO DATETIME NULL,
	STATUS VARCHAR(9) NOT NULL CHECK(STATUS IN ('ATIVO','CANCELADO'))
)


CREATE TABLE TB_PRODUTO(
    ID_PRODUTO INT NOT NULL PRIMARY KEY,
    COD_PRODUTO INT NOT NULL,
    NOME VARCHAR(100) NOT NULL DEFAULT('ZENATUCAPS'),
    DATA_FABRICACAO DATETIME NOT NULL,
    DATA_VALIDADE DATETIME NOT NULL
)


CREATE TABLE TB_TIPO_VALOR(
	ID_TIPO_VALOR INT NOT NULL PRIMARY KEY,
	TIPO_PACOTE VARCHAR(15) NOT NULL CHECK(TIPO_PACOTE IN ('1 POTE','3 POTES','5 POTES')),
	PRECO_PACOTE NUMERIC(10,2) NOT NULL
)

CREATE TABLE TB_ENCOMENDA(
    ID_ENCOMENDA INT NOT NULL PRIMARY KEY,
    COD_ENCOMENDA INT NOT NULL,
    ID_PRODUTO INT NOT NULL REFERENCES TB_PRODUTO,
    ID_TIPO_VALOR INT NOT NULL REFERENCES TB_TIPO_VALOR,
)

CREATE TABLE TB_PEDIDO(
	ID_PEDIDO INT NOT NULL PRIMARY KEY,
	VALOR NUMERIC(10,2) NOT NULL,
	DATA_COMPRA DATETIME NOT NULL,
	PREVISAO_CHEGADA DATETIME NOT NULL,
	DATA_CHEGADA DATETIME NULL,
	ID_CLIENTE INT NOT NULL REFERENCES TB_CLIENTE,
	ID_ASSINATURA INT NULL REFERENCES TB_ASSINATURA,
	ID_TIPO_VALOR INT NOT NULL REFERENCES TB_TIPO_VALOR,
	ID_ENCOMENDA INT NOT NULL REFERENCES TB_ENCOMENDA
)

SELECT * FROM TB_ASSINATURA


SELECT * FROM TB_CLIENTE


SELECT * FROM TB_ENCOMENDA


SELECT * FROM TB_PEDIDO


SELECT * FROM TB_PRODUTO


SELECT * FROM TB_TIPO_VALOR



---INSERTS TESTES


INSERT INTO TB_ASSINATURA(ID_ASSINATURA, VALOR_MENSALIDADE, DATA_INICIO, DATA_CANCELAMENTO, STATUS) --1
VALUES(1, 174.00, GETDATE(), NULL, 'ATIVO')

INSERT INTO TB_CLIENTE(ID_CLIENTE,NOME,CPF,ESTADO,CIDADE,RUA,NUMERO,REFERENCIA,CELULAR,TELEFONE,EMAIL) --2
VALUES(1, 'Kendy', 'centro', '09925763428', 'SE', 'ITABAIANA', 100, 'CASA', '5579999846586', '5579999846586','kendy.ceo@zenatucaps.com')

INSERT INTO TB_PRODUTO(ID_PRODUTO, COD_PRODUTO, NOME, DATA_FABRICACAO, DATA_VALIDADE) --3
VALUES(1, 1, 'ZENATUCAPS', '19900101', GETDATE())

INSERT INTO TB_TIPO_VALOR(ID_TIPO_VALOR, TIPO_PACOTE, PRECO_PACOTE) --4
VALUES(1,'1 POTE',174.00)

INSERT INTO TB_ENCOMENDA(ID_ENCOMENDA, COD_ENCOMENDA, ID_PRODUTO, ID_TIPO_VALOR) --5
VALUES(1, 1, 1, 1)

INSERT INTO TB_PEDIDO(ID_PEDIDO, VALOR, DATA_COMPRA, PREVISAO_CHEGADA, 
						DATA_CHEGADA, ID_CLIENTE, ID_ASSINATURA, ID_TIPO_VALOR, ID_ENCOMENDA) --6
VALUES (1, 174.00, GETDATE(), GETDATE()+9,NULL,1,1,1,1)



---INSERTS 2

INSERT INTO TB_ASSINATURA(ID_ASSINATURA, VALOR_MENSALIDADE, DATA_INICIO, DATA_CANCELAMENTO, STATUS) --1
VALUES(2, 350.00, GETDATE(), GETDATE()+29, 'CANCELADO'),
		(3, 500.00, GETDATE(), NULL, 'ATIVO')



INSERT INTO TB_CLIENTE(ID_CLIENTE,NOME,CPF,ESTADO,CIDADE,RUA,NUMERO,REFERENCIA,CELULAR,TELEFONE,EMAIL) --2
VALUES(2, 'Thiago', '09925763427', 'SE', 'NOSSA SENHORA DO SOCORRO', 'cafuz', 150, 'CASA', '79999846586', '79999846586', 'thiago.kasakaiu@zenatucaps.com'),
		(3, 'Andr�', '9925763428', 'SP', 'ITAQUERA', 'RUA DA CALMARIA', 10, 'APARTAMENTO', '999846586','999846586', 'andre.professor@gmail.com')

INSERT INTO TB_PRODUTO(ID_PRODUTO, COD_PRODUTO, NOME, DATA_FABRICACAO, DATA_VALIDADE) --3
VALUES(2, 2, 'ZENATUCAPS', '19900102', GETDATE()),
		(3, 3, 'ZENATUCAPS', '19900103', GETDATE()),
		(4, 4, 'ZENATUCAPS', '20000428', GETDATE()),
		(5, 5, 'ZENATUCAPS', '19900103', GETDATE())

INSERT INTO TB_TIPO_VALOR(ID_TIPO_VALOR, TIPO_PACOTE, PRECO_PACOTE) --4
VALUES(2,'3 POTES',350.00),
		(3,'5 POTES',500.00)

INSERT INTO TB_ENCOMENDA(ID_ENCOMENDA, COD_ENCOMENDA, ID_PRODUTO, ID_TIPO_VALOR) --5
VALUES(2, 2, 2, 2),
		(3, 3, 3, 3)

INSERT INTO TB_ENCOMENDA(ID_ENCOMENDA, COD_ENCOMENDA, ID_PRODUTO, ID_TIPO_VALOR) --5
VALUES(4, 3, 4, 3)

INSERT INTO TB_PEDIDO(ID_PEDIDO, VALOR, DATA_COMPRA, PREVISAO_CHEGADA, 
						DATA_CHEGADA, ID_CLIENTE, ID_ASSINATURA, ID_TIPO_VALOR, ID_ENCOMENDA) --6
VALUES (2, 350.00, GETDATE(), GETDATE()+9,GETDATE()+4,2,2,2,2),
		(3, 500.00, GETDATE(), GETDATE()+9,NULL,3,3,3,3)


