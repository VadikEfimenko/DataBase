BULK INSERT ConstructionCompanies.dbo.C
FROM 'C:/Users/vadik/Desktop/BD/lab1/C.txt'
WITH (DATAFILETYPE = 'char', ROWTERMINATOR = '\n', FIELDTERMINATOR = '\t');
GO

BULK INSERT ConstructionCompanies.dbo.P
FROM 'C:/Users/vadik/Desktop/BD/lab1/P.txt'
WITH (DATAFILETYPE = 'char', ROWTERMINATOR = '\n', FIELDTERMINATOR = '\t');
GO

BULK INSERT ConstructionCompanies.dbo.H
FROM 'C:/Users/vadik/Desktop/BD/lab1/H.txt'
WITH (DATAFILETYPE = 'char', ROWTERMINATOR = '\n', FIELDTERMINATOR = '\t');
GO

BULK INSERT ConstructionCompanies.dbo.CHP
FROM 'C:/Users/vadik/Desktop/BD/lab1/CHP.txt'
WITH (DATAFILETYPE = 'char', ROWTERMINATOR = '\n', FIELDTERMINATOR = '\t');
GO

INSERT ConstructionCompanies.dbo.H (HomeId, NumberFloors, Color, License, HomeName)
VALUES(2, 51, 'Red', '4665', 'fjhfg')