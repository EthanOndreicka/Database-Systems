-- 1 --
SELECT orderNum, totalUSD
FROM Orders;

-- 2 --
SELECT lastName, homeCity
FROM People
WHERE prefix = 'Ms.';

-- 3 --
SELECT prodid, name, qtyOnHand
FROM Products
WHERE qtyOnHand > 1007;

-- 4 --
SELECT firstName, homeCity
FROM People
WHERE EXTRACT(YEAR FROM DOB) > 1919 
AND EXTRACT(YEAR FROM DOB) < 1930;


-- 5 --
SELECT prefix, lastName
FROM People
WHERE prefix != 'Mr.';

-- 6 --
SELECT *
FROM Products
WHERE city != 'Dallas' 
	AND city != 'Duluth' 
	AND priceUSD >= 18;

-- 7 --
SELECT *
FROM Orders
WHERE EXTRACT(MONTH FROM dateOrdered) = 1;

-- 8 --
SELECT *
FROM Orders
WHERE EXTRACT(MONTH FROM dateOrdered) = 2
AND totalUSD >23000.0;

-- 9 --
SELECT *
FROM Orders
WHERE custID = 007;

-- 10 --
SELECT *
FROM Orders
WHERE custID = 005;
