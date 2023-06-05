USE northwind;

--Wybierz nazwy i adresy wszystkich klientów
SELECT CompanyName, Address
FROM Customers;

--Wybierz nazwiska i numery telefonów pracowników
SELECT LastName, HomePhone
FROM Employees;

--Wybierz nazwy i ceny produktów
SELECT ProductName, UnitPrice
FROM Products;

--Poka¿ nazwy i opisy wszystkich kategorii produktów
SELECT CategoryName, Description
FROM Categories;

--Poka¿ nazwy i adresy stron www dostawców
SELECT CompanyName, HomePage
FROM Suppliers;

--Wybierz nazwy i adresy wszystkich klientów maj¹cych siedziby w Londynie
SELECT CompanyName, Address
FROM Customers
WHERE City = 'London';

--Wybierz nazwy i adresy wszystkich klientów maj¹cych siedziby we Francji lub w Hiszpanii
SELECT CompanyName, Address
FROM Customers
WHERE Country = 'France' or Country = 'Spain';

--Wybierz nazwy i ceny produktów o cenie jednostkowej pomiêdzy 20 a 30
SELECT ProductName, UnitPrice
FROM Products
WHERE UnitPrice BETWEEN 20 AND 30;

--Wybierz nazwy i ceny produktów z kategorii ‘meat’
SELECT ProductName, UnitPrice
FROM Products
WHERE CategoryID = 6;

--Wybierz nazwy produktów oraz inf. o stanie magazynu dla produktów dostarczanych przez firmê ‘Tokyo Traders’
SELECT ProductName, UnitsInStock
FROM Products
WHERE SupplierID = 4;

-- Wybierz nazwy produktów których nie ma w magazynie
SELECT ProductName
FROM Products
WHERE UnitsInStock = 0;

-- Szukamy informacji o produktach sprzedawanych w butelkach (‘bottle’)
SELECT *
FROM Products
WHERE QuantityPerUnit LIKE '%bottle%';

--Wyszukaj informacje o stanowisku pracowników, których nazwiska zaczynaj¹ siê na literê z zakresu od B do L
SELECT Title
FROM Employees
WHERE LastName LIKE '[B-L]%';

--Wyszukaj informacje o stanowisku pracowników, których nazwiska zaczynaj¹ siê na literê B lub L
SELECT Title
FROM Employees
WHERE LastName LIKE '[BL]%';

--ZnajdŸ nazwy kategorii, które w opisie zawieraj¹ przecinek
SELECT CategoryName
FROM Categories
WHERE Description LIKE '%,%';

--ZnajdŸ klientów, którzy w swojej nazwie maj¹ w którymœ miejscu s³owo ‘Store’
SELECT CompanyName
FROM Customers
WHERE CompanyName LIKE '%Store%';

-- Szukamy informacji o produktach o cenach mniejszych ni¿ 10 lub wiêkszych ni¿ 20
SELECT *
FROM Products
--WHERE UnitPrice NOT BETWEEN 10 and 20;
WHERE UnitPrice < 10 or UnitPrice > 20;

--Wybierz nazwy i ceny produktów o cenie jednostkowej pomiêdzy 20.00 a 30.00
SELECT ProductName, UnitPrice
FROM Products
--WHERE UnitPrice BETWEEN 20 and 30;
WHERE UnitPrice > 20 and UnitPrice < 30;

--Wybierz nazwy i kraje wszystkich klientów maj¹cych siedziby w Japonii (Japan) lub we W³oszech (Italy)
SELECT CompanyName, Country
FROM Customers
WHERE Country IN ('Japan', 'Italy');

--Napisz instrukcjê select tak aby wybraæ numer zlecenia, datê zamówienia, numer klienta dla wszystkich niezrealizowanych jeszcze zleceñ, dla których krajem odbiorcy jest Argentyna
SELECT OrderID, OrderDate, CustomerID
FROM Orders
WHERE ShipCountry = 'Argentina'
AND ShippedDate IS NULL OR ShippedDate > GETDATE();

--Wybierz nazwy i kraje wszystkich klientów, wyniki posortuj wed³ug kraju, w ramach danego kraju nazwy firm posortuj alfabetycznie
SELECT CompanyName, Country
FROM Customers
ORDER BY Country, CompanyName;

--Wybierz informacjê o produktach (grupa, nazwa, cena), produkty posortuj wg grup a w grupach malej¹co wg ceny
SELECT ProductName, UnitPrice, CategoryID
FROM Products
ORDER BY CategoryID, UnitPrice DESC;

--Wybierz nazwy i kraje wszystkich klientów maj¹cych siedziby w Wielkiej Brytanii (UK) lub we W³oszech (Italy), wyniki posortuj tak jak w pkt 1
SELECT CompanyName, Country
FROM Customers
WHERE Country IN ('UK', 'Italy')
ORDER BY Country, CompanyName;

USE library

--Napisz polecenie select, za pomoc¹ którego uzyskasz tytu³ i numer ksi¹¿ki
SELECT title, title_no
FROM title;

--Napisz polecenie, które wybiera tytu³ o numerze 10
SELECT title
FROM title
WHERE title_no = 10;

--Napisz polecenie, które wybiera numer czytelnika i karê dla tych czytelników, którzy maj¹ kary miêdzy $8 a $9
SELECT member_no, fine_assessed
FROM loanhist
WHERE fine_assessed BETWEEN 8 and 9;

--Napisz polecenie select, za pomoc¹ którego uzyskasz numer ksi¹¿ki i autora dla wszystkich ksi¹¿ek, których autorem jest Charles Dickens lub Jane Austen
SELECT title_no, author
FROM title
WHERE Author IN ('Charles Dickens', 'Jane Austen');

--Napisz polecenie, które wybiera numer tytu³u i tytu³ dla wszystkich rekordów zawieraj¹cych string „adventures” gdzieœ w tytule
SELECT title_no, title
FROM title
WHERE title LIKE '%adventures%';

--Napisz polecenie, które wybiera numer czytelnika, karê oraz zap³acon¹ karê dla wszystkich, którzy jeszcze nie zap³acili
SELECT member_no, fine_assessed, fine_paid, fine_waived
FROM loanhist
WHERE ISNULL(fine_assessed, 0) - ISNULL(fine_waived, 0) > ISNULL(fine_paid, 0);

--Napisz polecenie, które wybiera wszystkie unikalne pary miast i stanów z tablicy adult
SELECT DISTINCT city, state
FROM adult;

--Napisz polecenie, które wybiera wszystkie tytu³y z tablicy title i wyœwietla je w porz¹dku alfabetycznym
SELECT title
FROM title
ORDER BY title;

--Napisz polecenie, które: wybiera numer cz³onka biblioteki, isbn ksi¹¿ki i wartoœæ naliczonej kary dla wszystkich wypo¿yczeñ, 
--dla których naliczono karê stwórz kolumnê wyliczeniow¹ zawieraj¹c¹ podwojon¹ wartoœæ kolumny fine_assessed stwórz alias ‘double fine’ dla tej kolumny
SELECT member_no, isbn, fine_assessed, fine_assessed*2 as 'double fine'
FROM loanhist
WHERE fine_assessed IS NOT NULL
AND fine_assessed > 0;

--Napisz polecenie, które generuje pojedyncz¹ kolumnê, która zawiera kolumny: imiê cz³onka biblioteki, inicja³ drugiego imienia i nazwisko dla
--wszystkich cz³onków biblioteki, którzy nazywaj¹ siê Anderson nazwij tak powsta³¹ kolumnê „email_name” 
--zmodyfikuj polecenie, tak by zwróci³o „listê proponowanych loginów e-mail” utworzonych przez po³¹czenie imienia cz³onka biblioteki, 
--z inicja³em drugiego imienia i pierwszymi dwoma literami nazwiska (wszystko ma³ymi literami). wykorzystaj funkcjê SUBSTRING do uzyskania czêœci kolumny
--znakowej oraz LOWER do zwrócenia wyniku ma³ymi literami wykorzystaj operator (+) do po³¹czenia stringów
SELECT LOWER(CONCAT(firstname, middleinitial, SUBSTRING(lastname, 1, 2))) AS email_name
FROM member
WHERE lastname = 'Anderson';

--Napisz polecenie, które wybiera title i title_no z tablicy title. Wynikiem powinna byæ pojedyncza kolumna o formacie jak w przyk³adzie poni¿ej:
--The title is: Poems, title number 7
--Czyli zapytanie powinno zwracaæ pojedyncz¹ kolumnê w oparciu o wyra¿enie, które ³¹czy 4 elementy:
--sta³a znakowa ‘The title is:’ wartoœæ kolumny title sta³a znakowa ‘title number’ wartoœæ kolumny title_no
SELECT CONCAT('The title is: ', title, ', title number ', title_no)
FROM title;