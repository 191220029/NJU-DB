-- 姓名：傅小龙
-- 学号：191220029
-- 提交前请确保本次实验独立完成，若有参考请注明并致谢。

-- ____________________________________________________________________________________________________________________________________________________________________________________________________________
-- BEGIN Q1.1
drop procedure if exists gen_pruduct_sell_list;
delimiter //
create procedure gen_pruduct_sell_list(in pName Varchar(40))
begin
	select C.customerName, O.orderNo, OD.quantity, OD.price
    from Product P, Customer C, ordermaster O, orderdetail OD
    where P.productNo = OD.productNo and C.customerNo = O.customerNo and O.orderNo = OD.orderNo and P.productName = pName
    order by OD.price desc;
end
//
call gen_pruduct_sell_list('32M DRAM');
-- END Q1.1

-- ____________________________________________________________________________________________________________________________________________________________________________________________________________
-- BEGIN Q1.2
drop procedure if exists earlierHired_employee;
delimiter //
create procedure earlierHired_employee(in eNumber Char(8))
begin
	select E.employeeNo, E.employeeName, E.gender, E.hireDate, E.department
    from employee E
    where E.hireDate < (
		select E.hireDate
        from employee E
        where E.employeeNo = eNumber
    ) and E.department = (
		select E.department
        from employee E
        where E.employeeNo = eNumber
    );
end
//
call earlierHired_employee('E2008005');
-- END Q1.2

-- ____________________________________________________________________________________________________________________________________________________________________________________________________________
-- BEGIN Q2.1
drop function if exists avg_order_price;
delimiter //
create function avg_order_price(pName Varchar(40))
returns float
DETERMINISTIC
begin
	declare avg_price float;
	select avg(OD.price) into avg_price
    from orderdetail OD, Product P
    where OD.productNo = P.productNo and P.productName = pName
    group by P.productName;
    return avg_price;
end
//
select P.productName, avg_order_price(P.productName)
from Product P;
-- END Q2.1

-- ____________________________________________________________________________________________________________________________________________________________________________________________________________
-- BEGIN Q2.2
drop function if exists sum_product_sell;
delimiter //
create function sum_product_sell(pNo char(9))
returns integer
DETERMINISTIC
begin
	declare sum_sell integer;
	select sum(OD.quantity) into sum_sell
    from orderdetail OD
    where OD.productNo = pNo
    group by OD.productNo;
    return sum_sell;
end
//
select P.productNo, P.productName, sum_product_sell(P.productNo)
from Product P
where sum_product_sell(P.productNo) > 4
-- END Q2.2

-- ____________________________________________________________________________________________________________________________________________________________________________________________________________
-- BEGIN Q3.1
drop trigger if exists pPrice_insert;
delimiter //
create trigger pPrice_insert before insert on product
	for each row
begin
	if new.productPrice > 1000 then
		set new.productPrice = 1000;
	end if;
end
//
-- END Q3.1

-- ____________________________________________________________________________________________________________________________________________________________________________________________________________
-- BEGIN Q3.2
drop trigger if exists raise_salary;
delimiter //
create trigger raise_salary before insert on ordermaster
	for each row
begin
	declare old_salary float;
    set old_salary = (
		select salary
        from employee
        where employeeNo = new.employeeNo
    );
	if (
		select hireDate
        from employee
        where employeeNo = new.employeeNo
    ) < date('1992-01-01') then
		update employee set salary = old_salary * 1.08 where employeeNo = new.employeeNo;
	else 
		update employee set salary = old_salary * 1.05 where employeeNo = new.employeeNo;
	end if;
end
//
-- END Q3.2

