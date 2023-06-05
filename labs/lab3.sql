USE Northwind

--Wybierz nazwy i ceny produktów (baza northwind) o cenie jednostkowej pomiêdzy 20.00 a 30.00, dla ka¿dego produktu podaj dane adresowe dostawcy
SELECT ProductName, UnitPrice, Suppliers.CompanyName
FROM Suppliers
JOIN Products
ON Suppliers.SupplierID = Products.SupplierID
WHERE UnitPrice BETWEEN 20 AND 30;

--Wybierz nazwy produktów oraz inf. o stanie magazynu dla produktów dostarczanych przez firmê ‘Tokyo Traders’
SELECT ProductName, UnitsInStock
FROM Products
JOIN Suppliers
ON Products.SupplierID=Suppliers.SupplierID
WHERE CompanyName = 'Tokyo Traders';

--Czy s¹ jacyœ klienci którzy nie z³o¿yli ¿adnego zamówienia w 1997 roku, jeœli tak to poka¿ ich dane adresowe
SELECT CompanyName, Address
FROM Customers
JOIN Orders
ON Customers.CustomerID = Orders.CustomerID 
AND YEAR(OrderDate) = 1997
WHERE OrderDate IS NULL;

--Wybierz nazwy i numery telefonów dostawców, dostarczaj¹cych produkty, których aktualnie nie ma w magazynie
SELECT CompanyName, Phone
FROM Suppliers
JOIN Products
ON Suppliers.SupplierID = Products.SupplierID
WHERE UnitsInStock = 0;

USE library

--Napisz polecenie, które wyœwietla listê dzieci bêd¹cych cz³onkami biblioteki (baza library). Interesuje nas imiê, nazwisko i data urodzenia dziecka
SELECT firstname, lastname, juvenile.birth_date
FROM member
JOIN juvenile
ON member.member_no = juvenile.member_no;

--Napisz polecenie, które podaje tytu³y aktualnie wypo¿yczonych ksi¹¿ek
SELECT title
FROM title
JOIN loanhist
ON title.title_no = loanhist.title_no
WHERE out_date IS NOT NULL
AND in_date IS NULL;

--Podaj informacje o karach zap³aconych za przetrzymywanie ksi¹¿ki o tytule ‘Tao Teh King’. Interesuje nas data oddania ksi¹¿ki, ile dni by³a przetrzymywana i jak¹ zap³acono karê
SELECT fine_paid, in_date, DATEDIFF(Day, in_date, loan.due_date)
FROM loanhist
JOIN title
ON loanhist.title_no = title.title_no
JOIN loan
ON title.title_no = loan.title_no
WHERE title = 'Tao Teh King' 
AND fine_paid IS NOT NULL;

--Napisz polecenie które podaje listê ksi¹¿ek (mumery ISBN) zarezerwowanych przez osobê o nazwisku: Stephen A. Graff
SELECT isbn
FROM loan
JOIN member
ON loan.member_no = member.member_no
WHERE firstname = 'Stephen'
AND middleinitial = 'A'
AND lastname = 'Graff';

USE Northwind

--Wybierz nazwy i ceny produktów (baza northwind) o cenie jednostkowej pomiêdzy 20.00 a 30.00, dla ka¿dego produktu podaj dane adresowe dostawcy, interesuj¹ nas tylko produkty z kategorii ‘Meat/Poultry’
SELECT ProductName, UnitPrice, Address
FROM Products
JOIN Suppliers
ON Products.SupplierID = Suppliers.SupplierID
JOIN Categories
ON Products.CategoryID = Categories.CategoryID
WHERE UnitPrice BETWEEN 20 AND 30
AND CategoryName = 'Meat/Poultry';

--Wybierz nazwy i ceny produktów z kategorii ‘Confections’ dla ka¿dego produktu podaj nazwê dostawcy
SELECT ProductName, UnitPrice, Address
FROM Products
JOIN Suppliers
ON Products.SupplierID = Suppliers.SupplierID
JOIN Categories
ON Products.CategoryID = Categories.CategoryID
WHERE CategoryName = 'Confections';

--Wybierz nazwy i numery telefonów klientów , którym w 1997 roku przesy³ki dostarcza³a firma ‘United Package’
SELECT Customers.CompanyName, Customers.Phone
FROM Customers
JOIN Orders
ON Customers.CustomerID = Orders.CustomerID
JOIN Shippers
ON Orders.ShipVia = Shippers.ShipperID
WHERE YEAR(ShippedDate) = 1997
AND Shippers.CompanyName = 'United Package';

--Wybierz nazwy i numery telefonów klientów, którzy kupowali produkty z kategorii ‘Confections'
SELECT Customers.CompanyName, Customers.Phone
FROM Customers
JOIN Orders
ON Customers.CustomerID = Orders.CustomerID
JOIN [Order Details]
ON Orders.OrderID = [Order Details].OrderID
JOIN Products
ON [Order Details].ProductID = Products.ProductID
JOIN Categories
ON Products.CategoryID = Categories.CategoryID
WHERE CategoryName = 'Confections';

USE library

--Napisz polecenie, które wyœwietla listê dzieci bêd¹cych cz³onkami biblioteki (baza library). Interesuje nas imiê, nazwisko, data urodzenia dziecka i adres zamieszkania dziecka
SELECT firstname, lastname, juvenile.birth_date, adult.street
FROM member
JOIN juvenile
ON member.member_no = juvenile.member_no
JOIN adult
ON juvenile.adult_member_no = adult.member_no;

--Napisz polecenie, które wyœwietla listê dzieci bêd¹cych cz³onkami biblioteki (baza library). Interesuje nas imiê, nazwisko, data urodzenia dziecka, adres zamieszkania dziecka oraz imiê i nazwisko rodzica
SELECT member.firstname, member.lastname, juvenile.birth_date, adult.street, parent.firstname, parent.lastname
FROM member
JOIN juvenile
ON member.member_no = juvenile.member_no
JOIN adult
ON juvenile.adult_member_no = adult.member_no
JOIN member parent
ON juvenile.adult_member_no = parent.member_no;

USE Northwind

--Napisz polecenie, które wyœwietla pracowników oraz ich podw³adnych (baza northwind)
SELECT A.Firstname, A.Lastname, B.FirstName, B.LastName
FROM Employees A
JOIN Employees B
ON A.ReportsTo = B.EmployeeID
WHERE A.ReportsTo IS NOT NULL;

--Napisz polecenie, które wyœwietla pracowników, którzy nie maj¹ podw³adnych (baza northwind)
SELECT A.Firstname, A.Lastname
FROM Employees A
JOIN Employees B
ON A.EmployeeID = B.ReportsTo
WHERE A.ReportsTo IS NULL
GROUP BY A.Firstname, A.Lastname;

USE library

--Napisz polecenie, które wyœwietla adresy cz³onków biblioteki, którzy maj¹ dzieci urodzone przed 1 stycznia 1996
SELECT street, adult.member_no
FROM adult
JOIN juvenile
ON adult.member_no = juvenile.adult_member_no
WHERE YEAR(juvenile.birth_date) < 1996;

--Napisz polecenie, które wyœwietla adresy cz³onków biblioteki, którzy maj¹ dzieci urodzone przed 1 stycznia 1996. Interesuj¹ nas tylko adresy takich cz³onków biblioteki, którzy aktualnie nie przetrzymuj¹ ksi¹¿ek.
SELECT street, adult.member_no
FROM adult
JOIN juvenile
ON adult.member_no = juvenile.adult_member_no
JOIN loan
ON adult.member_no = loan.member_no
WHERE YEAR(juvenile.birth_date) < 1996
AND out_date IS NULL;

--Napisz polecenie które zwraca imiê i nazwisko (jako pojedyncz¹ kolumnê – name), oraz informacje o adresie: ulica, miasto, stan kod (jako pojedyncz¹  kolumnê – address) dla wszystkich doros³ych cz³onków biblioteki
SELECT (firstname + ' ' + lastname) AS 'name', (street + ', ' + city + ', ' + state + ', ' + zip) AS 'address'
FROM member 
JOIN adult
ON member.member_no = adult.member_no;

--Napisz polecenie, które zwraca: isbn, copy_no, on_loan, title, translation, cover, dla ksi¹¿ek o isbn 1, 500 i 1000. Wynik posortuj wg ISBN
SELECT copy.isbn, copy_no, on_loan, title, translation, cover
FROM copy
JOIN item
ON copy.isbn = item.isbn
JOIN title
ON copy.title_no = title.title_no
WHERE copy.isbn IN (1, 500, 1000)
ORDER BY 1 DESC;

--Napisz polecenie które zwraca informacje o u¿ytkownikach biblioteki o nr 250, 342, i 1675 (dla ka¿dego u¿ytkownika: nr, imiê i nazwisko cz³onka biblioteki), oraz informacjê o zarezerwowanych ksi¹¿kach (isbn, data)
SELECT member.member_no, firstname, lastname, isbn, log_date
FROM member
JOIN reservation
ON member.member_no = reservation.member_no
WHERE member.member_no IN (250, 342, 1675);

--Podaj listê cz³onków biblioteki mieszkaj¹cych w Arizonie (AZ) maj¹ wiêcej ni¿ dwoje dzieci zapisanych do biblioteki 
SELECT firstname, lastname, state, COUNT(juvenile.member_no)
FROM member
JOIN juvenile 
ON juvenile.adult_member_no = member.member_no
JOIN adult 
ON member.member_no = adult.member_no
WHERE adult.State = 'AZ'
GROUP BY member.member_no, firstname, lastname, state
HAVING COUNT(juvenile.member_no) > 2

-- Podaj listê cz³onków biblioteki mieszkaj¹cych w Arizonie (AZ) którzy maj¹ wiêcej ni¿ dwoje dzieci zapisanych do biblioteki oraz takich którzy mieszkaj¹ w Kaliforni(CA) i maj¹ wiêcej ni¿ troje dzieci zapisanych do bibliotek
SELECT firstname, lastname, state, COUNT(juvenile.member_no)
FROM member
JOIN juvenile 
ON juvenile.adult_member_no = member.member_no
JOIN adult 
ON member.member_no = adult.member_no
WHERE adult.State = 'AZ'
GROUP BY member.member_no, firstname, lastname, state
HAVING COUNT(juvenile.member_no) > 2
UNION
SELECT firstname, lastname, state, COUNT(juvenile.member_no)
FROM member
JOIN juvenile 
ON juvenile.adult_member_no = member.member_no
JOIN adult 
ON member.member_no = adult.member_no
WHERE adult.State = 'CA'
GROUP BY member.member_no, firstname, lastname, state
HAVING COUNT(juvenile.member_no) > 3;

USE Northwind

--Dla ka¿dego zamówienia podaj ³¹czn¹ liczbê zamówionych jednostek towaru oraz nazwê klienta
SELECT [Order Details].OrderID, SUM(Quantity), Customers.CompanyName
FROM [Order Details]
JOIN Orders
ON [Order Details].OrderID = Orders.OrderID
JOIN Customers
ON Orders.CustomerID = Customers.CustomerID
GROUP BY [Order Details].OrderID, Customers.CompanyName;

--Zmodyfikuj poprzedni przyk³ad, aby pokazaæ tylko takie zamówienia, dla których ³¹czna liczbê zamówionych jednostek jest wiêksza ni¿ 250
SELECT [Order Details].OrderID, SUM(Quantity), Customers.CompanyName
FROM [Order Details]
JOIN Orders
ON [Order Details].OrderID = Orders.OrderID
JOIN Customers
ON Orders.CustomerID = Customers.CustomerID
GROUP BY [Order Details].OrderID, Customers.CompanyName
HAVING SUM(Quantity) > 250;

--Dla ka¿dego zamówienia podaj ³¹czn¹ wartoœæ tego zamówienia oraz nazwê klienta
SELECT [Order Details].OrderID, SUM(UnitPrice * Quantity * (1-Discount)), Customers.CompanyName
FROM [Order Details]
JOIN Orders
ON [Order Details].OrderID = Orders.OrderID
JOIN Customers
ON Orders.CustomerID = Customers.CustomerID
GROUP BY [Order Details].OrderID, Customers.CompanyName;

--Zmodyfikuj poprzedni przyk³ad, aby pokazaæ tylko takie zamówienia, dla których ³¹czna liczba jednostek jest wiêksza ni¿ 250
SELECT [Order Details].OrderID, SUM(UnitPrice * Quantity * (1-Discount)), SUM(Quantity), Customers.CompanyName
FROM [Order Details]
JOIN Orders
ON [Order Details].OrderID = Orders.OrderID
JOIN Customers
ON Orders.CustomerID = Customers.CustomerID
GROUP BY [Order Details].OrderID, Customers.CompanyName
HAVING SUM(Quantity) > 250;

--Zmodyfikuj poprzedni przyk³ad tak ¿eby dodaæ jeszcze imiê i nazwisko pracownika obs³uguj¹cego zamówienie
SELECT [Order Details].OrderID, SUM(UnitPrice * Quantity * (1-Discount)), SUM(Quantity), Customers.CompanyName, FirstName, LastName
FROM [Order Details]
JOIN Orders
ON [Order Details].OrderID = Orders.OrderID
JOIN Customers
ON Orders.CustomerID = Customers.CustomerID
JOIN Employees
ON Orders.EmployeeID = Employees.EmployeeID
GROUP BY [Order Details].OrderID, Customers.CompanyName, FirstName, LastName
HAVING SUM(Quantity) > 250;

--Dla ka¿dej kategorii produktu (nazwa), podaj ³¹czn¹ liczbê zamówionych przez klientów jednostek towarów z tek kategorii.
SELECT CategoryName, SUM(Quantity)
FROM Categories
JOIN Products
ON Categories.CategoryID = Products.CategoryID
JOIN [Order Details] OD
ON Products.ProductID = OD.ProductID
GROUP BY CategoryName;

--Dla ka¿dej kategorii produktu (nazwa), podaj ³¹czn¹ wartoœæ zamówionych przez klientów jednostek towarów z tek kategorii
SELECT CategoryName, SUM(Quantity * OD.UnitPrice * (1-Discount))
FROM Categories
JOIN Products
ON Categories.CategoryID = Products.CategoryID
JOIN [Order Details] OD
ON Products.ProductID = OD.ProductID
GROUP BY CategoryName;

--Posortuj wyniki w zapytaniu z poprzedniego punktu wg:
--a) ³¹cznej wartoœci zamówieñ
SELECT CategoryName, SUM(Quantity * OD.UnitPrice * (1-Discount))
FROM Categories
JOIN Products
ON Categories.CategoryID = Products.CategoryID
JOIN [Order Details] OD
ON Products.ProductID = OD.ProductID
GROUP BY CategoryName
ORDER BY SUM(Quantity * OD.UnitPrice * (1-Discount));

--b) ³¹cznej liczby zamówionych przez klientów jednostek towarów
SELECT CategoryName, SUM(Quantity * OD.UnitPrice * (1-Discount))
FROM Categories
JOIN Products
ON Categories.CategoryID = Products.CategoryID
JOIN [Order Details] OD
ON Products.ProductID = OD.ProductID
GROUP BY CategoryName
ORDER BY SUM(Quantity);

-- Dla ka¿dego zamówienia podaj jego wartoœæ uwzglêdniaj¹c op³atê za przesy³kê
SELECT OD.OrderID, SUM(Quantity*UnitPrice*(1-Discount)), SUM(Quantity*UnitPrice*(1-Discount)) + Freight
FROM [Order Details] OD
JOIN Orders
ON OD.OrderID = Orders.OrderID
GROUP BY OD.OrderID, Freight;

--Dla ka¿dego przewoŸnika (nazwa) podaj liczbê zamówieñ które przewieŸli w 1997r
SELECT CompanyName, COUNT(*)
FROM Shippers
JOIN Orders
ON Shippers.ShipperID = Orders.ShipVia
AND YEAR(ShippedDate) = 1997
GROUP BY CompanyName;

--Który z przewoŸników by³ najaktywniejszy (przewióz³ najwiêksz¹ liczbê zamówieñ) w 1997r, podaj nazwê tego przewoŸnika
SELECT TOP 1 CompanyName, COUNT(*)
FROM Shippers
JOIN Orders
ON Shippers.ShipperID = Orders.ShipVia
AND YEAR(ShippedDate) = 1997
GROUP BY CompanyName
ORDER BY 2 DESC;

--Dla ka¿dego pracownika (imiê i nazwisko) podaj ³¹czn¹ wartoœæ zamówieñ obs³u¿onych przez tego pracownika
SELECT FirstName, LastName, SUM(Quantity * UnitPrice * (1-Discount))
FROM Employees E
JOIN Orders O
ON E.EmployeeID = O.EmployeeID
JOIN [Order Details] OD
ON O.OrderID = OD.OrderID
GROUP BY FirstName, LastName;

--Który z pracowników obs³u¿y³ najwiêksz¹ liczbê zamówieñ w 1997r, podaj imiê i nazwisko takiego pracownika
SELECT TOP 1 FirstName, LastName, COUNT(*)
FROM Employees E
JOIN Orders O
ON E.EmployeeID = O.EmployeeID
JOIN [Order Details] OD
ON O.OrderID = OD.OrderID
AND YEAR(RequiredDate) = 1997
GROUP BY FirstName, LastName
ORDER BY 3 DESC;

--Który z pracowników obs³u¿y³ najaktywniejszy (obs³u¿y³ zamówienia o najwiêkszej wartoœci) w 1997r, podaj imiê i nazwisko takiego pracownika
SELECT TOP 1 FirstName, LastName, SUM(Quantity*UnitPrice*(1-Discount))
FROM Employees E
JOIN Orders O
ON E.EmployeeID = O.EmployeeID
JOIN [Order Details] OD
ON O.OrderID = OD.OrderID
AND YEAR(RequiredDate) = 1997
GROUP BY FirstName, LastName
ORDER BY 3 DESC;

--Dla ka¿dego pracownika (imiê i nazwisko) podaj ³¹czn¹ wartoœæ zamówieñ obs³u¿onych przez tego pracownika – Ogranicz wynik tylko do pracowników
--a) którzy maj¹ podw³adnych
SELECT E.FirstName, E.LastName, SUM(Quantity*UnitPrice*(1-Discount))
FROM Employees E
JOIN Orders O
ON E.EmployeeID = O.EmployeeID
JOIN [Order Details] OD
ON O.OrderID = OD.OrderID
JOIN Employees E1
ON E.ReportsTo = E1.EmployeeID
AND E.ReportsTo IS NOT NULL
GROUP BY E.FirstName, E.LastName;

--b) którzy nie maj¹ podw³adnyc
SELECT E.FirstName, E.LastName, SUM(Quantity*UnitPrice*(1-Discount))
FROM Employees E
JOIN Orders O
ON E.EmployeeID = O.EmployeeID
JOIN [Order Details] OD
ON O.OrderID = OD.OrderID
JOIN Employees E1
ON E.ReportsTo = E1.EmployeeID
AND E.ReportsTo IS NULL
GROUP BY E.FirstName, E.LastName;