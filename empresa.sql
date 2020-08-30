 WITH quiz_funnel as(
  SELECT question,
         COUNT(DISTINCT user_id) AS responses
  FROM survey
  GROUP BY 1
  ORDER BY 2 DESC
)
SELECT * FROM quiz_funnel;

WITH funnel AS (
  SELECT DISTINCT q.user_id AS 'quiz',
       h.user_id IS NOT NULL AS 'is_home_try_on',
       h.number_of_pairs,
       p.user_id IS NOT NULL AS 'is_purchase'
FROM quiz AS q
LEFT JOIN home_try_on AS h
  ON q.user_id = h.user_id
LEFT JOIN purchase AS p
  ON p.user_id = q.user_id
)
SELECT COUNT(quiz) AS 'quiz_num',
       sum(is_home_try_on) AS 'home_try_on_num',
       sum(is_purchase) AS 'purchase_num'
FROM funnel;

SELECT num_pairs, round(1.0 * sum(is_purchase)/sum(is_home_try_on),2) AS purchase_rate
FROM funnel WHERE num_pairs IS '3 pairs' OR num_pairs IS '5 pairs' GROUP BY num_pairs;

SELECT style,
 COUNT(user_id) AS responses
FROM quiz 
GROUP BY 1 ORDER BY 2 DESC;

SELECT style,
 COUNT(*) AS purchases 
FROM purchase 
GROUP BY 1 ORDER BY 2 DESC;

