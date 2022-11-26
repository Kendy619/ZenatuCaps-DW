USE bd_zenatu

CREATE OR ALTER PROCEDURE SP_AGGREGATE_PEDIDO_CIDADE_MES
AS
BEGIN
    DECLARE @ID_MES BIGINT,
			@MES INT,
			@ANO INT,
			@ID_CIDADE INT,
			@VALOR NUMERIC(10, 2),
			@ID_PEDIDO INT,
			@ID_DIA BIGINT
	DECLARE C_MES CURSOR FOR 
	SELECT ID_TEMP, MES, ANO FROM DIM_TEMPO WHERE NIVEL = 'MES' 

	DELETE FATO_PEDIDO_LOCAL_MES

	OPEN C_MES
	FETCH C_MES INTO @ID_MES, @MES, @ANO
	WHILE @@FETCH_STATUS = 0
	BEGIN
		INSERT INTO FATO_PEDIDO_LOCAL_MES
		SELECT P.ID_OPERACIONAL, P.ID_CIDADE, P.ID_TIPO_VALOR, SUM(P.VALOR) 
		FROM FATO_PEDIDO P
		JOIN DIM_TEMPO T
		ON P.ID_DATA_COMPRA = T.ID_TEMPO
		WHERE MONTH(T.DATA) = @MES AND YEAR(T.DATA) = @ANO
		GROUP BY P.ID_CIDADE, P.ID_TIPO_VALOR

		FETCH C_MES INTO @ID_MES, @MES, @ANO

	END
	CLOSE C_MES
	DEALLOCATE C_MES
END

GO