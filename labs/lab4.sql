USE Northwind

--Wybierz nazwy i numery telefonów klientów , którym w 1997 roku przesy³ki dostarcza³a firma United Package
SELECT CompanyName, Phone
FROM Customers
WHERE CustomerID IN (
	SELECT CustomerID
	FROM Orders
	WHERE ShipVia = (
		SELECT ShipperID
		FROM Shippers
		WHERE CompanyName = 'United Package'
	)
	AND YEAR(ShippedDate) = 1997
);

--Wybierz nazwy i numery telefonów klientów, którzy kupowali produkty z kategorii Confections
SELECT CompanyName, Phone
FROM Customers
WHERE CustomerID IN (
	SELECT DISTINCT CustomerID
	FROM Orders
	WHERE OrderID IN (
		SELECT DISTINCT OrderID
		FROM [Order Details]
		WHERE ProductID IN (
			SELECT ProductID
			FROM Products
			WHERE CategoryID = (
				SELECT CategoryID
				FROM Categories
				WHERE CategoryName = 'Confections'
			)
		)
	)
);

--Wybierz nazwy i numery telefonów klientów, którzy nie kupowali produktów z kategorii Confections
SELECT CompanyName, Phone
FROM Customers
WHERE CustomerID NOT IN (
	SELECT DISTINCT CustomerID
	FROM Orders
	WHERE OrderID IN (
		SELECT DISTINCT OrderID
		FROM [Order Details]
		WHERE ProductID IN (
			SELECT ProductID
			FROM Products
			WHERE CategoryID = (
				SELECT CategoryID
				FROM Categories
				WHERE CategoryName = 'Confections'
			)
		)
	)
);

--Dla ka¿dego produktu podaj maksymaln¹ liczbê zamówionych jednostek
SELECT ProductName, (
	SELECT MAX(Quantity)
	FROM [Order Details]
	WHERE ProductID = Products.ProductID
)
FROM Products;

--Podaj wszystkie produkty których cena jest mniejsza ni¿ œrednia cena produktu
SELECT ProductName, Unitprice
FROM Products
WHERE UnitPrice < (
	SELECT AVG(UnitPrice)
	FROM Products
);

--Podaj wszystkie produkty których cena jest mniejsza ni¿ œrednia cena produktu danej kategori
SELECT ProductName, Unitprice
FROM Products P
WHERE UnitPrice < (
	SELECT AVG(UnitPrice)
	FROM Products
	WHERE CategoryID = P.CategoryID
);

--Dla ka¿dego produktu podaj jego nazwê, cenê, œredni¹ cenê wszystkich produktów oraz ró¿nicê miêdzy cen¹ produktu a œredni¹ cen¹ wszystkich produktów
SELECT ProductName, UnitPrice, (
	SELECT AVG(UnitPrice)
	FROM Products
	) AS AveragePrice, UnitPrice - (
	SELECT AVG(UnitPrice)
	FROM Products
	)
FROM Products;

--Dla ka¿dego produktu podaj jego nazwê kategorii, nazwê produktu, cenê, œredni¹ cenê wszystkich produktów danej kategorii oraz ró¿nicê miêdzy cen¹ produktu a œredni¹ cen¹ wszystkich produktów danej kategorii
SELECT (
	SELECT CategoryName
	FROM Categories
	WHERE CategoryID = P.CategoryID
) CategoryName, ProductName, UnitPrice, (
	SELECT AVG(UnitPrice)
	FROM Products
	WHERE CategoryID = P.CategoryID
	) AS AveragePrice, UnitPrice - (
	SELECT AVG(UnitPrice)
	FROM Products
	WHERE CategoryID = P.CategoryID
	)
FROM Products P;

--Podaj ³¹czn¹ wartoœæ zamówienia o numerze 10250 (uwzglêdnij cenê za przesy³kê)
SELECT OrderID, (
	SELECT SUM(UnitPrice * Quantity * (1-Discount)) + Freight
	FROM [Order Details]
	WHERE OrderID = 10250
	)
FROM Orders
WHERE OrderID = 10250;

--Podaj ³¹czn¹ wartoœæ zamówieñ ka¿dego zamówienia (uwzglêdnij cenê za przesy³kê)
SELECT OrderID, (
	SELECT SUM(UnitPrice * Quantity * (1-Discount)) + Freight
	FROM [Order Details]
	WHERE OrderID = Orders.OrderID
	)
FROM Orders;

-- Czy s¹ jacyœ klienci którzy nie z³o¿yli ¿adnego zamówienia w 1997 roku, jeœli tak to poka¿ ich dane adresowe
SELECT CompanyName
FROM Customers
WHERE CustomerID NOT IN (
	SELECT DISTINCT CustomerID
	FROM Orders
	WHERE YEAR(OrderDate) = 1997
);

--Podaj produkty kupowane przez wiêcej ni¿ jednego klienta
SELECT ProductName
FROM Products P
WHERE P.ProductID IN (
	SELECT ProductID 
	FROM [Order Details]
	GROUP BY ProductID
	HAVING COUNT(DISTINCT OrderID) > 1
);

-- Który z pracowników obs³u¿y³ najaktywniejszy (obs³u¿y³ zamówienia o najwiêkszej wartoœci) w 1997r, podaj imiê i nazwisko takiego pracownika
SELECT FirstName, LastName
FROM Employees
WHERE EmployeeID = (
	SELECT TOP 1 O.EmployeeID
	FROM Orders O
	JOIN [Order Details] OD
	ON O.OrderID = OD.OrderID
	WHERE YEAR(O.OrderDate) = 1997
	GROUP BY EmployeeID
	ORDER BY SUM(UnitPrice * Quantity * (1-Discount)) DESC
);

--Dla ka¿dego pracownika (imiê i nazwisko) podaj ³¹czn¹ wartoœæ zamówieñ obs³u¿onych przez tego pracownika (przy obliczaniu wartoœci zamówieñ uwzglêdnij cenê za przesy³kê
SELECT E.FirstName, E.LastName, (
  SELECT SUM(UnitPrice * Quantity * (1-Discount)) + SUM(Freight)
  FROM Orders O
  JOIN [Order Details] OD ON O.OrderID = OD.OrderID
  WHERE O.EmployeeID = E.EmployeeID
)
FROM Employees E;

--Ogranicz wynik z pkt 1 tylko do pracowników
--a) którzy maj¹ podw³adnych
SELECT E.FirstName, E.LastName, (
  SELECT SUM(UnitPrice * Quantity * (1-Discount)) + SUM(Freight)
  FROM Orders O
  JOIN [Order Details] OD ON O.OrderID = OD.OrderID
  WHERE O.EmployeeID = E.EmployeeID
)
FROM Employees E
WHERE EXISTS (
	SELECT 1
	FROM Employees EM
	WHERE EM.ReportsTo = E.EmployeeID
);

--b) którzy nie maj¹ podw³adnych
SELECT E.FirstName, E.LastName, (
  SELECT SUM(UnitPrice * Quantity * (1-Discount)) + SUM(Freight)
  FROM Orders O
  JOIN [Order Details] OD ON O.OrderID = OD.OrderID
  WHERE O.EmployeeID = E.EmployeeID
)
FROM Employees E
WHERE NOT EXISTS (
	SELECT 1
	FROM Employees EM
	WHERE EM.ReportsTo = E.EmployeeID
);