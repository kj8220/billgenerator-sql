DELIMITER //

CREATE FUNCTION create_update_customer(_customer_name varchar(100),_email text,_phone_number text,_address text)
RETURNS bigint 
DETERMINISTIC
BEGIN
  if exists(select 1 from customer where phone_number = _phone_number) then
  update customer
  set customer_name = _customer_name,email = _email,phone_number = _phone_number,address = _address
  where phone_number = _phone_number;
  RETURN (SELECT customer_id FROM customer WHERE phone_number = _phone_number);
  end if;
  if not exists(select 1 from customer where phone_number = _phone_number) then
  INSERT INTO customer (customer_name, email, phone_number, address, customer_ts)
  VALUES (_customer_name,_email,_phone_number,_address,NOW());
  return LAST_INSERT_ID();
  end if;
  return 2;
END //

DELIMITER ;
##select create_update_customer('Jebin','jebin82@gmail.com','6382227471','address');
