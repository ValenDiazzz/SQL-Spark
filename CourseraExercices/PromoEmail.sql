SELECT 
  t2.item_id,
  i.name item_name,
  i.category item_category,
  t2.user_id,
  u.email_address 
FROM 
(
  SELECT 
    CAST(e1.parameter_value AS INT) item_id,
    CAST(t1.user_id AS INT)
  FROM
  (
    SELECT 
      e.user_id user_id,
      MIN(e.event_time) date_time
    FROM 
      dsv1069.events e
    WHERE e.event_name='view_item' AND e.parameter_name='item_id'
    GROUP BY e.user_id
  ) t1 
  INNER JOIN dsv1069.events e1
  ON t1.user_id=e1.user_id AND 
    t1.date_time=e1.event_time
  WHERE e1.event_name='view_item' AND e1.parameter_name='item_id'
) t2
LEFT JOIN dsv1069.users u ON t2.user_id=u.id 
LEFT JOIN dsv1069.items i ON t2.item_id=i.id