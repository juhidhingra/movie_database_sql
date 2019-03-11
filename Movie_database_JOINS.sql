# MOVIE DATABASE - SOLVING PROBLEMS USING JOINS 

# 1. Write a query in SQL to find the name of all reviewers who have rated their ratings with a NULL value

SELECT 
    rev_name
FROM
    reviewer
        JOIN
    rating ON reviewer.rev_id = rating.rev_id
WHERE
    rating.rev_stars IS NULL;
    
# 2. Write a query in SQL to list the first and last names of all the actors  who were cast in the movie 'Annie Hall', and the roles they played in that production.

SELECT 
    actor.act_fname, actor.act_lname, movie_cast.role
FROM
    actor
        JOIN
    movie_cast ON actor.act_id = movie_cast.act_id
        JOIN
    movie ON movie_cast.mov_id = movie.mov_id
WHERE
    movie.mov_title = 'Annie Hall';
    
# 3. Write a query in SQL to find the name of movie and director (first and last names) who directed a movie that casted a role for 'Eyes Wide Shut'.

SELECT 
    director.dir_fname, director.dir_lname, movie.mov_title
FROM
    director
        JOIN
    movie_direction ON director.dir_id = movie_direction.dir_id
        JOIN
    movie ON movie_direction.mov_id = movie.mov_id
        JOIN
    movie_cast ON movie_cast.mov_id = movie.mov_id
WHERE
    movie.mov_title = 'Eyes Wide Shut';
    
# 4. Write a query in SQL to find the name of movie and director (first and last names) who directed a movie that casted a role as Sean Maguire

SELECT 
    movie.mov_title, director.dir_fname, director.dir_lname
FROM
    director
        JOIN
    movie_direction ON movie_direction.dir_id = director.dir_id
        JOIN
    movie ON movie_direction.mov_id = movie.mov_id
        JOIN
    movie_cast ON movie.mov_id = movie_cast.mov_id
WHERE
    movie_cast.role = 'Sean Maguire';

# 5. Write a query in SQL to list all the actors who have not acted in any movie between 1990 and 2000.

SELECT 
    actor.act_id, actor.act_fname, actor.act_lname
FROM
    actor
        JOIN
    movie_cast ON actor.act_id = movie_cast.act_id
        JOIN
    movie ON movie_cast.mov_id = movie.mov_id
WHERE
    movie.mov_year NOT BETWEEN 1990 AND 2000;
    
 # 6. Write a query in SQL to list first and last name of all the directors with number of genres movies they directed with genres name, and arranged the result alphabetically with the first and last name of the director. 
 
 SELECT 
    director.dir_fname,
    director.dir_lname,
    genres.gen_title,
    COUNT(genres.gen_title) AS Movies_directed
FROM
    director
        JOIN
    movie_direction ON director.dir_id = movie_direction.dir_id
        JOIN
    movie ON movie_direction.mov_id = movie.mov_id
        JOIN
    movie_genres ON movie_genres.mov_id = movie.mov_id
        JOIN
    genres ON movie_genres.gen_id = genres.gen_id
GROUP BY director.dir_fname , director.dir_lname , genres.gen_title
ORDER BY director.dir_fname , director.dir_lname;

# 7. Write a query in SQL to list all the movies with year and genres

SELECT 
    movie.mov_title, movie.mov_year, genres.gen_title
FROM
    movie
        JOIN
    movie_genres ON movie.mov_id = movie_genres.mov_id
        JOIN
    genres ON movie_genres.gen_id = genres.gen_id;

# 8. Write a query in SQL to list all the movies with year, genres, and name of the director

SELECT 
    movie.mov_title,
    genres.gen_title,
    director.dir_fname,
    director.dir_lname
FROM
    director
        JOIN
    movie_direction ON director.dir_id = movie_direction.dir_id
        JOIN
    movie ON movie_direction.mov_id = movie.mov_id
        JOIN
    movie_genres ON movie_genres.mov_id = movie.mov_id
        JOIN
    genres ON movie_genres.gen_id = genres.gen_id;

# 9. Write a query in SQL to list all the movies with title, year, date of release, movie duration, and first and last name of the director which released before 1st january 1989, and sort the result set according to release date from highest date to lowest.

SELECT 
    movie.mov_title,
    movie.mov_year,
    movie.mov_dt_rel,
    movie.mov_time,
    director.dir_fname,
    director.dir_lname
FROM
    movie
        JOIN
    movie_direction ON movie_direction.mov_id = movie.mov_id
        JOIN
    director ON movie_direction.dir_id = director.dir_id
WHERE
    movie.mov_dt_rel < '1989-01-01'
ORDER BY movie.mov_dt_rel DESC;

# 10.  Write a query in SQL to compute a report which contain the genres of the movies with their average time and number of movies for each genres.

SELECT 
    genres.gen_title,
    ROUND(AVG(movie.mov_time), 2),
    COUNT(genres.gen_title)
FROM
    movie
        JOIN
    movie_genres ON movie.mov_id = movie_genres.mov_id
        JOIN
    genres ON genres.gen_id = movie_genres.gen_id
GROUP BY genres.gen_title;

# 11. Write a query in SQL to find those lowest duration movies along with the year, director's name, actor's name and his/her role in that production

SELECT 
    movie.mov_time,
    movie.mov_year,
    director.dir_fname,
    director.dir_lname,
    actor.act_fname,
    actor.act_lname,
    movie_cast.role
FROM
    actor
        JOIN
    movie_cast ON actor.act_id = movie_cast.act_id
        JOIN
    movie ON movie_cast.mov_id = movie.mov_id
        JOIN
    movie_direction ON movie_direction.mov_id = movie.mov_id
        JOIN
    director ON movie_direction.dir_id = director.dir_id
WHERE
    movie.mov_time = (SELECT 
            MIN(movie.mov_time)
        FROM
            movie);
            
# 12. Write a query in SQL to find all the years which produced a movie that received a rating of 3 or 4, and sort the result in increasing order

SELECT DISTINCT
    movie.mov_year
FROM
    movie
        JOIN
    rating ON movie.mov_id = rating.mov_id
WHERE
    rating.rev_stars IN (3 , 4)
ORDER BY movie.mov_year ASC;

# 13. Write a query in SQL to return the reviewer name, movie title, and stars in an order that reviewer name will come first, then by movie title, and lastly by number of stars.

SELECT 
    reviewer.rev_name, movie.mov_title, rating.rev_stars
FROM
    movie
        JOIN
    rating ON movie.mov_id = rating.mov_id
        JOIN
    reviewer ON rating.rev_id = reviewer.rev_id
WHERE
    reviewer.rev_name IS NOT NULL
ORDER BY reviewer.rev_name , movie.mov_title , rating.rev_stars;

# 14. Write a query in SQL to find movie title and number of stars for each movie that has at least one rating and find the highest number of stars that movie received and sort the result by movie title

SELECT 
    movie.mov_title, MAX(rating.rev_stars)
FROM
    movie
        JOIN
    rating ON movie.mov_id = rating.mov_id
GROUP BY movie.mov_title
HAVING MAX(rating.rev_stars) > 0
ORDER BY movie.mov_title;

# 15. Write a query in SQL to find the director's first and last name together with the title of the movie(s) they directed and received the rating

SELECT 
    director.dir_fname,
    director.dir_lname,
    movie.mov_title,
    rating.rev_stars
FROM
    director
        JOIN
    movie_direction ON movie_direction.dir_id = director.dir_id
        JOIN
    movie ON movie_direction.mov_id = movie.mov_id
        JOIN
    rating ON movie.mov_id = rating.mov_id
WHERE
    rating.rev_stars IS NOT NULL;

# 16. Write a query in SQL to find the movie title, actor first and last name, and the role for those movies where one or more actors acted in two or more movies

SELECT 
    movie.mov_title,
    actor.act_fname,
    actor.act_lname,
    movie_cast.role
FROM
    actor
        JOIN
    movie_cast ON actor.act_id = movie_cast.act_id
        JOIN
    movie ON movie_cast.mov_id = movie.mov_id
WHERE
    actor.act_id IN (SELECT 
            act_id
        FROM
            movie_cast
        GROUP BY act_id
        HAVING COUNT(*) >= 2);  
        
# 17. Write a query in SQL to find the first and last name of a director and the movie he or she directed, and the actress appeared which first name was Claire and last name was Danes along with her role in that movie.

SELECT 
    director.dir_fname,
    director.dir_lname,
    movie.mov_title,
    actor.act_fname,
    actor.act_lname,
    movie_cast.role
FROM
    director
        JOIN
    movie_direction ON movie_direction.dir_id = director.dir_id
        JOIN
    movie ON movie_direction.mov_id = movie.mov_id
        JOIN
    movie_cast ON movie_cast.mov_id = movie.mov_id
        JOIN
    actor ON movie_cast.act_id = actor.act_id
WHERE
    actor.act_fname = 'Claire'
        AND actor.act_lname = 'Danes';

# 18. Write a query in SQL to find the first and last name of an actor with their role in the movie which was also directed by themselves

SELECT 
    actor.act_fname, actor.act_lname, movie.mov_title, movie_cast.role
FROM
    actor
        JOIN
    movie_cast ON actor.act_id = movie_cast.act_id
        JOIN
    movie ON movie_cast.mov_id = movie.mov_id
        JOIN
    movie_direction ON movie_direction.mov_id = movie.mov_id
        JOIN
    director ON movie_direction.dir_id = director.dir_id
WHERE
    director.dir_fname = actor.act_fname
        AND director.dir_lname = actor.act_lname;
        
# 19. Write a query in SQL to find the cast list for the movie Chinatown

SELECT 
    actor.act_fname,
    actor.act_lname,
    movie_cast.role,
    movie.mov_title
FROM
    movie_cast
        JOIN
    movie ON movie_cast.mov_id = movie.mov_id
        JOIN
    actor ON movie_cast.act_id = actor.act_id
WHERE
    movie.mov_title = 'Chinatown';
    
# ALTERNATE SOLUTION

SELECT 
    actor.act_fname, actor.act_lname
FROM
    movie_cast c
        JOIN
    actor a ON c.act_id = a.act_id
WHERE
    mov_id = (SELECT 
            mov_id
        FROM
            movie
        WHERE
            mov_title = 'Chinatown'); 
            
# 20. Write a query in SQL to find the movie in which the actor appeared whose first and last name are 'Harrison' and 'Ford'

SELECT 
    movie.mov_title
FROM
    movie
        JOIN
    movie_cast ON movie_cast.mov_id = movie.mov_id
        JOIN
    actor ON actor.act_id = movie_cast.act_id
WHERE
    actor.act_fname = 'Harrison'
        AND actor.act_lname = 'Ford';
        
# ALTERNATE SOLUTION 

SELECT 
    m.mov_title
FROM
    movie m
        JOIN
    movie_cast c ON m.mov_id = c.mov_id
WHERE
    c.act_id IN (SELECT 
            act_id
        FROM
            actor
        WHERE
            act_fname = 'Harrison'
                AND act_lname = 'Ford');

# 21. Write a query in SQL to find the highest-rated movie, and report its title, year, rating, and releasing country.

SELECT 
    mov_title, mov_year,  mov_rel_country, rev_stars 
FROM
    movie
        NATURAL JOIN
    rating
WHERE
    rev_stars = (SELECT 
            MAX(rev_stars)
        FROM
            rating);

# 22. Write a query in SQL to find the highest-rated Mystery movie, and report the title, year, and rating.

SELECT 
    genres.gen_title,
    movie.mov_title,
    movie.mov_year,
    rating.rev_stars
FROM
    movie
        JOIN
    rating ON movie.mov_id = rating.mov_id
        JOIN
    movie_genres ON movie_genres.mov_id = rating.mov_id
        JOIN
    genres ON genres.gen_id = movie_genres.gen_id
WHERE
    genres.gen_title LIKE '%Mystery%';

# 23. Write a query in SQL to generate a report which shows the year when most of the Mystery movies produces, and number of movies and their average rating.

SELECT 
    genres.gen_title,
    movie.mov_title,
    movie.mov_year,
    COUNT(genres.gen_title),
    AVG(rating.rev_stars)
FROM
    movie
        NATURAL JOIN
    movie_genres
        NATURAL JOIN
    genres
        NATURAL JOIN
    rating
WHERE
    genres.gen_title = 'Mystery'
GROUP BY movie.mov_year , genres.gen_title;

# 24. Write a query in SQL to generate a report which contain the columns movie title, name of the female actor, year of the movie, role, movie genres, the director, date of release, and rating of that movie.

SELECT 
    mov_title,
    act_fname,
    act_lname,
    mov_year,
    role,
    gen_title,
    dir_fname,
    dir_lname,
    mov_dt_rel,
    rev_stars
FROM
    movie
        NATURAL JOIN
    movie_cast
        NATURAL JOIN
    actor
        NATURAL JOIN
    movie_genres
        NATURAL JOIN
    genres
        NATURAL JOIN
    movie_direction
        NATURAL JOIN
    director
        NATURAL JOIN
    rating
WHERE
    act_gender = 'F';