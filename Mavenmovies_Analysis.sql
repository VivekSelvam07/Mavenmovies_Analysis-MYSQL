# WEEK 3 - MANDATORY PROJECT

# 1. Write a SQL query to count the number of characters except for the spaces for each actor. 
#    Return the first 10 actor's name lengths along with their names.
# Already imported mavenmovies database
USE mavenmovies;
SHOW TABLES;
SELECT * FROM actor;

SELECT actor_id, CONCAT(first_name,' ',last_name) AS actor_fullname, 
LENGTH(CONCAT(first_name,'',last_name)) AS length_actor_fullname
From actor
LIMIT 10;
#########################################################################################################################################
# 2. List all Oscar awardees(Actors who received the Oscar award) with their full names and the length of their names.
# Already imported mavenmovies database
USE mavenmovies;
SHOW TABLES;
SELECT * FROM actor_award;
SELECT * FROM actor_award WHERE awards LIKE '%Oscar%';

SELECT CONCAT(first_name,' ',last_name) AS Oscar_awardees_Fullnames, 
LENGTH(CONCAT(first_name,' ',last_name)) AS Length_Names, awards
FROM actor_award
WHERE awards LIKE '%Oscar%';
##################################################################################################################################
# 3. Find the actors who have acted in the film ‘Frost Head’
# Already imported mavenmovies database
USE mavenmovies;
SHOW TABLES;
SELECT * FROM actor;
SELECT * FROM film_actor;
SELECT * FROM film_text;

SELECT actor.actor_id, actor.first_name, actor.last_name,Inter_table1.title FROM
(SELECT film_actor.actor_id, film_actor.film_id, film_text.title FROM film_actor
LEFT JOIN film_text ON film_actor.film_id = film_text.film_id) AS Inter_table1
LEFT JOIN actor ON Inter_table1.actor_id = actor.actor_id
WHERE Inter_table1.title ='FROST HEAD';
##############################################################################################################################
# 4. Pull all the films acted by the actor ‘Will Wilson’
# Already imported mavenmovies database
USE mavenmovies;
SHOW TABLES;
SELECT * FROM actor;
SELECT * FROM film_actor;
SELECT * FROM film_text;

SELECT Inter_table2.title, Inter_table2.Actor_name FROM
(SELECT Inter_table1.title, concat(first_name,' ',last_name) AS Actor_name FROM
(SELECT film_actor.actor_id, film_text.title FROM film_actor
LEFT JOIN film_text ON film_actor.film_id = film_text.film_id) AS Inter_table1
LEFT JOIN actor ON actor.actor_id = Inter_table1.actor_id) AS Inter_table2
WHERE Inter_table2.Actor_name ='Will Wilson';
########################################################################################################################
# 5. Pull all the films which were rented and return them in the month of May
# Already imported mavenmovies database
USE mavenmovies;
SHOW TABLES;
SELECT * FROM rental LIMIT 10000;
SELECT * FROM inventory;
SELECT * FROM film_text;

SELECT Inter_table2.rental_id, Inter_table2.title, Inter_table2.rental_date, Inter_table2.return_date, 
Inter_table2.rental_date_month, Inter_table2.return_date_month FROM
(SELECT rental.rental_id, Inter_table1.title, rental.rental_date, rental.return_date, MONTHNAME(rental.rental_date) 
AS rental_date_month, MONTHNAME(rental.return_date) AS return_date_month FROM
(SELECT inventory.inventory_id, film_text.title FROM inventory
LEFT JOIN film_text ON inventory.film_id = film_text.film_id) AS Inter_table1
LEFT JOIN rental ON rental.inventory_id = Inter_table1.inventory_id) AS Inter_table2
WHERE Inter_table2.rental_date_month = 'May' AND Inter_table2.return_date_month = 'May';
#################################################################################################################################
# 6. Pull all the films with ‘Comedy’ category
# Already imported mavenmovies database
USE mavenmovies;
SHOW TABLES;
SELECT * FROM category;
SELECT * FROM film_category;
SELECT * FROM film_text;

SELECT * FROM
(SELECT Inter_table1.title, category.name FROM
(SELECT film_category.category_id, film_text.title FROM film_category
LEFT JOIN film_text ON film_category.film_id = film_text.film_id) AS Inter_table1
LEFT JOIN category ON category.category_id = Inter_table1.category_id) AS Inter_table2
WHERE Inter_table2.name ='Comedy';
#################################################################################################################################