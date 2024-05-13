--metrics for different test groups
SELECT 
  t1.event_id,
  t1.event_time,
  MIN(o.created_at) last_created_order,
  t1.user_id,
  t1.test_id,
  t1.test_assignment,
  COUNT(DISTINCT o.invoice_id) n_orders,
  COUNT(DISTINCT o.line_item_id) n_line_items,
  SUM(o.price) total_revenue
FROM(
  SELECT 
    event_id,
    event_time,
    user_id,
    MAX(CASE WHEN parameter_name='test_id' THEN CAST(parameter_value AS INT) ELSE NULL END) AS test_id,
    MAX(CASE WHEN parameter_name='test_assignment' THEN CAST(parameter_value AS INT) ELSE NULL END) AS test_assignment
  FROM dsv1069.events
  WHERE event_name='test_assignment'
  GROUP BY event_id, event_time,user_id
) t1 
INNER JOIN dsv1069.orders o 
ON o.user_id=t1.user_id
GROUP BY   t1.event_id,t1.event_time,  t1.user_id, t1.test_id, t1.test_assignment
HAVING 
  t1.event_time<MIN(o.created_at)
ORDER BY MIN(o.created_at)-event_time ASC