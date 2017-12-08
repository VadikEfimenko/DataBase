-- Хранимую процедуру без параметров или с параметрами
USE ConstructionCompanies
GO

DROP PROCEDURE ExchangeId
GO

CREATE PROCEDURE dbo.ExchangeId(@Name VARCHAR(45), @NumberFloor INT)
AS
BEGIN
	UPDATE ConstructionCompanies.dbo.H
	SET NumberFloors = @NumberFloor,
	HomeName = @Name
	WHERE HomeId BETWEEN 1 AND 5;
END

GO

EXEC ExchangeId 'BMSTU', 45
GO
SELECT * FROM ConstructionCompanies.dbo.H H WHERE H.HomeId BETWEEN 1 AND 10	