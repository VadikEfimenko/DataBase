--Рекурсивную функцию или функцию с рекурсивным ОТВ
DROP FUNCTION dbo.Factorial;
GO

CREATE FUNCTION dbo.Factorial (@n int = 1)
RETURNS float
WITH RETURNS NULL ON NULL INPUT
AS
BEGIN
	DECLARE @result float;
	SET @result = NULL;
	IF @n > 0
	BEGIN
		SET @result = 1.0;
		WITH Numbers (num)
		AS
		(
			SELECT 1
			UNION ALL
			SELECT num + 1
			FROM Numbers
			WHERE num < @n
		)
		SELECT @result = @result * num
		FROM Numbers;
	END;
	RETURN @result;
END;
GO


SELECT dbo.Factorial(2) RES;
SELECT dbo.Factorial(4) RES;
SELECT dbo.Factorial(5) RES;
GO