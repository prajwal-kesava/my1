
create table #temp3
(empid int primary key,
empname varchar(100),
salary money,
id int
)
begin tran
insert into #temp3
select * from prj1
select * from #temp3

declare @empid int
set @empid=22
declare @empname varchar(100)='Amrutha Prajwal'
declare @empsalary decimal(10,2)
declare @emptable table (empid int,empname varchar(100),empsalary decimal(10,2))
begin tran
insert into @emptable
select empid,empname,salary from #temp3
select * from @emptable

select @@trancount
