-- Query 0

SELECT *
FROM analytics;

-- 1.

SELECT *
FROM analytics
WHERE id = 1880;

-- 2.

SELECT id,
       app_name
FROM analytics
WHERE last_updated = '2018-08-01';

-- 3.

SELECT category,
       COUNT(*)
FROM analytics
GROUP BY category;

-- 4.

SELECT *
FROM analytics
ORDER BY reviews DESC
LIMIT 5;

-- 5.

SELECT *
FROM analytics
WHERE rating >= 4.8
ORDER BY reviews DESC
LIMIT 1;

-- 6.

SELECT category,
       AVG(rating)
FROM analytics
GROUP BY category
ORDER BY avg DESC;

-- 7.

SELECT app_name,
       price,
       rating
FROM analytics
WHERE rating < 3
ORDER BY price DESC
LIMIT 1;

-- 8.

SELECT *
FROM analytics
WHERE min_installs <= 50
    AND rating IS NOT NULL
ORDER BY rating DESC;

-- 9.

SELECT app_name
FROM analytics
WHERE rating < 3
    AND reviews >= 10000;

-- 10.

SELECT *
FROM analytics
WHERE price BETWEEN 0.1 and 1
ORDER BY reviews DESC
LIMIT 10;

-- 11.
-- Option 1: with a subquery

SELECT *
FROM analytics
WHERE last_updated =
        (SELECT MIN(last_updated)
         FROM analytics);

-- 12. Find the most expensive app (the query is very similar to #11).
-- Option 1: with a subquery

SELECT *
FROM analytics
WHERE price =
        (SELECT MAX(price)
         FROM analytics);

-- Option 2: without a subquery

SELECT *
FROM analytics
ORDER BY price DESC
LIMIT 1;

-- 13. Count all the reviews in the Google Play Store.

SELECT SUM(reviews) AS "All the Reviews"
FROM analytics;

-- 14.

SELECT category
FROM analytics
GROUP BY category
HAVING COUNT(*) > 300;

-- 15.

SELECT app_name,
       reviews,
       min_installs,
       min_installs / reviews AS proportion
FROM analytics
WHERE min_installs >= 100000
ORDER BY proportion DESC
LIMIT 1;

Further Study further_study.sql -- FURTHER STUDY
 -- FS1. Find the name and rating of the top rated apps in each category,
-- among apps that have been installed at least 50,000 times.

SELECT app_name,
       rating,
       category
FROM analytics
WHERE (rating,
       category) in
        (SELECT MAX(rating),
                category
         FROM analytics
         WHERE min_installs >= 50000
         GROUP BY category)
ORDER BY category;

-- FS2.

SELECT *
FROM analytics
WHERE app_name ILIKE '%facebook%';

-- FS3.

SELECT *
FROM analytics
WHERE array_length(genres, 1) = 2;

-- FS4.

SELECT *
FROM analytics
WHERE genres @> '{"Education"}';