SELECT 
  ord_bin_t.test_assignment,
  SUM(ord_bin_t.orders_binary) AS orders_am,
  COUNT(ord_bin_t.user_id) AS users
FROM(
  SELECT 
    t1.user_id,
    t1.test_id,
    t1.test_assignment,
    MAX(CASE WHEN o.created_at>t1.event_time THEN 1 ELSE 0 END) AS orders_binary
  FROM(
    SELECT 
      event_time,
      user_id,
      MAX(CASE WHEN parameter_name='test_id' THEN CAST(parameter_value AS INT) ELSE NULL END) AS test_id,
      MAX(CASE WHEN parameter_name='test_assignment' THEN CAST(parameter_value AS INT) ELSE NULL END) AS test_assignment
    FROM dsv1069.events
    WHERE event_name='test_assignment'
    GROUP BY event_time,user_id
  ) t1 
  LEFT OUTER JOIN dsv1069.orders o 
  ON o.user_id=t1.user_id
  GROUP BY t1.event_time,  t1.user_id, t1.test_id, t1.test_assignment
) ord_bin_t
WHERE ord_bin_t.test_id=7
GROUP BY ord_bin_t.test_assignment

-----------------------------------

SELECT 
  ord_bin_t.test_assignment,
  SUM(ord_bin_t.views_binary) AS views_am,
  COUNT(ord_bin_t.user_id) AS users
FROM(
  SELECT 
    t1.user_id,
    t1.test_id,
    t1.test_assignment,
    MAX(CASE WHEN t2.event_time>t1.event_time THEN 1 ELSE 0 END) AS views_binary
  FROM(
    SELECT 
      event_time,
      user_id,
      MAX(CASE WHEN parameter_name='test_id' THEN CAST(parameter_value AS INT) ELSE NULL END) AS test_id,
      MAX(CASE WHEN parameter_name='test_assignment' THEN CAST(parameter_value AS INT) ELSE NULL END) AS test_assignment
    FROM dsv1069.events
    WHERE event_name='test_assignment'
    GROUP BY event_time,user_id
  ) t1 
  LEFT OUTER JOIN (
    SELECT *
    FROM dsv1069.events 
    WHERE event_name='view_item'
  ) t2
  ON t2.user_id=t1.user_id
  GROUP BY t1.event_time,  t1.user_id, t1.test_id, t1.test_assignment
) ord_bin_t
WHERE ord_bin_t.test_id=7
GROUP BY ord_bin_t.test_assignment

--------------------------------
SELECT 
  ord_bin_t.test_assignment,
  SUM(ord_bin_t.views_binary) AS views_am,
  COUNT(ord_bin_t.user_id) AS users
FROM(
  SELECT 
    t1.user_id,
    t1.test_id,
    t1.test_assignment,
    MAX(CASE WHEN ABS(EXTRACT(EPOCH FROM (t2.event_time-t1.event_time)) / 86400)<30 THEN 1 ELSE 0 END) AS views_binary
  FROM(
    SELECT 
      event_time,
      user_id,
      MAX(CASE WHEN parameter_name='test_id' THEN CAST(parameter_value AS INT) ELSE NULL END) AS test_id,
      MAX(CASE WHEN parameter_name='test_assignment' THEN CAST(parameter_value AS INT) ELSE NULL END) AS test_assignment
    FROM dsv1069.events
    WHERE event_name='test_assignment'
    GROUP BY event_time,user_id
  ) t1 
  LEFT OUTER JOIN (
    SELECT *
    FROM dsv1069.events 
    WHERE event_name='view_item'
  ) t2
  ON t2.user_id=t1.user_id
  GROUP BY t1.event_time,  t1.user_id, t1.test_id, t1.test_assignment
) ord_bin_t
WHERE ord_bin_t.test_id=7
GROUP BY ord_bin_t.test_assignment

--------------------
