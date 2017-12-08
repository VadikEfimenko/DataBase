-- —кал€рную функцию
USE ConstructionCompanies
GO

DROP FUNCTION dbo.InfoAboutFloor
GO

CREATE FUNCTION dbo.InfoAboutFloor()
RETURNS TABLE
AS
	RETURN
		(
			SELECT AVG(NumberFloors) as average_dig , 
				   MAX(dbo.H.NumberFloors) max_val, 
				   MIN(dbo.H.NumberFloors) min_val
		    FROM ConstructionCompanies.dbo.H
		);
GO

SELECT * FROM dbo.InfoAboutFloor()