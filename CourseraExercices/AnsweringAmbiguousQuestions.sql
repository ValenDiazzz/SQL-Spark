SELECT 
  _day, 
  CASE WHEN MAX(new_users) IS NOT NULL THEN MAX(new_users) ELSE 0 END new_user_count, 
  CASE WHEN MAX(deleted_users) IS NOT NULL THEN MAX(deleted_users) ELSE 0 END deleted_user_count
FROM(
  (
    SELECT DATE(created_at) _day, COUNT(DISTINCT id) new_users,NULL deleted_users
    FROM dsv1069.users
    GROUP BY _day
  )
  UNION
  (
    SELECT DATE(deleted_at) _day,NULL new_users,COUNT(DISTINCT id) deleted_users
    FROM dsv1069.users
    WHERE deleted_at IS NOT NULL
    GROUP BY _day
  )
) a
GROUP BY _day 
ORDER BY _day DESC;