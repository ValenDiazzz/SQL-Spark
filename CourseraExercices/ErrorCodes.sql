--1
SELECT email_address
FROM dsv1069.users
WHERE deleted_at IS NULL


--2
SELECT category, COUNT(id) total_sales
FROM dsv1069.items
GROUP BY category
ORDER BY total_sales DESC


--3
SELECT *
FROM dsv1069.orders o INNER JOIN dsv1069.users u
  ON o.user_id=u.id


--4
SELECT COUNT(DISTINCT event_id) AS events
FROM dsv1069.events
WHERE event_name = 'view_item'

--5
SELECT COUNT(DISTINCT o.item_id) total_item_orders
FROM dsv1069.orders o


--6
SELECT u.id user_id, MIN(o.paid_at) min_paid_At
FROM dsv1069.users u  LEFT OUTER JOIN dsv1069.orders o ON u.id=o.user_id
GROUP BY u.id


--7
SELECT
  CASE WHEN first_view IS NULL THEN false ELSE true END has_viewed_profile_page,
  COUNT(user_id) as users
FROM(
  SELECT users.id user_id , MIN(event_time) as first_view
  FROM dsv1069.users LEFT OUTER JOIN dsv1069.events ON
    events.user_id=users.id AND events.event_name='view_user_profile'
  GROUP BY users.id
) first_profile_views
GROUP BY CASE WHEN first_view IS NULL THEN false ELSE true END
