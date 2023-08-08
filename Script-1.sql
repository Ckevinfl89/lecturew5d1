--Week 5 - Monday Questions
--1. How many actors are there with the last name ‘Wahlberg’?
SELECT *
FROM actor  
WHERE last_name like '%Wahlberg%';

SELECT count(*)
FROM actor a 
WHERE last_name LIKE '%Wahlberg%'
--answer = 2;

--2. How many payments were made between $3.99 and $5.99?
SELECT count(*) AS payment
FROM payment
WHERE amount BETWEEN 3.99 AND 5.99;
--answer 5607

--3. What films have exactly 7 copies? (search in inventory)
SELECT count(*)
FROM inventory
WHERE film_id = '7'
--answer  title                      
---------------------------
--Stepmom Dream              
--Minds Truman               
--Closer Bang                
--Sleeping Suspects          
--None Spiking               
--Double Wrath               
--Wonderland Christmas       
--Witches Panic              
--Chance Resurrection        
--Forrester Comancheros      
--Trading Pinocchio          
--Graffiti Love              
--Suspects Quills            
--Robbers Joon               
--Westward Seabiscuit        
--Coneheads Smoochy          
--Intrigue Worst             
--Head Stranger              
--Deceiver Betrayed          
--Fatal Haunted              
--Jason Trap                 
--Arachnophobia Rollercoaster
--Island Exorcist            
--Affair Prejudice           
--Massacre Usual             
--Dorado Notting             
--Flamingos Connecticut      
--Pelican Comforts           
--Sabrina Midnight           
--Star Operation             
--Pianist Outfield           
--Mallrats United            
--Armageddon Lost            
--Half Outfield              
--Oscar Gold                 
--Lies Treatment             
--Knock Warlock              
--Fiction Christmas          
--Princess Giant             
--Fish Opus                  
--South Wait                 
--Blackout Private           
--Coma Head                  
--Patton Interview           
--Strangelove Desire         
--Heartbreakers Bright       
--Maltese Hope               
--Hurricane Affair           
--Nightmare Chill            
--Shootist Superfly          
--Hanky October              
--Shepherd Midsummer         
--Arizona Bang               
--Alaska Phantom             
--Earth Vision               
--Telegraph Voyage           
--Clueless Bucket            
--Slums Duck                 
--Gangs Pride                
--Tracy Cider                
--Disturbing Scarface        
--Videotape Arsenic          
--English Bulworth           
--Chill Luck                 
--Malkovich Pet              
--Amistad Midsummer          
--Reign Gentlemen            
--Tights Dawn                
--Downhill Enough            
--Aladdin Calendar           
--Basic Easy                 
--Orange Grapes              
--Contact Anonymous          
--Sun Confessions            
--Steel Santa                
--Effect Gladiator           
--Splendor Patton            
--Alamo Videotape            
--Ice Crossing               
--Wrong Behavior             
--Fireball Philadelphia      
--Talented Homicide          
--Egg Igby                   
--Pocus Pulp                 
--Voyage Legally             
--Money Harold               
--Carrie Bunch               
--Women Dorado               
--Strictly Scarface          
--Redemption Comforts        
--Titanic Boondock           
--Range Moonwalker           
--Enemy Odds                 
--Camelot Vacation           
--Undefeated Dalmations      
--Campus Remember            
--Jerk Paycheck              
--Snatch Slipper             
--Scorpion Apollo            
--Atlantis Cause             
--Timberland Sky             
--Goldmine Tycoon            
--Grapes Fury                
--Goldfinger Sensibility     
--Intentions Empire          
--Durham Panky               
--Caper Motions              
--Clash Freddy               
--Idols Snatchers            
--Snowman Rollercoaster      
--Story Side                 
--Calendar Gunfight          
--Tomorrow Hustler           
--River Outlaw               
--Detective Vision           
--Samurai Lion               

--WHERE rental_duration = 7;
SELECT film.title
FROM film 
JOIN inventory AS i ON film.film_id = i.film_id
GROUP BY film.title
HAVING COUNT(*) = 7;

SELECT  film_id , count(inventory_id) as total_inventory 
FROM inventory 
GROUP BY film_id 
HAVING count(film_id)=7

--4. How many customers have the first name ‘Willie’?
SELECT *
FROM customer
WHERE first_name = 'Willie';

--answer = 2

--5. What store employee (get the id) sold the most rentals (use the rental table)?
SELECT  COUNT(rental) AS rental_count 
FROM rental
WHERE staff_id = '1';
---answer = employee id 1 (Mike Hillyer) 8040 rentals
    ---     employee id 2 8004
SELECT staff_id, COUNT(*) AS rental_count
FROM rental 
GROUP BY staff_id
ORDER BY rental_count DESC;
--6. How many unique district names are there?
SELECT COUNT(DISTINCT district) AS unique_district_count
FROM address;
--answer= 378

--7. What film has the most actors in it? (use film_actor table and get film_id)
SELECT film_id, COUNT(*) AS actor_count
FROM film_actor 
GROUP BY film_id
ORDER BY actor_count DESC;
--answer FILM_ID 508 'Lambs Cincinatti' 15

SELECT film_id, COUNT(actor_id) AS number_of_actors
FROM film_actor
GROUP BY film_id
ORDER BY number_of_actors DESC;

SELECT count(film_id) AS films, film_id
FROM film_actor 
GROUP BY  film_id 
ORDER BY  films DESC;



--8. From store_id 1, how many customers have a last name ending with ‘es’? (use customer table)
SELECT COUNT(*) 
FROM customer
WHERE store_id = 1 AND last_name LIKE '%es';
---answer 13

--9. How many payment amounts (4.99, 5.99, etc.) had a number of rentals above 250 for customers
--SELECT customer_id, count(*), sum (amount) AS total_spend
--FROM payment
--WHERE customer_id BETWEEN 380 AND 430
--GROUP BY customer_id
--HAVING count(amount) >250
--ORDER BY total_spend DESC


SELECT amount, count(*)
FROM payment
where customer_id BETWEEN 380 AND 430
GROUP BY amount
HAVING count(*) > 250;

--answer 3 payment amounts 
--amount|count|
--------+-----+
--  2.99|  290|
--  4.99|  281|
--  0.99|  268|



--with ids between 380 and 430? (use group by and having > 250)

--10. Within the film table, how many rating categories are there? And what rating has the most
--movies total?
-- Number of rating categories
SELECT count(*), rating 
FROM film
GROUP BY rating
ORDER BY rating desc


--answer
--count|rating|
-------+------+
--  210|NC-17 |
--  195|R     |
--  223|PG-13 |
--  194|PG    |
--  178|G     |
