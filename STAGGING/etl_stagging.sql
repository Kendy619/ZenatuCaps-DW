use bd_zenatu

--CARREGANDO TB_AUX_CLIENTE
GO
CREATE OR ALTER PROCEDURE SP_STAGGING_CLIENTE (@DATACARGA DATETIME)
AS
BEGIN
	DELETE TB_AUX_CLIENTE
	WHERE DATACARGA = @DATACARGA

	INSERT INTO TB_AUX_CLIENTE(DATACARGA,COD_CLIENTE,NOME,CPF,ESTADO,CIDADE,RUA,NUMERO,REFERENCIA,CELULAR,TELEFONE,EMAIL)
	SELECT @DATACARGA, C.ID_CLIENTE,C.NOME,C.CPF,C.ESTADO,C.CIDADE,C.RUA,C.NUMERO,C.REFERENCIA,C.CELULAR,C.TELEFONE,C.EMAIL FROM TB_CLIENTE C
END


--CARREGANDO TB_AUX_PRODUTO
GO
CREATE OR ALTER PROCEDURE SP_STAGGING_PRODUTO (@DATACARGA DATETIME)
AS
BEGIN
	DELETE TB_AUX_PRODUTO
	WHERE DATACARGA = @DATACARGA

	INSERT INTO TB_AUX_PRODUTO(DATACARGA,COD_PRODUTO, MOME, DATA_FABRICACAO, DATA_VALIDADE)
	SELECT @DATACARGA, C.COD_PRODUTO, C.MOME, C.DATA_FABRICACAO, C.DATA_VALIDADE FROM TB_PRODUTO P
END


--CARREGANDO TB_AUX_TIPO_VALOR
GO
CREATE OR ALTER PROCEDURE SP_STAGGING_TIPO_VALOR (@DATACARGA DATETIME)
AS
BEGIN
	DELETE TB_AUX_TIPO_VALOR
	WHERE DATACARGA = @DATACARGA

	INSERT INTO TB_TIPO_VALOR(DATACARGA, ID_TIPO_VALOR, TIPO_PACOTE, PRECO_PACOTE)
	SELECT @DATACARGA, TP.ID_TIPO_VALOR, TP.TIPO_PACOTE, TP.PRECO_PACOTE FROM TB_TIPO_VALOR TP
END


--CARREGANDO TB_AUX_ASSINATURA
GO
CREATE OR ALTER PROCEDURE SP_STAGGING_ASSINATURA (@DATACARGA DATETIME)
AS
BEGIN
	DELETE TB_AUX_ASSINATURA
	WHERE DATACARGA = @DATACARGA



	INSERT INTO TB_AUX_ASSINATURA(DATACARGA, COD_ASSINATURA, VALOR_MENSALIDADE, STATUS, DATA_INICIO, DATA_CANCELAMENTO, ID_CLIENTE, ID_TIPO_VALOR)
	SELECT @DATACARGA, A.ID_ASSINATURA, A.VALOR_MENSALIDADE, A.STATUS, A.DATA_INICIO, 
	A.DATA_CANCELAMENTO, P.ID_CLIENTE, P.ID_TIPO_VALOR FROM TB_ASSINATURA A
	INNER JOIN TB_PEDIDO P ON(A.ID_ASSINATURA=P.ID_ASSINATURA)
END


--CARREGANDO TB_AUX_PEDIDO //FAZER CURSOR AQUI AINDA
GO
CREATE OR ALTER PROCEDURE SP_STAGGING_PEDIDO (@DATACARGA DATETIME)
AS
BEGIN
	DELETE TB_AUX_PEDIDO
	WHERE DATACARGA = @DATACARGA


	INSERT INTO TB_AUX_PEDIDO(DATACARGA, COD_PEDIDO, VALOR, ID_CLIENTE, ID_TIPO_VALOR, ID_PRODUTO, ID_ASSINATURA, DATA_COMPRA, DATA_PREVISAO_CHEGADA, DATA_CHEGADA)
	SELECT '20190202', P.ID_PEDIDO, P.VALOR, P.ID_CLIENTE, P.ID_TIPO_VALOR, PR.ID_PRODUTO, P.ID_ASSINATURA, P.DATA_COMPRA, P.DATA_PREVISAO_CHEGADA, P.DATA_CHEGADA)
END