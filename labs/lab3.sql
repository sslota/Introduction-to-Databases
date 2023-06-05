USE Northwind

--Wybierz nazwy i ceny produkt�w (baza northwind) o cenie jednostkowej pomi�dzy 20.00 a 30.00, dla ka�dego produktu podaj dane adresowe dostawcy
SELECT ProductName, UnitPrice, Suppliers.CompanyName
FROM Suppliers
JOIN Products
ON Suppliers.SupplierID = Products.SupplierID
WHERE UnitPrice BETWEEN 20 AND 30;

--Wybierz nazwy produkt�w oraz inf. o stanie magazynu dla produkt�w dostarczanych przez firm� �Tokyo Traders�
SELECT ProductName, UnitsInStock
FROM Products
JOIN Suppliers
ON Products.SupplierID=Suppliers.SupplierID
WHERE CompanyName = 'Tokyo Traders';

--Czy s� jacy� klienci kt�rzy nie z�o�yli �adnego zam�wienia w 1997 roku, je�li tak to poka� ich dane adresowe
SELECT CompanyName, Address
FROM Customers
JOIN Orders
ON Customers.CustomerID = Orders.CustomerID 
AND YEAR(OrderDate) = 1997
WHERE OrderDate IS NULL;

--Wybierz nazwy i numery telefon�w dostawc�w, dostarczaj�cych produkty, kt�rych aktualnie nie ma w magazynie
SELECT CompanyName, Phone
FROM Suppliers
JOIN Products
ON Suppliers.SupplierID = Products.SupplierID
WHERE UnitsInStock = 0;

USE library

--Napisz polecenie, kt�re wy�wietla list� dzieci b�d�cych cz�onkami biblioteki (baza library). Interesuje nas imi�, nazwisko i data urodzenia dziecka
SELECT firstname, lastname, juvenile.birth_date
FROM member
JOIN juvenile
ON member.member_no = juvenile.member_no;

--Napisz polecenie, kt�re podaje tytu�y aktualnie wypo�yczonych ksi��ek
SELECT title
FROM title
JOIN loanhist
ON title.title_no = loanhist.title_no
WHERE out_date IS NOT NULL
AND in_date IS NULL;

--Podaj informacje o karach zap�aconych za przetrzymywanie ksi��ki o tytule �Tao Teh King�. Interesuje nas data oddania ksi��ki, ile dni by�a przetrzymywana i jak� zap�acono kar�
SELECT fine_paid, in_date, DATEDIFF(Day, in_date, loan.due_date)
FROM loanhist
JOIN title
ON loanhist.title_no = title.title_no
JOIN loan
ON title.title_no = loan.title_no
WHERE title = 'Tao Teh King' 
AND fine_paid IS NOT NULL;

--Napisz polecenie kt�re podaje list� ksi��ek (mumery ISBN) zarezerwowanych przez osob� o nazwisku: Stephen A. Graff
SELECT isbn
FROM loan
JOIN member
ON loan.member_no = member.member_no
WHERE firstname = 'Stephen'
AND middleinitial = 'A'
AND lastname = 'Graff';

USE Northwind

--Wybierz nazwy i ceny produkt�w (baza northwind) o cenie jednostkowej pomi�dzy 20.00 a 30.00, dla ka�dego produktu podaj dane adresowe dostawcy, interesuj� nas tylko produkty z kategorii �Meat/Poultry�
SELECT ProductName, UnitPrice, Address
FROM Products
JOIN Suppliers
ON Products.SupplierID = Suppliers.SupplierID
JOIN Categories
ON Products.CategoryID = Categories.CategoryID
WHERE UnitPrice BETWEEN 20 AND 30
AND CategoryName = 'Meat/Poultry';

--Wybierz nazwy i ceny produkt�w z kategorii �Confections� dla ka�dego produktu podaj nazw� dostawcy
SELECT ProductName, UnitPrice, Address
FROM Products
JOIN Suppliers
ON Products.SupplierID = Suppliers.SupplierID
JOIN Categories
ON Products.CategoryID = Categories.CategoryID
WHERE CategoryName = 'Confections';

--Wybierz nazwy i numery telefon�w klient�w , kt�rym w 1997 roku przesy�ki dostarcza�a firma �United Package�
SELECT Customers.CompanyName, Customers.Phone
FROM Customers
JOIN Orders
ON Customers.CustomerID = Orders.CustomerID
JOIN Shippers
ON Orders.ShipVia = Shippers.ShipperID
WHERE YEAR(ShippedDate) = 1997
AND Shippers.CompanyName = 'United Package';

--Wybierz nazwy i numery telefon�w klient�w, kt�rzy kupowali produkty z kategorii �Confections'
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

--Napisz polecenie, kt�re wy�wietla list� dzieci b�d�cych cz�onkami biblioteki (baza library). Interesuje nas imi�, nazwisko, data urodzenia dziecka i adres zamieszkania dziecka
SELECT firstname, lastname, juvenile.birth_date, adult.street
FROM member
JOIN juvenile
ON member.member_no = juvenile.member_no
JOIN adult
ON juvenile.adult_member_no = adult.member_no;

--Napisz polecenie, kt�re wy�wietla list� dzieci b�d�cych cz�onkami biblioteki (baza library). Interesuje nas imi�, nazwisko, data urodzenia dziecka, adres zamieszkania dziecka oraz imi� i nazwisko rodzica
SELECT member.firstname, member.lastname, juvenile.birth_date, adult.street, parent.firstname, parent.lastname
FROM member
JOIN juvenile
ON member.member_no = juvenile.member_no
JOIN adult
ON juvenile.adult_member_no = adult.member_no
JOIN member parent
ON juvenile.adult_member_no = parent.member_no;

USE Northwind

--Napisz polecenie, kt�re wy�wietla pracownik�w oraz ich podw�adnych (baza northwind)
SELECT A.Firstname, A.Lastname, B.FirstName, B.LastName
FROM Employees A
JOIN Employees B
ON A.ReportsTo = B.EmployeeID
WHERE A.ReportsTo IS NOT NULL;

--Napisz polecenie, kt�re wy�wietla pracownik�w, kt�rzy nie maj� podw�adnych (baza northwind)
SELECT A.Firstname, A.Lastname
FROM Employees A
JOIN Employees B
ON A.EmployeeID = B.ReportsTo
WHERE A.ReportsTo IS NULL
GROUP BY A.Firstname, A.Lastname;

USE library

--Napisz polecenie, kt�re wy�wietla adresy cz�onk�w biblioteki, kt�rzy maj� dzieci urodzone przed 1 stycznia 1996
SELECT street, adult.member_no
FROM adult
JOIN juvenile
ON adult.member_no = juvenile.adult_member_no
WHERE YEAR(juvenile.birth_date) < 1996;

--Napisz polecenie, kt�re wy�wietla adresy cz�onk�w biblioteki, kt�rzy maj� dzieci urodzone przed 1 stycznia 1996. Interesuj� nas tylko adresy takich cz�onk�w biblioteki, kt�rzy aktualnie nie przetrzymuj� ksi��ek.
SELECT street, adult.member_no
FROM adult
JOIN juvenile
ON adult.member_no = juvenile.adult_member_no
JOIN loan
ON adult.member_no = loan.member_no
WHERE YEAR(juvenile.birth_date) < 1996
AND out_date IS NULL;

--Napisz polecenie kt�re zwraca imi� i nazwisko (jako pojedyncz� kolumn� � name), oraz informacje o adresie: ulica, miasto, stan kod (jako pojedyncz�  kolumn� � address) dla wszystkich doros�ych cz�onk�w biblioteki
SELECT (firstname + ' ' + lastname) AS 'name', (street + ', ' + city + ', ' + state + ', ' + zip) AS 'address'
FROM member 
JOIN adult
ON member.member_no = adult.member_no;

--Napisz polecenie, kt�re zwraca: isbn, copy_no, on_loan, title, translation, cover, dla ksi��ek o isbn 1, 500 i 1000. Wynik posortuj wg ISBN
SELECT copy.isbn, copy_no, on_loan, title, translation, cover
FROM copy
JOIN item
ON copy.isbn = item.isbn
JOIN title
ON copy.title_no = title.title_no
WHERE copy.isbn IN (1, 500, 1000)
ORDER BY 1 DESC;

--Napisz polecenie kt�re zwraca informacje o u�ytkownikach biblioteki o nr 250, 342, i 1675 (dla ka�dego u�ytkownika: nr, imi� i nazwisko cz�onka biblioteki), oraz informacj� o zarezerwowanych ksi��kach (isbn, data)
SELECT member.member_no, firstname, lastname, isbn, log_date
FROM member
JOIN reservation
ON member.member_no = reservation.member_no
WHERE member.member_no IN (250, 342, 1675);

--Podaj list� cz�onk�w biblioteki mieszkaj�cych w Arizonie (AZ) maj� wi�cej ni� dwoje dzieci zapisanych do biblioteki 
SELECT firstname, lastname, state, COUNT(juvenile.member_no)
FROM member
JOIN juvenile 
ON juvenile.adult_member_no = member.member_no
JOIN adult 
ON member.member_no = adult.member_no
WHERE adult.State = 'AZ'
GROUP BY member.member_no, firstname, lastname, state
HAVING COUNT(juvenile.member_no) > 2

-- Podaj list� cz�onk�w biblioteki mieszkaj�cych w Arizonie (AZ) kt�rzy maj� wi�cej ni� dwoje dzieci zapisanych do biblioteki oraz takich kt�rzy mieszkaj� w Kaliforni(CA) i maj� wi�cej ni� troje dzieci zapisanych do bibliotek
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

--Dla ka�dego zam�wienia podaj ��czn� liczb� zam�wionych jednostek towaru oraz nazw� klienta
SELECT [Order Details].OrderID, SUM(Quantity), Customers.CompanyName
FROM [Order Details]
JOIN Orders
ON [Order Details].OrderID = Orders.OrderID
JOIN Customers
ON Orders.CustomerID = Customers.CustomerID
GROUP BY [Order Details].OrderID, Customers.CompanyName;

--Zmodyfikuj poprzedni przyk�ad, aby pokaza� tylko takie zam�wienia, dla kt�rych ��czna liczb� zam�wionych jednostek jest wi�ksza ni� 250
SELECT [Order Details].OrderID, SUM(Quantity), Customers.CompanyName
FROM [Order Details]
JOIN Orders
ON [Order Details].OrderID = Orders.OrderID
JOIN Customers
ON Orders.CustomerID = Customers.CustomerID
GROUP BY [Order Details].OrderID, Customers.CompanyName
HAVING SUM(Quantity) > 250;

--Dla ka�dego zam�wienia podaj ��czn� warto�� tego zam�wienia oraz nazw� klienta
SELECT [Order Details].OrderID, SUM(UnitPrice * Quantity * (1-Discount)), Customers.CompanyName
FROM [Order Details]
JOIN Orders
ON [Order Details].OrderID = Orders.OrderID
JOIN Customers
ON Orders.CustomerID = Customers.CustomerID
GROUP BY [Order Details].OrderID, Customers.CompanyName;

--Zmodyfikuj poprzedni przyk�ad, aby pokaza� tylko takie zam�wienia, dla kt�rych ��czna liczba jednostek jest wi�ksza ni� 250
SELECT [Order Details].OrderID, SUM(UnitPrice * Quantity * (1-Discount)), SUM(Quantity), Customers.CompanyName
FROM [Order Details]
JOIN Orders
ON [Order Details].OrderID = Orders.OrderID
JOIN Customers
ON Orders.CustomerID = Customers.CustomerID
GROUP BY [Order Details].OrderID, Customers.CompanyName
HAVING SUM(Quantity) > 250;

--Zmodyfikuj poprzedni przyk�ad tak �eby doda� jeszcze imi� i nazwisko pracownika obs�uguj�cego zam�wienie
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

--Dla ka�dej kategorii produktu (nazwa), podaj ��czn� liczb� zam�wionych przez klient�w jednostek towar�w z tek kategorii.
SELECT CategoryName, SUM(Quantity)
FROM Categories
JOIN Products
ON Categories.CategoryID = Products.CategoryID
JOIN [Order Details] OD
ON Products.ProductID = OD.ProductID
GROUP BY CategoryName;

--Dla ka�dej kategorii produktu (nazwa), podaj ��czn� warto�� zam�wionych przez klient�w jednostek towar�w z tek kategorii
SELECT CategoryName, SUM(Quantity * OD.UnitPrice * (1-Discount))
FROM Categories
JOIN Products
ON Categories.CategoryID = Products.CategoryID
JOIN [Order Details] OD
ON Products.ProductID = OD.ProductID
GROUP BY CategoryName;

--Posortuj wyniki w zapytaniu z poprzedniego punktu wg:
--a) ��cznej warto�ci zam�wie�
SELECT CategoryName, SUM(Quantity * OD.UnitPrice * (1-Discount))
FROM Categories
JOIN Products
ON Categories.CategoryID = Products.CategoryID
JOIN [Order Details] OD
ON Products.ProductID = OD.ProductID
GROUP BY CategoryName
ORDER BY SUM(Quantity * OD.UnitPrice * (1-Discount));

--b) ��cznej liczby zam�wionych przez klient�w jednostek towar�w
SELECT CategoryName, SUM(Quantity * OD.UnitPrice * (1-Discount))
FROM Categories
JOIN Products
ON Categories.CategoryID = Products.CategoryID
JOIN [Order Details] OD
ON Products.ProductID = OD.ProductID
GROUP BY CategoryName
ORDER BY SUM(Quantity);

-- Dla ka�dego zam�wienia podaj jego warto�� uwzgl�dniaj�c op�at� za przesy�k�
SELECT OD.OrderID, SUM(Quantity*UnitPrice*(1-Discount)), SUM(Quantity*UnitPrice*(1-Discount)) + Freight
FROM [Order Details] OD
JOIN Orders
ON OD.OrderID = Orders.OrderID
GROUP BY OD.OrderID, Freight;

--Dla ka�dego przewo�nika (nazwa) podaj liczb� zam�wie� kt�re przewie�li w 1997r
SELECT CompanyName, COUNT(*)
FROM Shippers
JOIN Orders
ON Shippers.ShipperID = Orders.ShipVia
AND YEAR(ShippedDate) = 1997
GROUP BY CompanyName;

--Kt�ry z przewo�nik�w by� najaktywniejszy (przewi�z� najwi�ksz� liczb� zam�wie�) w 1997r, podaj nazw� tego przewo�nika
SELECT TOP 1 CompanyName, COUNT(*)
FROM Shippers
JOIN Orders
ON Shippers.ShipperID = Orders.ShipVia
AND YEAR(ShippedDate) = 1997
GROUP BY CompanyName
ORDER BY 2 DESC;

--Dla ka�dego pracownika (imi� i nazwisko) podaj ��czn� warto�� zam�wie� obs�u�onych przez tego pracownika
SELECT FirstName, LastName, SUM(Quantity * UnitPrice * (1-Discount))
FROM Employees E
JOIN Orders O
ON E.EmployeeID = O.EmployeeID
JOIN [Order Details] OD
ON O.OrderID = OD.OrderID
GROUP BY FirstName, LastName;

--Kt�ry z pracownik�w obs�u�y� najwi�ksz� liczb� zam�wie� w 1997r, podaj imi� i nazwisko takiego pracownika
SELECT TOP 1 FirstName, LastName, COUNT(*)
FROM Employees E
JOIN Orders O
ON E.EmployeeID = O.EmployeeID
JOIN [Order Details] OD
ON O.OrderID = OD.OrderID
AND YEAR(RequiredDate) = 1997
GROUP BY FirstName, LastName
ORDER BY 3 DESC;

--Kt�ry z pracownik�w obs�u�y� najaktywniejszy (obs�u�y� zam�wienia o najwi�kszej warto�ci) w 1997r, podaj imi� i nazwisko takiego pracownika
SELECT TOP 1 FirstName, LastName, SUM(Quantity*UnitPrice*(1-Discount))
FROM Employees E
JOIN Orders O
ON E.EmployeeID = O.EmployeeID
JOIN [Order Details] OD
ON O.OrderID = OD.OrderID
AND YEAR(RequiredDate) = 1997
GROUP BY FirstName, LastName
ORDER BY 3 DESC;

--Dla ka�dego pracownika (imi� i nazwisko) podaj ��czn� warto�� zam�wie� obs�u�onych przez tego pracownika � Ogranicz wynik tylko do pracownik�w
--a) kt�rzy maj� podw�adnych
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

--b) kt�rzy nie maj� podw�adnyc
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