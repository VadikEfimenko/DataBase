--Многооператорную табличную функцию
USE OnlineShop
GO
DROP FUNCTION dbo.Information
GO

CREATE FUNCTION dbo.Information()
RETURNS @MyTable TABLE
(
	HOMEID INT NOT NULL,
	NAMEHOME VARCHAR(40) NOT NULL,
	HOMECOLOR VARCHAR(40) NOT NULL,
	HOMECOMPANY VARCHAR(40) NOT NULL,
	HOMEPROJECT VARCHAR(40) NOT NULL
)
AS
BEGIN
	INSERT INTO @MyTable
		SELECT home.HomeId Id, home.HomeName NameHome, home.Color Color, company.NameCompany Company, project.NameProject Project
		FROM ConstructionCompanies.dbo.CHP list JOIN ConstructionCompanies.dbo.H home ON list.HomeId = home.HomeId
												JOIN ConstructionCompanies.dbo.C company ON list.CompaniesId = company.CompaniesId
												JOIN ConstructionCompanies.dbo.P project ON list.ProjectId = project.ProjectId
		WHERE home.Color LIKE '%Green'
RETURN 
END
GO

SELECT * FROM dbo.Information()
ORDER BY 1