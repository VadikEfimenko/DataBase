-- Рекурсивную хранимую процедуру или хранимую процедур с рекурсивным ОТВ
USE ConstructionCompanies
GO

DROP PROCEDURE ExapleProc2
GO
-- объедение вывода двух запросов
CREATE PROCEDURE dbo.ExapleProc2
AS
	WITH tableSalesmen(HomeID)
	AS
	(
		SELECT H.HomeID
		FROM ConstructionCompanies.dbo.H H
		WHERE H.NumberFloors BETWEEN 10 AND 12

		UNION ALL

		SELECT H.HomeID
		FROM ConstructionCompanies.dbo.H H
		WHERE  H.Color LIKE '%Green' 
	)

	SELECT * FROM tableSalesmen
GO

ExapleProc2
