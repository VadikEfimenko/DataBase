-- Подставляемую табличную функцию
-- Соединяем таблицы и выводим информацию о H зеленого цвета

USE ConstructionCompanies
GO

DROP FUNCTION dbo.FullInformation
GO
CREATE FUNCTION dbo.FullInformation()
RETURNS TABLE
AS 
RETURN (
		SELECT home.HomeId Id, home.HomeName NameHome, home.Color Color, company.NameCompany Company, project.NameProject Project
		FROM ConstructionCompanies.dbo.CHP list JOIN ConstructionCompanies.dbo.H home ON list.HomeId = home.HomeId
												JOIN ConstructionCompanies.dbo.C company ON list.CompaniesId = company.CompaniesId
												JOIN ConstructionCompanies.dbo.P project ON list.ProjectId = project.ProjectId
		WHERE home.Color LIKE '%Green'
)
GO 

SELECT * FROM dbo.FullInformation()
