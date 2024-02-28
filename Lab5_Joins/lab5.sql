-- 1 --
SELECT *
FROM People p inner join Customers c on p.pid = c.pid;

-- 2 --
SELECT People.*
FROM People
JOIN Agents ON People.pid = Agents.pid;

-- 3 --
select *
from People p inner join Agents a on p.pid = a.pid
			  inner join Customers c on p.pid = c.pid;

-- 4 --
SELECT firstName
FROM People
WHERE pid IN (
    SELECT pid
    FROM Customers
    WHERE pid NOT IN (
        SELECT DISTINCT custId
        FROM Orders
    )
);

-- 5 --
SELECT p.firstName
FROM People p
JOIN Customers c ON p.pid = c.pid
LEFT JOIN Orders o ON c.pid = o.custId
WHERE o.custId IS NULL;

-- 6 --
SELECT a.pid AS agent_id, a.commissionPct
FROM People p
JOIN Agents a ON p.pid = a.pid
JOIN Orders o ON a.pid = o.agentId
WHERE o.custId = '008'
ORDER BY a.commissionPct DESC;


-- 7 --
SELECT DISTINCT p.lastName, p.homeCity, a.commissionPct
FROM People p
JOIN Agents a ON p.pid = a.pid
JOIN Orders o ON a.pid = o.agentId
WHERE o.custId = '001'
ORDER BY a.commissionPct DESC;

-- 8 --
SELECT p.lastName, p.homeCity
FROM People p
INNER JOIN Customers c ON p.pid = c.pid
WHERE p.homeCity IN (
    SELECT pr.city
    FROM Products pr
    GROUP BY pr.city
    HAVING COUNT(DISTINCT pr.prodid) = (
        SELECT COUNT(DISTINCT pr2.prodid)
        FROM Products pr2
        GROUP BY pr2.city
        ORDER BY COUNT(DISTINCT pr2.prodid) ASC
        LIMIT 1
    )
);

-- 9 --

-- JOINS -- 
SELECT DISTINCT pr.name, pr.prodid
FROM Products pr
INNER JOIN Orders o ON pr.prodid = o.prodid
INNER JOIN Agents a ON o.agentId = a.pid
INNER JOIN Customers c ON o.custId = c.pid
INNER JOIN People p ON a.pid = p.pid
WHERE a.pid IN (
    SELECT DISTINCT agentId
    FROM Orders
    WHERE custId IN (
        SELECT pid
        FROM People
        WHERE homeCity = 'Arlington'
    )
)
ORDER BY pr.name ASC;


-- SUBQUERIES --
SELECT pr.name, pr.prodid
FROM Products pr
WHERE pr.prodid IN (
    SELECT DISTINCT o.prodId
    FROM Orders o
    WHERE o.agentId IN (
        SELECT DISTINCT agentId
        FROM Orders
        WHERE custId IN (
            SELECT pid
            FROM People
            WHERE homeCity = 'Arlington'
        )
    )
)
ORDER BY pr.name ASC;


-- 10 -- 
SELECT DISTINCT pc.firstName AS customer_first_name, 
				pc.lastName AS customer_last_name,
                pa.firstName AS agent_first_name, 
				pa.lastName AS agent_last_name,
                pc.homeCity AS shared_city
FROM People pc
JOIN People pa ON pc.homeCity = pa.homeCity AND pc.pid != pa.pid
JOIN Customers cu ON cu.pid = pc.pid
JOIN Agents ag ON ag.pid = pa.pid;


