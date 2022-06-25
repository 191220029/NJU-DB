-- 4.使用高级程序设计语言访问SQL并执行如下的查询、插入、删除、更新：
-- 1）查询职工工资按从高到低排序的前20的职工编号、职工姓名和工资；
-- 2）为客户表插入一条新的客户信息，客户编号“C20080002”，客户名称“泰康股份有限公司”，客户电话“010-5422685”，客户地址“天津市”，客户邮编“220501”；
-- 3）删除员工表中薪水高于5000的员工信息；
-- 4）更新商品基本信息表中价格超过1000的商品价格变为原来的50%；

-- insert into product
-- (productNo, productName, productClass, productPrice)
-- value
-- ('P20060001','VGA显示卡','显示器', 1200.60) ON DUPLICATE KEY UPDATE productPrice = 1200.60;
-- insert into product
-- (productNo, productName, productClass, productPrice)
-- value
-- ('P20080002','硕泰克SL—K8AN-RL主板','主板', 1100.00) ON DUPLICATE KEY UPDATE productPrice = 1100.00;

-- select *
-- from product
-- where productPrice > 1000;


-- SET SQL_SAFE_UPDATES = 0;
-- update product 
-- set productPrice = productPrice * 0.5
-- where productPrice > 1000;
-- SET SQL_SAFE_UPDATES = 1;

select *
from product
where productNo = 'P20060001' or productNo = 'P20080002'; 



