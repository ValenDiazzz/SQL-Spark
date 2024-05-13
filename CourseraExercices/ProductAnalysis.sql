SELECT COUNT(DISTINCT id) --117178
FROM dsv1069.users

SELECT COUNT(DISTINCT user_id) --17463
FROM dsv1069.orders 

SELECT COUNT(DISTINCT user_id) reordered_users --211
FROM
(
  SELECT user_id, item_id, COUNT(item_id)
  FROM dsv1069.orders
  GROUP BY user_id, item_id
  HAVING COUNT(item_id)>1
  ORDER BY user_id DESC
) t1

SELECT item_id,COUNT(item_id)
FROM dsv1069.orders
GROUP BY item_id
ORDER BY COUNT(item_id) DESC

SELECT item_category,COUNT(item_id)
FROM dsv1069.orders
GROUP BY item_category
ORDER BY COUNT(item_id) DESC


SELECT user_id, COUNT(user_id) AS rep
FROM(
  SELECT user_id, item_category,COUNT(item_id)
  FROM dsv1069.orders
  GROUP BY user_id, item_category
  ORDER BY user_id DESC
) t1
GROUP BY user_id
HAVING COUNT(user_id)>1


SELECT COUNT(DISTINCT line_item_id)
FROM dsv1069.orders

SELECT COUNT(DISTINCT item_id)
FROM dsv1069.orders