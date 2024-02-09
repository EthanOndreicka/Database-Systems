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
WHERE prodID IN ( SELECT prodID
				  FROM Orders
				  WHERE prodID = 'p01'
			   	  OR prodID = 'p03')
			   	  ORDER BY custID ASC;

-- 6  --
SELECT DISTINCT custId
FROM Orders
WHERE custId IN ( SELECT custId
    			  FROM Orders
    			  WHERE prodId = 'p01')
				  AND custId IN ( SELECT custId
    							  FROM Orders
    							  WHERE prodId = 'p03')
ORDER BY custId DESC;


-- 7 --
SELECT firstName, lastName
FROM People
WHERE pid IN ( SELECT pid
               FROM Agents
               WHERE pid IN ( SELECT agentID
                              FROM Orders
                              WHERE prodID IN ('p05', 'p07')))
ORDER BY lastName ASC;

-- 8 --
SELECT homeCity, DOB
FROM People
WHERE pid IN ( SELECT agentId
    		   FROM Orders
    		   WHERE custId = '008')
ORDER BY homeCity DESC;

-- 9 --
SELECT DISTINCT prodId
FROM Orders
WHERE agentId IN ( SELECT agentId
				   FROM Orders
				   WHERE custId IN (SELECT pid
								 FROM People
								 WHERE homeCity = 'Montreal'))
ORDER BY prodId DESC;

-- 10 --
SELECT lastName, homeCity
FROM People
WHERE pid IN ( SELECT custId
               FROM Orders
               WHERE agentId IN ( SELECT pid
                                  FROM People
                                  WHERE homeCity = 'Chilliwack'
                                  OR homeCity = 'Oslo'))
ORDER BY lastName ASC;
