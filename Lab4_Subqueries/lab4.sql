-- 1 --
SELECT *
FROM People
WHERE pid IN(SELECT pid
             FROM People
             INTERSECT
             SELECT pid
             FROM Customers);

/*
SELECT *
FROM People
WHERE pid IN( SELECT pid
              FROM Customers);

SELECT *
FROM People
WHERE People.pid IN ( SELECT Customers.pid
                      FROM Customers);

SELECT *
FROM People p
WHERE p.pid IN (SELECT c IN c.pid
                FROM Customers c);
*/

-- 2 --
SELECT *
FROM People
WHERE pid IN ( SELECT pid
               FROM People
               INTERSECT
               SELECT pid
               FROM Agents);

-- 3 --
SELECT *
FROM People
WHERE pid IN ( SELECT pid
               FROM Customers
               INTERSECT
               SELECT pid
               FROM Agents);

-- 4 --
SELECT *
FROM PEOPLE p
WHERE NOT EXISTS ( SELECT *
                   FROM Customers c
                   WHERE p.pid = c.pid)
                   AND NOT EXISTS ( SELECT *
                                    FROM Agents a
                                    WHERE p.pid = a.pid);

-- 5 --
SELECT DISTINCT custID
FROM Orders
WHERE prodID = 'p03' 
OR prodID = 'p05'
ORDER BY custId ASC;

-- 6 --
