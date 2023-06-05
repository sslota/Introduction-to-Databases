USE Northwind

--Podaj liczb� produkt�w o cenach mniejszych ni� 10$ lub wi�kszych ni� 20$
SELECT COUNT(*)
FROM Products
WHERE UnitPrice NOT BETWEEN 10 and 20;

--Podaj maksymaln� cen� produktu dla produkt�w o cenach poni�ej 20$
SELECT MAX(UnitPrice)
FROM Products
WHERE UnitPrice < 20;

--Podaj maksymaln� i minimaln� i �redni� cen� produktu dla produkt�w o produktach sprzedawanych w butelkach (�bottle�)
SELECT MAX(UnitPrice), MIN(UnitPrice), AVG(UnitPrice)
FROM Products
WHERE QuantityPerUnit LIKE '%bottle%';

--Wypisz informacj� o wszystkich produktach o cenie powy�ej �redniej
SELECT * 
FROM Products
WHERE UnitPrice > (SELECT AVG(UnitPrice) FROM Products);

--Podaj warto�� zam�wienia o numerze 10250
SELECT SUM(CONVERT(Money, Quantity * UnitPrice * (1-Discount))) AS Total
FROM [Order Details]
WHERE OrderID = 10250;

--Podaj maksymaln� cen� zamawianego produktu dla ka�dego zam�wienia
SELECT OrderID, MAX(UnitPrice)
FROM [Order Details]
GROUP BY OrderID;

-- Posortuj zam�wienia wg maksymalnej ceny produktu
SELECT OrderID, MAX(UnitPrice)
FROM [Order Details]
GROUP BY OrderID
ORDER BY MAX(UnitPrice);

-- Podaj maksymaln� i minimaln� cen� zamawianego produktu dla ka�dego zam�wienia
SELECT OrderID, MAX(UnitPrice), MIN(UnitPrice)
FROM [Order Details]
GROUP BY OrderID;

--Podaj liczb� zam�wie� dostarczanych przez poszczeg�lnych spedytor�w (przewo�nik�w)
SELECT ShipVia, COUNT(*)
FROM Orders
GROUP BY ShipVia;

--Kt�ry z spedytor�w by� najaktywniejszy w 1997 roku
SELECT TOP 1 ShipVia, COUNT(*)
FROM Orders
WHERE YEAR(ShippedDate) = 1997
GROUP BY ShipVia
ORDER BY COUNT(*) DESC;

--Wy�wietl zam�wienia dla kt�rych liczba pozycji zam�wienia jest wi�ksza ni� 5
SELECT OrderID, COUNT(*)
FROM [Order Details]
GROUP BY OrderID
HAVING COUNT(*) > 5;

--Wy�wietl klient�w dla kt�rych w 1998 roku zrealizowano wi�cej ni� 8 zam�wie� (wyniki posortuj malej�co wg ��cznej kwoty za dostarczenie zam�wie� dla ka�dego z klient�w)
SELECT CustomerID
FROM Orders
WHERE YEAR(ShippedDate) = 1998
GROUP BY CustomerID
HAVING COUNT(*) > 8
ORDER BY SUM(Freight) DESC;

--Napisz polecenie, kt�re oblicza warto�� sprzeda�y dla ka�dego zam�wienia i zwraca wynik posortowany w malej�cej kolejno�ci (wg warto�ci sprzeda�y)
SELECT OrderID, SUM(CONVERT(Money, Quantity * UnitPrice * (1-Discount))) AS Total
FROM [Order Details]
GROUP BY OrderID
ORDER BY Total DESC;

--Zmodyfikuj zapytanie z poprzedniego punktu, tak aby zwraca�o pierwszych 10 wierszy
SELECT TOP 10 OrderID, SUM(CONVERT(Money, Quantity * UnitPrice * (1-Discount))) AS Total
FROM [Order Details]
GROUP BY OrderID
ORDER BY Total DESC;

-- Podaj liczb� zam�wionych jednostek produkt�w dla produkt�w, dla kt�rych productid < 3
SELECT ProductID, SUM(Quantity) AS Count
FROM [Order Details]
WHERE ProductID < 3
GROUP BY ProductID;

--Zmodyfikuj zapytanie z poprzedniego punktu, tak aby podawa�o liczb� zam�wionych jednostek produktu dla wszystkich produkt�w
SELECT ProductID, SUM(Quantity) AS Count
FROM [Order Details]
GROUP BY ProductID
ORDER BY ProductID;

--Podaj nr zam�wienia oraz warto�� zam�wienia, dla zam�wie�, dla kt�rych ��czna liczba zamawianych jednostek produkt�w jest > 250
SELECT OrderID, SUM(CONVERT(Money, Quantity * Unitprice * (1-Discount))), SUM(Quantity) AS Total
FROM [Order Details]
GROUP BY OrderID
HAVING SUM(Quantity) > 250;

-- Dla ka�dego pracownika podaj liczb� obs�ugiwanych przez niego zam�wie�
SELECT EmployeeID, COUNT(*)
FROM Orders
GROUP BY EmployeeID;

--Dla ka�dego spedytora/przewo�nika podaj warto�� "op�ata za przesy�k�" przewo�onych przez niego zam�wie�
SELECT ShipVia, SUM(Freight)
FROM Orders
GROUP BY ShipVIa;

--Dla ka�dego spedytora/przewo�nika podaj warto�� "op�ata za przesy�k�" przewo�onych przez niego zam�wie� w latach o 1996 do 1997
SELECT ShipVia, SUM(Freight)
FROM Orders
WHERE YEAR(ShippedDate) BETWEEN 1996 AND 1997
GROUP BY ShipVIa;

--Dla ka�dego pracownika podaj liczb� obs�ugiwanych przez niego zam�wie� z podzia�em na lata i miesi�ce
SELECT EmployeeID, YEAR(RequiredDate) AS Year, MONTH(RequiredDate) As Month, COUNT(*)
FROM Orders
GROUP BY EmployeeID, YEAR(RequiredDate), MONTH(RequiredDate);

--Dla ka�dej kategorii podaj maksymaln� i minimaln� cen� produktu w tej kategorii
SELECT CategoryID, MAX(UnitpRice), MIN(UnitPrice)
FROM Products
GROUP BY CategoryID
