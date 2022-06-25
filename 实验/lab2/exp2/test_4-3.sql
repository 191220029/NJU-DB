-- 4.使用高级程序设计语言访问SQL并执行如下的查询、插入、删除、更新：
-- 1）查询职工工资按从高到低排序的前20的职工编号、职工姓名和工资；
-- 2）为客户表插入一条新的客户信息，客户编号“C20080002”，客户名称“泰康股份有限公司”，客户电话“010-5422685”，客户地址“天津市”，客户邮编“220501”；
-- 3）删除员工表中薪水高于5000的员工信息；
-- 4）更新商品基本信息表中价格超过1000的商品价格变为原来的50%；

-- insert Employee values('E2005001','喻自强','M','19650415','南京市青海路18号','13817605008', '19900206','财务科','科长',5800);
-- insert into employee
-- (employeeNo, employeeName, gender, birthday, address, telephone, hireDate, department, headShip, salary)
-- VALUES
-- ('E2021001', 'test1', 'M', '1968-01-06', '上海市福州路135号', NULL, '1992-02-28', '业务科', '职员', 6000),
-- ('E2021002', 'test2', 'M', '1968-01-06', '上海市福州路135号', NULL, '1991-02-28', '业务科', '职员', 6000),
-- ('E2021003', 'test3', 'M', '1968-01-06', '上海市福州路135号', NULL, '1992-02-28', '业务科', '职员', 6000);

-- insert Employee values('E2005001','喻自强','M','19650415','南京市青海路18号','13817605008', '19900206','财务科','科长',5800);
select *
from employee 
where salary > 5000
order by salary desc;

-- SET FOREIGN_KEY_CHECKS = 0;
-- SET SQL_SAFE_UPDATES = 0;
-- delete from employee where salary > 5000;
-- SET SQL_SAFE_UPDATES = 1;
-- SET FOREIGN_KEY_CHECKS = 1;

-- select *
-- from employee 
-- where salary > 5000
-- order by salary desc;

