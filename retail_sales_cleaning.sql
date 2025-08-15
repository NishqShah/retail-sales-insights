
## Project Sales Revenue Prediction
/*Date 
CustomerID
Age 
Gender 
ProductCategory 
Quantity 
UnitPrice 
TotalPrice 
*/

create database project;
use project;
create table retail_sales(
Date date,
CustomerID varchar(50),
Age int,
Gender varchar(10),
ProductCategory varchar(100),
Quantity int,
UnitPrice decimal(10,2),
TotalPrice decimal(10,2)
);

drop table retail_sales;


desc retail_sales;

select * from retail_sales;

#Altering Table to import ID

alter table retail_sales
add column RecordID int auto_increment primary key;

#Removing Duplicates

SET SQL_SAFE_UPDATES = 0;
delete t1
from retail_sales t1
join retail_sales t2
on t1.date=t2.date
and t1.CustomerID = t2.CustomerID
and t1.ProductCategory = t2.ProductCategory
and t1.Quantity = t2.Quantity
and t1.UnitPrice = t1.UnitPrice
where t1.RecordID > t2.RecordID;


delete from retail_sales
where Date is null
or ProductCategory is null
or Quantity is null
or UnitPrice is null;
SET SQL_SAFE_UPDATES = 1;

alter table retail_sales
add column Gender_Code int;

update retail_sales
set Gender_Code = case 
when Gender = 'Male' then 1
when Gender = 'Female' then 0
else null
end;

alter table retail_sales
add column year int,
add column month int,
add column quarter int;

update retail_sales
set Year = year(Date),
	Month = month(Date),
    Quarter = quarter(Date)
    ;
   
create table sales_summary as
select
Year,
Month,
ProductCategory,
sum(TotalPrice) as MonthlySales,
sum(Quantity) as TotalQuantity,
count(distinct CustomerID) as UniqueCustomers
from retail_sales
group by Year,Month,ProductCategory
order by Year,Month;

select * from retail_sales;
select * from sales_summary;

