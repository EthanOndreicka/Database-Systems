-- 1 --
SELECT city, COUNT(DISTINCT prodId) AS num_products,
       RANK() OVER (ORDER BY COUNT(DISTINCT prodId) DESC) AS city_rank
FROM Products
GROUP BY city;

-- 2 --
SELECT name
FROM Products
WHERE priceUSD < (0.01 * (SELECT AVG(priceUSD) FROM Products))
ORDER BY name ASC;

-- 3 --
SELECT p.lastName AS customer_last_name, 
       o.prodId AS product_id_ordered, 
       SUM(o.totalUSD) AS totalUSD
FROM Orders o
JOIN People p ON o.custId = p.pid
WHERE EXTRACT(MONTH FROM o.dateOrdered) = 3
GROUP BY p.lastName, o.prodId
ORDER BY totalUSD ASC;

-- 4 --
SELECT lastName, COALESCE(SUM(totalUSD), 0) AS total_ordered
FROM People p
LEFT JOIN Orders o ON p.pid = o.custId
GROUP BY lastName
ORDER BY lastName DESC;

-- 5 --
SELECT pc.lastName AS customer_name, 
	   pr.name AS product_name, 
	   pa.firstName AS agent_first_name, 
	   pa.lastName AS agent_last_name
FROM People pc
JOIN Orders o ON pc.pid = o.custId
JOIN People pa ON o.agentId = pa.pid
JOIN Products pr ON o.prodId = pr.prodid
WHERE pa.homeCity = 'Chilliwack';

-- 6 -- 
SELECT *
FROM Orders o
INNER JOIN Customers c ON o.custId = c.pid
WHERE ROUND(( SELECT SUM(quantityOrdered * priceUSD * (1 - (c.discountPct / 100)))
              FROM Products
              WHERE prodId = o.prodId), 2) != o.totalUSD;


-- 7 --
SELECT p.firstName, p.lastName
FROM People p
INNER JOIN Agents a ON p.pid = a.pid;

-- 8 --
-- View of all Customer and People data called PeopleCustomers --
CREATE VIEW PeopleCustomers AS
SELECT *
FROM People
WHERE pid IN (SELECT pid FROM Customers);

-- View of all Agent and People data called PeopleAgents --
CREATE VIEW PeopleAgents AS
SELECT *
FROM People
WHERE pid IN (SELECT pid FROM Agents);

-- PeopleCustomers View --
SELECT * FROM PeopleCustomers;

-- Test the PeopleAgents View --
SELECT * FROM PeopleAgents;

-- 9 --
SELECT pc.firstName, pc.lastName
FROM PeopleCustomers pc
JOIN PeopleAgents pa ON pc.pid = pa.pid;

-- 10 --
/*
In queries #7 and #9, the output displays the first and last names of all customers who are also agents,
however #7 doesn't use views while #9 does. #7 directly joins the People table twice, once for customers 
and once for agents, while query #9 uses the views created for customers and agents. The database server gets
the data from the PeopleCustomers view and the PeopleAgents view, does an inner join between these two views on
the pid column to find the intersection of customers who are also agents and finally selects the first and last names.
*/

-- 11 --
/*
In a left outer join,  all records from the left table are included in the result set, if there are any matching records
in the right table, they are included as well. If there are no matching record in the right table, null values are put in the 
result set for columns from the right table.
EX:
SELECT *
FROM People p
LEFT OUTER JOIN Orders o ON p.pid = o.custId;


In a right outer join, all records from the right table are included in the result set, if there are any matching records
in the left table, they are included as well. If there are no matching record in the left table, null values are put in the 
result set for columns from the right table.
EX:
SELECT *
FROM People p
RIGHT OUTER JOIN Orders o ON p.pid = o.custId;

*/