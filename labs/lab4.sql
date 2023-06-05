USE Northwind

--Wybierz nazwy i numery telefon�w klient�w , kt�rym w 1997 roku przesy�ki dostarcza�a firma United Package
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

--Wybierz nazwy i numery telefon�w klient�w, kt�rzy kupowali produkty z kategorii Confections
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

--Wybierz nazwy i numery telefon�w klient�w, kt�rzy nie kupowali produkt�w z kategorii Confections
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

--Dla ka�dego produktu podaj maksymaln� liczb� zam�wionych jednostek
SELECT ProductName, (
	SELECT MAX(Quantity)
	FROM [Order Details]
	WHERE ProductID = Products.ProductID
)
FROM Products;

--Podaj wszystkie produkty kt�rych cena jest mniejsza ni� �rednia cena produktu
SELECT ProductName, Unitprice
FROM Products
WHERE UnitPrice < (
	SELECT AVG(UnitPrice)
	FROM Products
);

--Podaj wszystkie produkty kt�rych cena jest mniejsza ni� �rednia cena produktu danej kategori
SELECT ProductName, Unitprice
FROM Products P
WHERE UnitPrice < (
	SELECT AVG(UnitPrice)
	FROM Products
	WHERE CategoryID = P.CategoryID
);

--Dla ka�dego produktu podaj jego nazw�, cen�, �redni� cen� wszystkich produkt�w oraz r�nic� mi�dzy cen� produktu a �redni� cen� wszystkich produkt�w
SELECT ProductName, UnitPrice, (
	SELECT AVG(UnitPrice)
	FROM Products
	) AS AveragePrice, UnitPrice - (
	SELECT AVG(UnitPrice)
	FROM Products
	)
FROM Products;

--Dla ka�dego produktu podaj jego nazw� kategorii, nazw� produktu, cen�, �redni� cen� wszystkich produkt�w danej kategorii oraz r�nic� mi�dzy cen� produktu a �redni� cen� wszystkich produkt�w danej kategorii
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

--Podaj ��czn� warto�� zam�wienia o numerze 10250 (uwzgl�dnij cen� za przesy�k�)
SELECT OrderID, (
	SELECT SUM(UnitPrice * Quantity * (1-Discount)) + Freight
	FROM [Order Details]
	WHERE OrderID = 10250
	)
FROM Orders
WHERE OrderID = 10250;

--Podaj ��czn� warto�� zam�wie� ka�dego zam�wienia (uwzgl�dnij cen� za przesy�k�)
SELECT OrderID, (
	SELECT SUM(UnitPrice * Quantity * (1-Discount)) + Freight
	FROM [Order Details]
	WHERE OrderID = Orders.OrderID
	)
FROM Orders;

-- Czy s� jacy� klienci kt�rzy nie z�o�yli �adnego zam�wienia w 1997 roku, je�li tak to poka� ich dane adresowe
SELECT CompanyName
FROM Customers
WHERE CustomerID NOT IN (
	SELECT DISTINCT CustomerID
	FROM Orders
	WHERE YEAR(OrderDate) = 1997
);

--Podaj produkty kupowane przez wi�cej ni� jednego klienta
SELECT ProductName
FROM Products P
WHERE P.ProductID IN (
	SELECT ProductID 
	FROM [Order Details]
	GROUP BY ProductID
	HAVING COUNT(DISTINCT OrderID) > 1
);

-- Kt�ry z pracownik�w obs�u�y� najaktywniejszy (obs�u�y� zam�wienia o najwi�kszej warto�ci) w 1997r, podaj imi� i nazwisko takiego pracownika
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

--Dla ka�dego pracownika (imi� i nazwisko) podaj ��czn� warto�� zam�wie� obs�u�onych przez tego pracownika (przy obliczaniu warto�ci zam�wie� uwzgl�dnij cen� za przesy�k�
SELECT E.FirstName, E.LastName, (
  SELECT SUM(UnitPrice * Quantity * (1-Discount)) + SUM(Freight)
  FROM Orders O
  JOIN [Order Details] OD ON O.OrderID = OD.OrderID
  WHERE O.EmployeeID = E.EmployeeID
)
FROM Employees E;

--Ogranicz wynik z pkt 1 tylko do pracownik�w
--a) kt�rzy maj� podw�adnych
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

--b) kt�rzy nie maj� podw�adnych
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