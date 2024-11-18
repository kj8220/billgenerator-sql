DELIMITER //
CREATE FUNCTION product_list(_product_name varchar(50))
RETURNS json 
DETERMINISTIC
BEGIN
  DECLARE result JSON;
  if _product_name != '' then
  SET result = (SELECT JSON_OBJECT(
        'product_id', product_id,
        'product_name', product_name,
        'price', price,
        'description', description,
        'warranty',warranty
    )
    FROM product
    WHERE product_name = _product_name
    LIMIT 1
);
else 
SET result = (
    SELECT JSON_ARRAYAGG(
        JSON_OBJECT(
           'product_id', product_id,
			'product_name', product_name,
			'price', price,
			'description', description,
			'warranty',warranty
        )
    )
    FROM product
);  
end if;
RETURN result;
END //

DELIMITER ;
##select product_list('')

