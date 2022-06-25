-- 3.创建触发器，完成以下任务：
-- 1）当插入一项商品时，如果商品价格大于1000，则将其设置为1000。
-- 2）当员工完成一个新的订单时，薪水增加5%；如果该员工是1992年前入职的，则再增加3%。
drop trigger if exists pPrice_insert;
delete from product where productNo like 'P2009%';
delimiter //
create trigger pPrice_insert before insert on product
	for each row
begin
	if new.productPrice > 1000 then
		set new.productPrice = 1000;
	end if;
end
//
insert into product
(productNo, productName, productClass, productPrice)
VALUES
('P20090001', 'test1', 'test', 100),
('P20090002', 'test2', 'test', 12000);
select * from product;
delete from product where productNo like 'P2009%';



drop trigger if exists raise_salary;
delete from ordermaster where orderNo like '2021%';
SET FOREIGN_KEY_CHECKS = 0;
delete from employee where employeeNo like 'E2021%';
SET FOREIGN_KEY_CHECKS = 1;

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
insert into employee
(employeeNo, employeeName, gender, birthday, address, telephone, hireDate, department, headShip, salary)
VALUES
('E2021001', 'test1', 'M', '1968-01-06', '上海市福州路135号', NULL, '1992-02-28', '业务科', '职员', 1000),
('E2021002', 'test2', 'M', '1968-01-06', '上海市福州路135号', NULL, '1991-02-28', '业务科', '职员', 1000),
('E2021003', 'test2', 'M', '1968-01-06', '上海市福州路135号', NULL, '1991-02-28', '业务科', '职员', 1000);
insert into ordermaster
(orderNo, customerNo, employeeNo, orderDate, orderSum, invoiceNo)
VALUES
('P20210001', 'C20050001', 'E2021001', '2008-01-09', 0, 'I202100001'),
('P20210002', 'C20050001', 'E2021002', '2008-01-09', 0, 'I202100001');

select *
from employee;
delete from ordermaster where orderNo like '2021%';
SET FOREIGN_KEY_CHECKS = 0;
delete from employee where employeeNo like 'E2021%';
SET FOREIGN_KEY_CHECKS = 1;
