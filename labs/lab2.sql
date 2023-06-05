USE Northwind

--Podaj liczbê produktów o cenach mniejszych ni¿ 10$ lub wiêkszych ni¿ 20$
SELECT COUNT(*)
FROM Products
WHERE UnitPrice NOT BETWEEN 10 and 20;

--Podaj maksymaln¹ cenê produktu dla produktów o cenach poni¿ej 20$
SELECT MAX(UnitPrice)
FROM Products
WHERE UnitPrice < 20;

--Podaj maksymaln¹ i minimaln¹ i œredni¹ cenê produktu dla produktów o produktach sprzedawanych w butelkach (‘bottle’)
SELECT MAX(UnitPrice), MIN(UnitPrice), AVG(UnitPrice)
FROM Products
WHERE QuantityPerUnit LIKE '%bottle%';

--Wypisz informacjê o wszystkich produktach o cenie powy¿ej œredniej
SELECT * 
FROM Products
WHERE UnitPrice > (SELECT AVG(UnitPrice) FROM Products);

--Podaj wartoœæ zamówienia o numerze 10250
SELECT SUM(CONVERT(Money, Quantity * UnitPrice * (1-Discount))) AS Total
FROM [Order Details]
WHERE OrderID = 10250;

--Podaj maksymaln¹ cenê zamawianego produktu dla ka¿dego zamówienia
SELECT OrderID, MAX(UnitPrice)
FROM [Order Details]
GROUP BY OrderID;

-- Posortuj zamówienia wg maksymalnej ceny produktu
SELECT OrderID, MAX(UnitPrice)
FROM [Order Details]
GROUP BY OrderID
ORDER BY MAX(UnitPrice);

-- Podaj maksymaln¹ i minimaln¹ cenê zamawianego produktu dla ka¿dego zamówienia
SELECT OrderID, MAX(UnitPrice), MIN(UnitPrice)
FROM [Order Details]
GROUP BY OrderID;

--Podaj liczbê zamówieñ dostarczanych przez poszczególnych spedytorów (przewoŸników)
SELECT ShipVia, COUNT(*)
FROM Orders
GROUP BY ShipVia;

--Który z spedytorów by³ najaktywniejszy w 1997 roku
SELECT TOP 1 ShipVia, COUNT(*)
FROM Orders
WHERE YEAR(ShippedDate) = 1997
GROUP BY ShipVia
ORDER BY COUNT(*) DESC;

--Wyœwietl zamówienia dla których liczba pozycji zamówienia jest wiêksza ni¿ 5
SELECT OrderID, COUNT(*)
FROM [Order Details]
GROUP BY OrderID
HAVING COUNT(*) > 5;

--Wyœwietl klientów dla których w 1998 roku zrealizowano wiêcej ni¿ 8 zamówieñ (wyniki posortuj malej¹co wg ³¹cznej kwoty za dostarczenie zamówieñ dla ka¿dego z klientów)
SELECT CustomerID
FROM Orders
WHERE YEAR(ShippedDate) = 1998
GROUP BY CustomerID
HAVING COUNT(*) > 8
ORDER BY SUM(Freight) DESC;

--Napisz polecenie, które oblicza wartoœæ sprzeda¿y dla ka¿dego zamówienia i zwraca wynik posortowany w malej¹cej kolejnoœci (wg wartoœci sprzeda¿y)
SELECT OrderID, SUM(CONVERT(Money, Quantity * UnitPrice * (1-Discount))) AS Total
FROM [Order Details]
GROUP BY OrderID
ORDER BY Total DESC;

--Zmodyfikuj zapytanie z poprzedniego punktu, tak aby zwraca³o pierwszych 10 wierszy
SELECT TOP 10 OrderID, SUM(CONVERT(Money, Quantity * UnitPrice * (1-Discount))) AS Total
FROM [Order Details]
GROUP BY OrderID
ORDER BY Total DESC;

-- Podaj liczbê zamówionych jednostek produktów dla produktów, dla których productid < 3
SELECT ProductID, SUM(Quantity) AS Count
FROM [Order Details]
WHERE ProductID < 3
GROUP BY ProductID;

--Zmodyfikuj zapytanie z poprzedniego punktu, tak aby podawa³o liczbê zamówionych jednostek produktu dla wszystkich produktów
SELECT ProductID, SUM(Quantity) AS Count
FROM [Order Details]
GROUP BY ProductID
ORDER BY ProductID;

--Podaj nr zamówienia oraz wartoœæ zamówienia, dla zamówieñ, dla których ³¹czna liczba zamawianych jednostek produktów jest > 250
SELECT OrderID, SUM(CONVERT(Money, Quantity * Unitprice * (1-Discount))), SUM(Quantity) AS Total
FROM [Order Details]
GROUP BY OrderID
HAVING SUM(Quantity) > 250;

-- Dla ka¿dego pracownika podaj liczbê obs³ugiwanych przez niego zamówieñ
SELECT EmployeeID, COUNT(*)
FROM Orders
GROUP BY EmployeeID;

--Dla ka¿dego spedytora/przewoŸnika podaj wartoœæ "op³ata za przesy³kê" przewo¿onych przez niego zamówieñ
SELECT ShipVia, SUM(Freight)
FROM Orders
GROUP BY ShipVIa;

--Dla ka¿dego spedytora/przewoŸnika podaj wartoœæ "op³ata za przesy³kê" przewo¿onych przez niego zamówieñ w latach o 1996 do 1997
SELECT ShipVia, SUM(Freight)
FROM Orders
WHERE YEAR(ShippedDate) BETWEEN 1996 AND 1997
GROUP BY ShipVIa;

--Dla ka¿dego pracownika podaj liczbê obs³ugiwanych przez niego zamówieñ z podzia³em na lata i miesi¹ce
SELECT EmployeeID, YEAR(RequiredDate) AS Year, MONTH(RequiredDate) As Month, COUNT(*)
FROM Orders
GROUP BY EmployeeID, YEAR(RequiredDate), MONTH(RequiredDate);

--Dla ka¿dej kategorii podaj maksymaln¹ i minimaln¹ cenê produktu w tej kategorii
SELECT CategoryID, MAX(UnitpRice), MIN(UnitPrice)
FROM Products
GROUP BY CategoryID
