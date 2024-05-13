SELECT 
  dr.date,
  dr.d7_ago,
  dr.d28_ago,
  COALESCE(o.orders,0) ord_am,
  o.date_ day_
FROM 
  dsv1069.dates_rollup dr 
LEFT OUTER JOIN
  (
  SELECT 
    DATE(created_at)  AS date_,
    COUNT(DISTINCT invoice_id) AS orders
  FROM dsv1069.orders
  GROUP BY DATE(created_at)
  ORDER BY date_ ASC
  ) o 
  ON 
    dr.date>=o.date_  AND
    dr.d7_ago<o.date_ 