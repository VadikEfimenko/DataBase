-- 1. ���������� SELECT, ������������ �������� ���������.
-- ������� ������ �� ������� h, ��� ���-�� ������ ������ 10 � ������������� �� ������
SELECT * 
FROM ConstructionCompanies.dbo.H AS H
WHERE H.NumberFloors > 10
ORDER BY H.Color;

-- 2. ���������� SELECT, ������������ �������� BETWEEN.
-- ������� ������, ��� ���-�� ������ ������ 10 � ������ 12
SELECT * 
FROM ConstructionCompanies.dbo.H AS H
WHERE H.NumberFloors BETWEEN 10 AND 12;

-- 3. ���������� SELECT, ������������ �������� LIKE.
-- ������� ������, ��� ���� ���� ������
SELECT *
FROM ConstructionCompanies.dbo.H AS H
WHERE H.Color LIKE '%Green';

-- 4. ���������� SELECT, ������������ �������� IN � ��������� �����������.
-- ������ �������, ���-�� ������ � ���� ������� ����� 1
SELECT *
FROM ConstructionCompanies.dbo.P AS P
WHERE P.ProjectId IN (SELECT CHP.ProjectId 
						FROM ConstructionCompanies.dbo.CHP AS CHP
						JOIN ConstructionCompanies.dbo.H AS H
							ON CHP.HomeId = H.HomeId AND H.NumberFloors = 1);


-- 5. ���������� SELECT, ������������ �������� EXISTS � ��������� �����������.
-- true ��� flase
SELECT *
FROM ConstructionCompanies.dbo.P AS P
WHERE EXISTS
			(SELECT *
				FROM ConstructionCompanies.dbo.H AS H
				WHERE P.ProjectId < 10 AND H.NumberFloors = 1);


--6.	���������� SELECT, ������������ �������� ��������� � ���������.
-- ������� ��� ����, ��� ���-�� ������ ����� ���-�� ������ � ������ � id 20
SELECT *
FROM ConstructionCompanies.dbo.H AS H
WHERE H.NumberFloors = ALL 
	(
		SELECT H.NumberFloors
		FROM ConstructionCompanies.dbo.H AS H
		WHERE H.HomeId = 20
	);


--7.���������� SELECT, ������������ ���������� ������� � ���������� ��������.
-- ������� ���-�� �����, ��� ���-�� ������ ������ 5
SELECT COUNT(*) AS 'Count Home'
FROM ConstructionCompanies.dbo.H AS H
WHERE H.NumberFloors < 5;

--8.	���������� SELECT, ������������ ��������� ���������� � ���������� ��������.
-- ������� ������� ���-�� ������ ��� ������� �������
SELECT CHP.ProjectId, (SELECT AVG(H.NumberFloors)
				  FROM ConstructionCompanies.dbo.H AS H
				  WHERE CHP.HomeId = H.HomeId) AS AvgFloor
FROM ConstructionCompanies.dbo.CHP AS CHP

-- 9 ���������� SELECT, ������������ ������� ��������� CASE.
-- ���� = 10 'ten', else 'not ten'
SELECT H.HomeId, H.NumberFloors, CASE
				WHEN H.NumberFloors = 10 THEN 'Ten'
				ELSE 'Not ten'
				END AS Floors
FROM ConstructionCompanies.dbo.H AS H


-- 10 ���������� SELECT, ������������ ��������� ��������� CASE.
-- ���� ���-�� ������ ������ 10 - small, else grade
SELECT H.HomeId, H.NumberFloors, CASE
				WHEN H.NumberFloors < 10 THEN 'Small'
				ELSE 'grade'
				END AS Floors
FROM ConstructionCompanies.dbo.H AS H

-- 11.	�������� ����� ��������� ��������� ������� �� ��������������� ������ ������ ���������� SELECT. 
-- ������� ��������� �������, ��������� �� ���� �������� ������� homename
SELECT H.HomeName, SUM(H.NumberFloors) AS Sum
INTO #BuferTable
FROM ConstructionCompanies.dbo.H H
WHERE H.HomeId IS NOT NULL
GROUP BY H.HomeName,H.NumberFloors;
GO 
SELECT * FROM #BuferTable;


-- 12.	���������� SELECT, ������������ ��������� ��������������� ���������� � �������� ����������� ������ � ����������� FROM.
-- �������� ��������, id < 500, � ������� id ���� > 900

SELECT P.NameProject
FROM ConstructionCompanies.dbo.P P
JOIN ( SELECT CHP.ProjectId
		FROM ConstructionCompanies.dbo.CHP CHP
		WHERE CHP.HomeId > 900 ) AS PR
		ON PR.ProjectId = P.ProjectId
WHERE P.ProjectId < 500;

-- 13.	���������� SELECT, ������������ ��������� ���������� � ������� ����������� 3.
-- �������� ��������, id ���� > ����������� id ������� > ���������� �������� id ������� < 10
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

-- 14.	���������� SELECT, ��������������� ������ � ������� ����������� GROUP BY, �� ��� ����������� HAVING.
-- min max projectId ��� homeID < 500
SELECT P.City, MIN(P.ProjectID) AS MIN, MAX(P.ProjectID) AS MAX
FROM ConstructionCompanies.dbo.P P
JOIN ConstructionCompanies.dbo.CHP CHP 
	ON CHP.ProjectId = P.ProjectId AND CHP.HomeId < 500
GROUP BY P.City

-- 15.	���������� SELECT, ��������������� ������ � ������� ����������� GROUP BY �  ����������� HAVING.
SELECT P.City, MIN(P.ProjectID) AS MIN, MAX(P.ProjectID) AS MAX
FROM ConstructionCompanies.dbo.P P
JOIN ConstructionCompanies.dbo.CHP CHP 
	ON CHP.ProjectId = P.ProjectId AND CHP.HomeId < 500
GROUP BY P.ProjectId, P.City
HAVING P.ProjectId < 100

-- 16. (USE) ������������ ���������� INSERT, ����������� ������� � ������� ����� ������ ��������.

INSERT ConstructionCompanies.dbo.C (CompaniesId ,NameCompany, LastName, Phone, City)
VALUES (1003,'Stroitell', 'Ivanov', '+79773335476', ' Moscow')

-- 17. (USE)	������������� ���������� INSERT, ����������� ������� � ������� ��������������� ������ ������ ���������� ����������.

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

-- 18. (USE)	������� ���������� UPDATE

UPDATE ConstructionCompanies.dbo.C
SET ConstructionCompanies.dbo.C.City = 'Vladimir'
WHERE ConstructionCompanies.dbo.C.CompaniesId BETWEEN 4 AND 6 

-- 19.	���������� UPDATE �� ��������� ����������� � ����������� SET.
 UPDATE ConstructionCompanies.dbo.H
 SET ConstructionCompanies.dbo.H.NumberFloors = (
										  SELECT H.NumberFloors
										  FROM ConstructionCompanies.dbo.H AS H
										  WHERE H.HomeId = 12
										  )
WHERE ConstructionCompanies.dbo.H.HomeId = 13

-- 20.	������� ���������� DELETE.

DELETE ConstructionCompanies.dbo.H 
WHERE HomeId IS NULL;

-- (NO) 21.	���������� DELETE � ��������� ��������������� ����������� � ����������� WHERE.
DELETE ConstructionCompanies.dbo.P
WHERE ProjectId > ( SELECT MIN(CHP.ProjectId)
		FROM ConstructionCompanies.dbo.CHP CHP
		WHERE CHP.HomeId > 900 )

-- 22.	���������� SELECT, ������������ ������� ���������� ��������� ���������.
-- ������� id � ���-�� ����� ����� 5 � 15
WITH CTE (IDHome, Number)
AS 
(
	SELECT CHP.HomeId, CHP.Number
	FROM ConstructionCompanies.dbo.CHP AS CHP
	WHERE CHP.HomeId BETWEEN 5 AND 15
)
SELECT DISTINCT CHP.IDHome AS 'IDHome',CHP.Number AS 'The number of houses (ID from 100 to 200)' 
FROM CTE AS CHP

-- 23.	���������� SELECT, ������������ ����������� ���������� ��������� ���������.
-- �������� �������
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
-- ���������� ������� ����������.
INSERT INTO dbo.MyEmployees VALUES (1, N'����', N'������', N'������� �������������� ��������',16,NULL) 
GO
-- ����������� ���
WITH DirectReports (ManagerID, EmployeeID, Title, DeptID, Level)
AS
(
-- ����������� ������������� ��������
    SELECT e.ManagerID, e.EmployeeID, e.Title, e.DeptID, 0 AS Level
    FROM dbo.MyEmployees AS e
    WHERE ManagerID IS NULL
    UNION ALL
-- ����������� ������������ ��������
    SELECT e.ManagerID, e.EmployeeID, e.Title, e.DeptID, Level + 1
    FROM dbo.MyEmployees AS e INNER JOIN DirectReports AS d ON e.ManagerID = d.EmployeeID
)
-- ����������, ������������ ���
SELECT ManagerID, EmployeeID, Title, DeptID, Level
FROM DirectReports ;

DROP TABLE dbo.MyEmployees

-- 24 ������������������ ������������� ���������� PIVOT � UNPIVOT � ����������� FROM ���������� SELECT
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