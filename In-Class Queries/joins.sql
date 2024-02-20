select *
from Customers c, Orders o
where c.pid = o.custID;

select *
from Customers c inner join Orders o on c.pid = o.custId;

select *
from Customers c left outer join Orders o on c.pid = o.custId;

select *
from Customers c right outer join Orders o on c.pid = o.custId;


select *
from people 
where pid not in (select pid
				  from customers)
		  and pid not in (select pid 
						 from agents)

-- view --
create view PeopleWhoAreCustomers
AS
select p.*
from People p inner join Customers c on p.pid = c.pid;