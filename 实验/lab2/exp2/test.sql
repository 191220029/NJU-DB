drop procedure if exists search_customer;
delimiter //
CREATE PROCEDURE search_customer ()
BEGIN
-- 需要定义接收游标数据的变量
DECLARE C_customerName varchar(40);
declare C_address varchar(40);
declare C_telephone varchar(20);
DECLARE done integer DEFAULT FALSE;
DECLARE C CURSOR FOR  select customerName, address, telephone from customer;
-- 将结束标志绑定到游标
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
-- 打开游标
OPEN C;

-- 开始循环
read_loop: LOOP
-- 提取游标里的数据，这里只有一个，多个的话也一样；
FETCH  C INTO C_customerName, C_address, C_telephone;
-- 声明结束的时候
IF done THEN
LEAVE read_loop;
END IF;
-- 这里做你想做的循环的事件

-- INSERT INTO test VALUES (C_customerName, C_address, C_telephone);

END LOOP;
-- 关闭游标
CLOSE C;

END
//
call search_customer;