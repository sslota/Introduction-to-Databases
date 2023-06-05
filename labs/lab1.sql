USE northwind;

--Wybierz nazwy i adresy wszystkich klient�w
SELECT CompanyName, Address
FROM Customers;

--Wybierz nazwiska i numery telefon�w pracownik�w
SELECT LastName, HomePhone
FROM Employees;

--Wybierz nazwy i ceny produkt�w
SELECT ProductName, UnitPrice
FROM Products;

--Poka� nazwy i opisy wszystkich kategorii produkt�w
SELECT CategoryName, Description
FROM Categories;

--Poka� nazwy i adresy stron www dostawc�w
SELECT CompanyName, HomePage
FROM Suppliers;

--Wybierz nazwy i adresy wszystkich klient�w maj�cych siedziby w Londynie
SELECT CompanyName, Address
FROM Customers
WHERE City = 'London';

--Wybierz nazwy i adresy wszystkich klient�w maj�cych siedziby we Francji lub w Hiszpanii
SELECT CompanyName, Address
FROM Customers
WHERE Country = 'France' or Country = 'Spain';

--Wybierz nazwy i ceny produkt�w o cenie jednostkowej pomi�dzy 20 a 30
SELECT ProductName, UnitPrice
FROM Products
WHERE UnitPrice BETWEEN 20 AND 30;

--Wybierz nazwy i ceny produkt�w z kategorii �meat�
SELECT ProductName, UnitPrice
FROM Products
WHERE CategoryID = 6;

--Wybierz nazwy produkt�w oraz inf. o stanie magazynu dla produkt�w dostarczanych przez firm� �Tokyo Traders�
SELECT ProductName, UnitsInStock
FROM Products
WHERE SupplierID = 4;

-- Wybierz nazwy produkt�w kt�rych nie ma w magazynie
SELECT ProductName
FROM Products
WHERE UnitsInStock = 0;

-- Szukamy informacji o produktach sprzedawanych w butelkach (�bottle�)
SELECT *
FROM Products
WHERE QuantityPerUnit LIKE '%bottle%';

--Wyszukaj informacje o stanowisku pracownik�w, kt�rych nazwiska zaczynaj� si� na liter� z zakresu od B do L
SELECT Title
FROM Employees
WHERE LastName LIKE '[B-L]%';

--Wyszukaj informacje o stanowisku pracownik�w, kt�rych nazwiska zaczynaj� si� na liter� B lub L
SELECT Title
FROM Employees
WHERE LastName LIKE '[BL]%';

--Znajd� nazwy kategorii, kt�re w opisie zawieraj� przecinek
SELECT CategoryName
FROM Categories
WHERE Description LIKE '%,%';

--Znajd� klient�w, kt�rzy w swojej nazwie maj� w kt�rym� miejscu s�owo �Store�
SELECT CompanyName
FROM Customers
WHERE CompanyName LIKE '%Store%';

-- Szukamy informacji o produktach o cenach mniejszych ni� 10 lub wi�kszych ni� 20
SELECT *
FROM Products
--WHERE UnitPrice NOT BETWEEN 10 and 20;
WHERE UnitPrice < 10 or UnitPrice > 20;

--Wybierz nazwy i ceny produkt�w o cenie jednostkowej pomi�dzy 20.00 a 30.00
SELECT ProductName, UnitPrice
FROM Products
--WHERE UnitPrice BETWEEN 20 and 30;
WHERE UnitPrice > 20 and UnitPrice < 30;

--Wybierz nazwy i kraje wszystkich klient�w maj�cych siedziby w Japonii (Japan) lub we W�oszech (Italy)
SELECT CompanyName, Country
FROM Customers
WHERE Country IN ('Japan', 'Italy');

--Napisz instrukcj� select tak aby wybra� numer zlecenia, dat� zam�wienia, numer klienta dla wszystkich niezrealizowanych jeszcze zlece�, dla kt�rych krajem odbiorcy jest Argentyna
SELECT OrderID, OrderDate, CustomerID
FROM Orders
WHERE ShipCountry = 'Argentina'
AND ShippedDate IS NULL OR ShippedDate > GETDATE();

--Wybierz nazwy i kraje wszystkich klient�w, wyniki posortuj wed�ug kraju, w ramach danego kraju nazwy firm posortuj alfabetycznie
SELECT CompanyName, Country
FROM Customers
ORDER BY Country, CompanyName;

--Wybierz informacj� o produktach (grupa, nazwa, cena), produkty posortuj wg grup a w grupach malej�co wg ceny
SELECT ProductName, UnitPrice, CategoryID
FROM Products
ORDER BY CategoryID, UnitPrice DESC;

--Wybierz nazwy i kraje wszystkich klient�w maj�cych siedziby w Wielkiej Brytanii (UK) lub we W�oszech (Italy), wyniki posortuj tak jak w pkt 1
SELECT CompanyName, Country
FROM Customers
WHERE Country IN ('UK', 'Italy')
ORDER BY Country, CompanyName;

USE library

--Napisz polecenie select, za pomoc� kt�rego uzyskasz tytu� i numer ksi��ki
SELECT title, title_no
FROM title;

--Napisz polecenie, kt�re wybiera tytu� o numerze 10
SELECT title
FROM title
WHERE title_no = 10;

--Napisz polecenie, kt�re wybiera numer czytelnika i kar� dla tych czytelnik�w, kt�rzy maj� kary mi�dzy $8 a $9
SELECT member_no, fine_assessed
FROM loanhist
WHERE fine_assessed BETWEEN 8 and 9;

--Napisz polecenie select, za pomoc� kt�rego uzyskasz numer ksi��ki i autora dla wszystkich ksi��ek, kt�rych autorem jest Charles Dickens lub Jane Austen
SELECT title_no, author
FROM title
WHERE Author IN ('Charles Dickens', 'Jane Austen');

--Napisz polecenie, kt�re wybiera numer tytu�u i tytu� dla wszystkich rekord�w zawieraj�cych string �adventures� gdzie� w tytule
SELECT title_no, title
FROM title
WHERE title LIKE '%adventures%';

--Napisz polecenie, kt�re wybiera numer czytelnika, kar� oraz zap�acon� kar� dla wszystkich, kt�rzy jeszcze nie zap�acili
SELECT member_no, fine_assessed, fine_paid, fine_waived
FROM loanhist
WHERE ISNULL(fine_assessed, 0) - ISNULL(fine_waived, 0) > ISNULL(fine_paid, 0);

--Napisz polecenie, kt�re wybiera wszystkie unikalne pary miast i stan�w z tablicy adult
SELECT DISTINCT city, state
FROM adult;

--Napisz polecenie, kt�re wybiera wszystkie tytu�y z tablicy title i wy�wietla je w porz�dku alfabetycznym
SELECT title
FROM title
ORDER BY title;

--Napisz polecenie, kt�re: wybiera numer cz�onka biblioteki, isbn ksi��ki i warto�� naliczonej kary dla wszystkich wypo�ycze�, 
--dla kt�rych naliczono kar� stw�rz kolumn� wyliczeniow� zawieraj�c� podwojon� warto�� kolumny fine_assessed stw�rz alias �double fine� dla tej kolumny
SELECT member_no, isbn, fine_assessed, fine_assessed*2 as 'double fine'
FROM loanhist
WHERE fine_assessed IS NOT NULL
AND fine_assessed > 0;

--Napisz polecenie, kt�re generuje pojedyncz� kolumn�, kt�ra zawiera kolumny: imi� cz�onka biblioteki, inicja� drugiego imienia i nazwisko dla
--wszystkich cz�onk�w biblioteki, kt�rzy nazywaj� si� Anderson nazwij tak powsta�� kolumn� �email_name� 
--zmodyfikuj polecenie, tak by zwr�ci�o �list� proponowanych login�w e-mail� utworzonych przez po��czenie imienia cz�onka biblioteki, 
--z inicja�em drugiego imienia i pierwszymi dwoma literami nazwiska (wszystko ma�ymi literami). wykorzystaj funkcj� SUBSTRING do uzyskania cz�ci kolumny
--znakowej oraz LOWER do zwr�cenia wyniku ma�ymi literami wykorzystaj operator (+) do po��czenia string�w
SELECT LOWER(CONCAT(firstname, middleinitial, SUBSTRING(lastname, 1, 2))) AS email_name
FROM member
WHERE lastname = 'Anderson';

--Napisz polecenie, kt�re wybiera title i title_no z tablicy title. Wynikiem powinna by� pojedyncza kolumna o formacie jak w przyk�adzie poni�ej:
--The title is: Poems, title number 7
--Czyli zapytanie powinno zwraca� pojedyncz� kolumn� w oparciu o wyra�enie, kt�re ��czy 4 elementy:
--sta�a znakowa �The title is:� warto�� kolumny title sta�a znakowa �title number� warto�� kolumny title_no
SELECT CONCAT('The title is: ', title, ', title number ', title_no)
FROM title;