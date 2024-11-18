DELIMITER //

CREATE FUNCTION create_order(_customer_name varchar(50),_email varchar(100),_phone_number varchar(15),_address text,_product_name varchar(50),_status text)
RETURNS text 
DETERMINISTIC
BEGIN
  DECLARE _customer_id ,_order_id,_product_id bigint;
  DECLARE _product_ids JSON;
  DECLARE _total_price int;

	SET _customer_id = create_update_customer(_customer_name,_email,_phone_number,_address);
	SET _product_ids = (
        SELECT JSON_ARRAYAGG(product_id)
        FROM product
        WHERE FIND_IN_SET(product_name, _product_name)
    );
    SET _total_price = (
        SELECT sum(price)
        FROM product
        WHERE FIND_IN_SET(product_name, _product_name)
    );
    insert into orders(customer_id,status,order_items,order_ts,total_price)values(_customer_id,_status,_product_ids,now(),_total_price);
	RETURN CONCAT('Order inserted with ID: ', LAST_INSERT_ID());
END //

DELIMITER ;
##select create_order('Muthu','muthu45@gmail.com','37678263729','add','Monitor,Keyboard','Active')


