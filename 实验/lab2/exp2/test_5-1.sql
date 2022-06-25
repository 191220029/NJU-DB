-- 5.
-- 1）为“业务科”（作为外部输入参数）所有员工增加200的薪水。
-- 2）查询客户表中的客户名称、客户地址及客户电话并输出。（注：结合游标的使用）
select * from employee;
select employee.employeeNo, salary
from employee
where department = '业务科';

-- SET SQL_SAFE_UPDATES = 0;
-- update employee
-- set salary = salary + 200
-- where department = '业务科';
-- SET SQL_SAFE_UPDATES = 1;

-- select employee.employeeNo, salary
-- from employee
-- where department = '业务科';

SET SQL_SAFE_UPDATES = 0;
update employee
set salary = salary - 200
where department = '业务科';
SET SQL_SAFE_UPDATES = 1;


