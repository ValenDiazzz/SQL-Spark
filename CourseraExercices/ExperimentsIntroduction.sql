--Tests that are running
SELECT DISTINCT parameter_value
FROM dsv1069.events
WHERE event_name='test_assignment'

SELECT COUNT(*)
FROM dsv1069.events
WHERE 
  event_name='test_assignment' AND 
  parameter_value IS NULL

SELECT 
  DISTINCT user_id, 
  COUNT(DISTINCT CASE WHEN parameter_value!='0' THEN parameter_value END)  AS tests
FROM dsv1069.events
WHERE 
  event_name='test_assignment' AND 
  parameter_value='5'
GROUP BY user_id
ORDER BY tests DESC 