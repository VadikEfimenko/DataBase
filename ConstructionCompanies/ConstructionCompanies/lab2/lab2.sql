-- 1. Инструкция SELECT, использующая предикат сравнения.
-- вывести записи из таблицы h, где кол-во этажей больше 10 и отсортировать по цыетам
SELECT * 
FROM ConstructionCompanies.dbo.H AS H
WHERE H.NumberFloors > 10
ORDER BY H.Color;

-- 2. Инструкция SELECT, использующая предикат BETWEEN.
-- вывести записи, где кол-во этажей больше 10 и меньше 12
SELECT * 
FROM ConstructionCompanies.dbo.H AS H
WHERE H.NumberFloors BETWEEN 10 AND 12;

-- 3. Инструкция SELECT, использующая предикат LIKE.
-- вывести записи, где цвет дома зелёный
SELECT *
FROM ConstructionCompanies.dbo.H AS H
WHERE H.Color LIKE '%Green';

-- 4. Инструкция SELECT, использующая предикат IN с вложенным подзапросом.
-- выести проекты, кол-во этажей в доме которых равно 1
SELECT *
FROM ConstructionCompanies.dbo.P AS P
WHERE P.ProjectId IN (SELECT CHP.ProjectId 
						FROM ConstructionCompanies.dbo.CHP AS CHP
						JOIN ConstructionCompanies.dbo.H AS H
							ON CHP.HomeId = H.HomeId AND H.NumberFloors = 1);


-- 5. Инструкция SELECT, использующая предикат EXISTS с вложенным подзапросом.
-- true или flase
SELECT *
FROM ConstructionCompanies.dbo.P AS P
WHERE EXISTS
			(SELECT *
				FROM ConstructionCompanies.dbo.H AS H
				WHERE P.ProjectId < 10 AND H.NumberFloors = 1);


--6.	Инструкция SELECT, использующая предикат сравнения с квантором.
-- Выбрать все дома, где кол-во этажей равно кол-ву этажей в записи с id 20
SELECT *
FROM ConstructionCompanies.dbo.H AS H
WHERE H.NumberFloors = ALL 
	(
		SELECT H.NumberFloors
		FROM ConstructionCompanies.dbo.H AS H
		WHERE H.HomeId = 20
	);


--7.Инструкция SELECT, использующая агрегатные функции в выражениях столбцов.
-- вывести кол-во домов, где кол-во этажей меньше 5
SELECT COUNT(*) AS 'Count Home'
FROM ConstructionCompanies.dbo.H AS H
WHERE H.NumberFloors < 5;

--8.	Инструкция SELECT, использующая скалярные подзапросы в выражениях столбцов.
-- вывести среднее кол-во этажей для каждого проекта
SELECT CHP.ProjectId, (SELECT AVG(H.NumberFloors)
				  FROM ConstructionCompanies.dbo.H AS H
				  WHERE CHP.HomeId = H.HomeId) AS AvgFloor
FROM ConstructionCompanies.dbo.CHP AS CHP

-- 9 Инструкция SELECT, использующая простое выражение CASE.
-- если = 10 'ten', else 'not ten'
SELECT H.HomeId, H.NumberFloors, CASE
				WHEN H.NumberFloors = 10 THEN 'Ten'
				ELSE 'Not ten'
				END AS Floors
FROM ConstructionCompanies.dbo.H AS H


-- 10 Инструкция SELECT, использующая поисковое выражение CASE.
-- если кол-во этажей меньше 10 - small, else grade
SELECT H.HomeId, H.NumberFloors, CASE
				WHEN H.NumberFloors < 10 THEN 'Small'
				ELSE 'grade'
				END AS Floors
FROM ConstructionCompanies.dbo.H AS H

-- 11.	Создание новой временной локальной таблицы из результирующего набора данных инструкции SELECT. 
-- вывести локальную таблицу, созданную из двух столбцов таблицы homename
SELECT H.HomeName, SUM(H.NumberFloors) AS Sum
INTO #BuferTable
FROM ConstructionCompanies.dbo.H H
WHERE H.HomeId IS NOT NULL
GROUP BY H.HomeName,H.NumberFloors;
GO 
SELECT * FROM #BuferTable;


-- 12.	Инструкция SELECT, использующая вложенные коррелированные подзапросы в качестве производных таблиц в предложении FROM.
-- Названия проектов, id < 500, у которых id дома > 900

SELECT P.NameProject
FROM ConstructionCompanies.dbo.P P
JOIN ( SELECT CHP.ProjectId
		FROM ConstructionCompanies.dbo.CHP CHP
		WHERE CHP.HomeId > 900 ) AS PR
		ON PR.ProjectId = P.ProjectId
WHERE P.ProjectId < 500;

-- 13.	Инструкция SELECT, использующая вложенные подзапросы с уровнем вложенности 3.
-- Название проектов, id дома > колличества id проекта > количества компаний id которых < 10
SELECT P.NameProject
FROM ConstructionCompanies.dbo.P P
JOIN ( SELECT CHP.ProjectId
		FROM ConstructionCompanies.dbo.CHP CHP
		WHERE CHP.HomeId > 
				(SELECT COUNT(*)
				FROM ConstructionCompanies.dbo.CHP CHP
				WHERE CHP.ProjectId > 
					(SELECT COUNT(*)
					FROM ConstructionCompanies.dbo.CHP CHP
					WHERE CHP.CompaniesId < 10)
				)
	) AS PR
ON PR.ProjectId = P.ProjectId

-- 14.	Инструкция SELECT, консолидирующая данные с помощью предложения GROUP BY, но без предложения HAVING.
-- min max projectId для homeID < 500
SELECT P.City, MIN(P.ProjectID) AS MIN, MAX(P.ProjectID) AS MAX
FROM ConstructionCompanies.dbo.P P
JOIN ConstructionCompanies.dbo.CHP CHP 
	ON CHP.ProjectId = P.ProjectId AND CHP.HomeId < 500
GROUP BY P.City

-- 15.	Инструкция SELECT, консолидирующая данные с помощью предложения GROUP BY и  предложения HAVING.
SELECT P.City, MIN(P.ProjectID) AS MIN, MAX(P.ProjectID) AS MAX
FROM ConstructionCompanies.dbo.P P
JOIN ConstructionCompanies.dbo.CHP CHP 
	ON CHP.ProjectId = P.ProjectId AND CHP.HomeId < 500
GROUP BY P.ProjectId, P.City
HAVING P.ProjectId < 100

-- 16. (USE) Однострочная инструкция INSERT, выполняющая вставку в таблицу одной строки значений.

INSERT ConstructionCompanies.dbo.C (CompaniesId ,NameCompany, LastName, Phone, City)
VALUES (1003,'Stroitell', 'Ivanov', '+79773335476', ' Moscow')

-- 17. (USE)	Многострочная инструкция INSERT, выполняющая вставку в таблицу результирующего набора данных вложенного подзапроса.

INSERT ConstructionCompanies.dbo.C (CompaniesId, NameCompany, LastName, Phone, City)
SELECT MAX(CompaniesId)+1, (
				SELECT H.HomeName
				FROM ConstructionCompanies.dbo.H AS H
				WHERE HomeId = 30
				), 'Stepanov', '456785443',
             (
				SELECT P.City
				FROM  ConstructionCompanies.dbo.P AS P
				WHERE ProjectId = 1
			 )
FROM ConstructionCompanies.dbo.C AS C

-- 18. (USE)	Простая инструкция UPDATE

UPDATE ConstructionCompanies.dbo.C
SET ConstructionCompanies.dbo.C.City = 'Vladimir'
WHERE ConstructionCompanies.dbo.C.CompaniesId BETWEEN 4 AND 6 

-- 19.	Инструкция UPDATE со скалярным подзапросом в предложении SET.
 UPDATE ConstructionCompanies.dbo.H
 SET ConstructionCompanies.dbo.H.NumberFloors = (
										  SELECT H.NumberFloors
										  FROM ConstructionCompanies.dbo.H AS H
										  WHERE H.HomeId = 12
										  )
WHERE ConstructionCompanies.dbo.H.HomeId = 13

-- 20.	Простая инструкция DELETE.

DELETE ConstructionCompanies.dbo.H 
WHERE HomeId IS NULL;

-- (NO) 21.	Инструкция DELETE с вложенным коррелированным подзапросом в предложении WHERE.
DELETE ConstructionCompanies.dbo.P
WHERE ProjectId > ( SELECT MIN(CHP.ProjectId)
		FROM ConstructionCompanies.dbo.CHP CHP
		WHERE CHP.HomeId > 900 )

-- 22.	Инструкция SELECT, использующая простое обобщенное табличное выражение.
-- вывести id и кол-во домов между 5 и 15
WITH CTE (IDHome, Number)
AS 
(
	SELECT CHP.HomeId, CHP.Number
	FROM ConstructionCompanies.dbo.CHP AS CHP
	WHERE CHP.HomeId BETWEEN 5 AND 15
)
SELECT DISTINCT CHP.IDHome AS 'IDHome',CHP.Number AS 'The number of houses (ID from 100 to 200)' 
FROM CTE AS CHP

-- 23.	Инструкция SELECT, использующая рекурсивное обобщенное табличное выражение.
-- создание таблицы
CREATE TABLE dbo.MyEmployees
(
	EmployeeID smallint NOT NULL,
	FirstName nvarchar(30)  NOT NULL,
	LastName  nvarchar(40) NOT NULL,
	Title nvarchar(50) NOT NULL,
	DeptID smallint NOT NULL,
	ManagerID int NULL,
 	CONSTRAINT PK_EmployeeID PRIMARY KEY CLUSTERED (EmployeeID ASC) 
) ;
GO
-- Заполнение таблицы значениями.
INSERT INTO dbo.MyEmployees VALUES (1, N'Иван', N'Петров', N'Главный исполнительный директор',16,NULL) 
GO
-- Определение ОТВ
WITH DirectReports (ManagerID, EmployeeID, Title, DeptID, Level)
AS
(
-- Определение закрепленного элемента
    SELECT e.ManagerID, e.EmployeeID, e.Title, e.DeptID, 0 AS Level
    FROM dbo.MyEmployees AS e
    WHERE ManagerID IS NULL
    UNION ALL
-- Определение рекурсивного элемента
    SELECT e.ManagerID, e.EmployeeID, e.Title, e.DeptID, Level + 1
    FROM dbo.MyEmployees AS e INNER JOIN DirectReports AS d ON e.ManagerID = d.EmployeeID
)
-- Инструкция, использующая ОТВ
SELECT ManagerID, EmployeeID, Title, DeptID, Level
FROM DirectReports ;

DROP TABLE dbo.MyEmployees

-- 24 продемонстрировать использование операторов PIVOT и UNPIVOT в предложении FROM инструкции SELECT
IF OBJECT_ID('T', 'U') IS NOT NULL
DROP TABLE T
GO
CREATE TABLE T
(
	fio VARCHAR(50),
	god int NOT NULL,
	summa int NOT NULL,
);
GO
INSERT INTO T
VALUES
('Grud', 2012, 200),
('Fedorov', 2012, 200),
('Grud', 2013, 400),
('Fedorov', 2013, 500),
('Gribov', 2012, 200),
('Gribov', 2013, 100)
GO
SELECT fio, [2012],[2013]
from T
PIVOT (SUM(summa)FOR god in ([2012],[2013])
) AS test



--  25 MERGE

CREATE TABLE t1
(
	productID INT PRIMARY KEY,
	productName VARCHAR(20),
	productPrice INT NOT NULL
)

GO

INSERT INTO t1
VALUES
(1, 'HOME1', 200),
(2, 'DOM1', 500),
(3, 'COL1', 100),
(4, 'KEK1', 700)

CREATE TABLE t2
(
	productID INT PRIMARY KEY,
	productName VARCHAR(20),
	productPrice INT NOT NULL
)

GO

INSERT INTO t2
VALUES
(1, 'HOME2', 200),
(2, 'DOM2', 550),
(3, 'COL2', 200),
(4, 'KEK2', 750)

GO
SELECT * FROM t1;
SELECT * FROM t2;
GO

MERGE t1 AS TARGET
USING t2 AS SOURCE
ON (TARGET.productID = SOURCE.productID)

WHEN MATCHED AND TARGET.productName <> SOURCE.productName
OR TARGET.productPrice <> SOURCE.productPrice THEN
UPDATE SET TARGET.productName = SOURCE.productName,
TARGET.productPrice = SOURCE.productPrice

WHEN NOT MATCHED BY TARGET THEN
INSERT (productID, productName, productPrice)
VALUES (SOURCE.productID, SOURCE.productName, SOURCE.productPrice);




DROP TABLE t2
DROP TABLE t1 