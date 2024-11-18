DELIMITER //

CREATE FUNCTION create_update_product(_product_name varchar(50),_price int,_description text,_warranty boolean)
RETURNS text 
DETERMINISTIC
BEGIN
    DECLARE _last_product_id INT;
  if exists(select 1 from product where product_name = _product_name) then
  update product
  set price = _price,description = _description,warranty = _warranty
  where product_name = _product_name;
	SELECT product_id INTO _last_product_id
    FROM product
    WHERE product_name = _product_name;
    RETURN CONCAT('Product updated with ID: ', _last_product_id);
  end if;
  if not exists(select 1 from product where product_name = _product_name) then
  INSERT INTO product (product_name, price, description, warranty, product_ts)
  VALUES (_product_name,_price,_description,_warranty,NOW());
  RETURN CONCAT('Product inserted with ID: ', LAST_INSERT_ID());
  end if;
  return 0;
END //

DELIMITER ;
##select create_update_product('CPU',5000,'Monitor',false);
