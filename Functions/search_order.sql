DELIMITER //

CREATE FUNCTION search_order(
    customer_id INT,
    _status VARCHAR(50),
    _start_date TEXT
)
RETURNS JSON 
DETERMINISTIC
BEGIN
    DECLARE result_ JSON;

    -- Base query with conditions based on input parameters
    IF (COALESCE(customer_id, 0) = 0 AND COALESCE(_status, '') = '' AND COALESCE(_start_date, '') = '') THEN
        -- If no filters, return all orders
        SET result_ = (
            SELECT JSON_ARRAYAGG(
                JSON_OBJECT(
                    "customer_name", c.customer_name,
                    "order_id", o.order_id,
                    "status", o.status,
                    "total_price", o.total_price,
                    "purchased_date", o.order_ts
                )
            )
            FROM orders o
            JOIN customer c ON o.customer_id = c.customer_id
        );
    ELSE
        -- Build the query with conditions
        SET result_ = (
            SELECT JSON_ARRAYAGG(
                JSON_OBJECT(
                    "customer_name", c.customer_name,
                    "order_id", o.order_id,
                    "status", o.status,
                    "total_price", o.total_price,
                    "purchased_date", o.order_ts
                )
            )
            FROM orders o
            JOIN customer c ON o.customer_id = c.customer_id
            WHERE (COALESCE(customer_id, 0) = 0 OR o.customer_id = customer_id)
              AND (COALESCE(_status, '') = '' OR o.status = _status)
              AND (COALESCE(_start_date, '') = '' OR DATE_FORMAT(o.order_ts, '%Y-%m-%d') = _start_date)
        );
    END IF;

    RETURN result_;
END //

DELIMITER ;
##select search_order(0,'','2024-11-16')

