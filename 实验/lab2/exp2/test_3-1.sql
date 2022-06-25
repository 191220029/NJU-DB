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

select * from product  where productNo like 'P2009%';

delete from product where productNo like 'P2009%';
