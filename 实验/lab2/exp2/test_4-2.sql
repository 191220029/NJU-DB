-- 4.使用高级程序设计语言访问SQL并执行如下的查询、插入、删除、更新：
-- 1）查询职工工资按从高到低排序的前20的职工编号、职工姓名和工资；
-- 2）为客户表插入一条新的客户信息，客户编号“C20080002”，客户名称“泰康股份有限公司”，客户电话“010-5422685”，客户地址“天津市”，客户邮编“220501”；
-- 3）删除员工表中薪水高于5000的员工信息；
-- 4）更新商品基本信息表中价格超过1000的商品价格变为原来的50%；
SET FOREIGN_KEY_CHECKS = 0;
-- delete from customer where customerNo = 'C20080002';
SET FOREIGN_KEY_CHECKS = 1;

-- select count(*) from employee;

insert into customer
(customerNo, customerName, address, telephone, zip)
value
('C20080002', '泰康股份有限公司', '天津市', '010-5422685', '220501') ;-- ON DUPLICATE KEY UPDATE customerNo = 'C20080002';

select * from customer where customerNo = 'C20080002';
