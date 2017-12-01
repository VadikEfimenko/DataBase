USE master

IF EXISTS (
    SELECT name
        FROM sys.databases
        WHERE name = N'ConstructionCompanies'
) 

BEGIN
	ALTER DATABASE ConstructionCompanies SET SINGLE_USER WITH ROLLBACK IMMEDIATE
	DROP DATABASE ConstructionCompanies
END

CREATE DATABASE ConstructionCompanies
GO

USE ConstructionCompanies

IF OBJECT_ID('C', 'U') IS NOT NULL
DROP TABLE C
GO
-- Create the table in the specified schema
CREATE TABLE C
(
    CompaniesId INT NOT NULL, 
    NameCompany VARCHAR(85) NOT NULL,
    LastName VARCHAR(85),
    Phone VARCHAR(85),
	City VARCHAR(85),
);
GO

IF OBJECT_ID('P', 'U') IS NOT NULL
DROP TABLE P
GO
-- Create the table in the specified schema
CREATE TABLE P
(
    ProjectId INT NOT NULL, 
    NameProject VARCHAR(85) NOT NULL,
    City VARCHAR(85),
);
GO

IF OBJECT_ID('H', 'U') IS NOT NULL
DROP TABLE H
GO

CREATE TABLE H
(
    HomeId INT NOT NULL, 
    NumberFloors INT NOT NULL,
    Color VARCHAR(85),
	License VARCHAR(85),
	HomeName VARCHAR(85),
);
GO


IF OBJECT_ID('CHP', 'U') IS NOT NULL
DROP TABLE CHP
GO

CREATE TABLE CHP
(
	CHPId INT NOT NULL, 
    CompaniesId INT NOT NULL, 
    HomeId INT NOT NULL,
    ProjectId INT NOT NULL,
	Number INT NOT NULL,
);
GO