-- 1 --
SELECT *
FROM People p inner join Customers c on p.pid = c.pid;




-- 3 --
select *
from People p inner join Agents a on p.pid = a.pid
			  inner join Customers c on p.pid = c.pid;

