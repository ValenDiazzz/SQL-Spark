SELECT  
  event_id, 
  event_time, 
  user_id, 
  platform,
  MAX(CASE WHEN parameter_name='item_id' THEN CAST(parameter_value AS INT) ELSE NULL END) item_id,
  MAX(CASE WHEN parameter_name='referrer' THEN parameter_value ELSE NULL END) referrer
FROM dsv1069.events
WHERE event_name='view_item'
GROUP BY 
  event_id, 
  event_time, 
  user_id, 
  platform
ORDER BY event_id DESC

/*El unico objetivo de usar la funcion MAX es para poder agrupar en eventos
Sin usar el MAX tendremos dos filas con el mismo evento en donde en una fila 
tendremos el item_it con alguna informacion y al referrer NULL y la segunda
sera al reves
*/