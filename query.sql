/* 1. FILTER MOVIES BY GENRE (Action) */
SELECT mv.title
FROM movie mv
INNER JOIN genre gn 
    ON mv.genre_id = gn.id
WHERE LOWER(gn.name) = 'action';



/* 2. SEARCH MOVIE BY NAME (Inception) */
SELECT title
FROM movie
WHERE title LIKE '%Inception%';



/* 3. SORT MOVIES BY RATING (DESCENDING) */
SELECT title, rating
FROM movie
ORDER BY rating DESC;



/* 4. SHOW ONLY PREMIUM MOVIES */
SELECT title, is_premium
FROM movie
WHERE is_premium = 1;



/* 5. MOVIE RECOMMENDATION 
   (BASED ON USER'S HIGH-RATED GENRES) */
SELECT m.title
FROM movie m
WHERE m.genre_id IN (
    SELECT DISTINCT m2.genre_id
    FROM movie m2
    JOIN review r 
        ON r.movie_id = m2.id
    WHERE r.user_id = 1
    AND r.rating >= 4
)
AND m.id NOT IN (
    SELECT movie_id
    FROM review
    WHERE user_id = 1
);



/* 6. TRENDING MOVIES 
   (LATEST + HIGH RATED FIRST) */
SELECT title, rating, release_date
FROM movie
ORDER BY release_date DESC, rating DESC;