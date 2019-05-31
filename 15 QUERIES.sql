select * from Products
select * from Suppliers
SELECT * FROM CATEGORIES
select * from customers
SELECT * FROM Orders
select * from [Order Details Extended]
SELECT * FROM Employees
SELECT * FROM Territories
SELECT * FROM EmployeeTerritories
select * from [Sales by Category]
SELECT * FROM fact_sales

--1
select ProductName,CompanyName 
from Products p
inner join Suppliers s
ON p.SupplierID=s.SupplierID

--2
select ProductName,CompanyName ,CategoryName
from Products p
inner join Suppliers s
ON p.SupplierID=s.SupplierID
INNER JOIN Categories c
ON p.CategoryID=c.CategoryID
order by ProductName
--3
select contactname,count(OrderID) [count],o.OrderID
from Customers c inner join Orders o 
on c.CustomerID=o.CustomerID 
group by c.ContactName,o.OrderID
--4
select orderid,contactname,CompanyName,ShipCountry
from Customers c inner join Orders o 
on c.CustomerID=o.CustomerID 
where shipcountry = 'brazil'
--5
select o.orderid,contactname,firstname,sum(ExtendedPrice) [Total Amount]
from Customers c inner join Orders o 
on c.CustomerID=o.CustomerID inner join 
Employees e on e.EmployeeID=o.EmployeeID inner join [Order Details Extended] oe on o.OrderID=oe.OrderID
group by o.orderid,c.ContactName,e.FirstName
order by o.orderid

--6
select p.productname,title from orders o inner join employees e 
on o.employeeid=e.EmployeeID inner join [Order Details Extended] oe 
on oe.OrderID=o.OrderID inner join Products p on p.ProductID=oe.ProductID
where title='sales manager'

--7


select *,
case when Region is null then LEFT(Country,1)+LEFT(city,1)
ELSE REGION
END as REGION2
FROM PRODUCTS P
INNER JOIN SUPPLIERS S ON s.SupplierID=p.SupplierID

--8
select companyname,contactname,city,unitprice up from products p 
right join suppliers s on p.SupplierID=s.SupplierID
group by(CompanyName),contactname,city,UnitPrice


--9

SELECT CUSTOMERID,SHIPNAME,SHIPCITY,TERRITORYDESCRIPTION,UNITPRICE,DISCOUNT,O.SHIPVIA,T.TerritoryID
FROM
Orders O 
INNER JOIN [Order Details Extended] OE ON O.OrderID=OE.OrderID 
INNER JOIN EmployeeTerritories ET ON ET.EmployeeID=O.EmployeeID 
INNER JOIN Territories T ON T.TerritoryID = ET.TerritoryID
 WHERE SHIPVIA BETWEEN 1 AND 2 AND T.TerritoryID<=9999

 --10

 SELECT o.OrderID,c.CustomerID,unitprice,quantity,discount from
 orders o inner join Customers c
 on o.CustomerID = c.CustomerID inner join 
 [Order Details Extended] oe on oe.OrderID=o.OrderID
 where discount > 0

 --11

;with CTE
as
(
select categoryid,cast(description as varchar(100)) as newdescription 
from Categories
),
CTE2
AS
(
SELECT categoryid,replace(newdescription,' and ',',') as des2
FROM cte
),
CTE3
as
(
select *,len(des2)-len(replace(des2,',','')) as count from CTE2
)

select c.categoryid,categoryname,productname,s.SupplierID,unitprice,Description
from Products p inner join suppliers s 
on p.SupplierID=s.SupplierID 
inner join Categories c on c.CategoryID=p.CategoryID
inner join cte3 ct on ct.CategoryID = c.CategoryID
 where count<2

--15
select Dateadd(mm,6,Hiredate) as AppraisalDate, Firstname + Lastname as Fullname, HireDate from Employees

--14

;with cte
as
(select orderid,DATEDIFF(dd,orderDate,shippedDate)  deliverydays 
from Orders )

select *,
case when deliverydays between 4 and 7 then 'ON-TIME'
      when deliverydays <4 then 'Delivered Early'
	   when deliverydays >7 then 'Delayed'
	 
end as [STATUS]
from cte

--13


;with cte
as
(select orderid,DATEDIFF(dd,orderDate,shippedDate)  deliverydays ,ShippedDate as deliverdate
from Orders )
select * from cte
WHERE deliverydays is not null
order by deliverdate

--12


;WITH CTE
AS
(
select *,
    SUBSTRING(ContactName, 1, CHARINDEX(' ', ContactName) - 1) as firstname , 
    SUBSTRING(ContactName, CHARINDEX(' ', ContactName) + 1, LEN(ContactName)) as lastname 
from Suppliers
)
SELECT contactname ,SUBSTRING(CTE.firstname, 1, 1 ) + SUBSTRING(CTE.lastname, 1, 1 ) SHORTNAME

FROM CTE
ORDER  BY SHORTNAME


