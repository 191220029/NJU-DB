drop procedure if exists search_customer;
delimiter //
create procedure search_customer()
begin
	DECLARE C_customerName varchar(40);
	declare C_address varchar(40);
	declare C_telephone varchar(20);
    declare i integer default 0;
	declare done int default 0;
	declare C cursor for select customerName, address, telephone from customer;
	declare continue handler for not found set done = 1;
    CREATE TABLE `orderdb`.`tmp_result` (
	  `id` INT,
	  `customerName` VARCHAR(40) NULL,
	  `address` VARCHAR(40) NULL,
	  `telephone` VARCHAR(20) NULL,
	  PRIMARY KEY (`id`));
    open C;
    read_loop : loop
		fetch C into C_customerName, C_address, C_telephone; 
        -- select C_customerName, C_address, C_telephone; 
        if done = 1 then
			leave read_loop;
		end if;
		insert into tmp_result(id, customerName, address, telephone) value(i, C_customerName, C_address, C_telephone) on duplicate key update customerName = C_customerName;
        set i = i + 1;
    end loop;
    close C;
    select customerName, address, telephone from tmp_result;
    drop table tmp_result;
end
//
call search_customer();
