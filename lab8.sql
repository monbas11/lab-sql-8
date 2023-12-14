
-- Rank films by length 
select title, length, rank() over (order by length desc) as 'Rank'
from film
where length <> ' ' and  length > 0;

-- Rank films by length within the rating category
select title, rating, length, rank() over (partition by rating order by length desc ) as 'Rank'
from film
where length <> ' ' and  length > 0
group by rating, title, length
order by rating desc;


-- How many films are there for each of the categories in the category table? Hint: Use appropriate join between the tables "category" and "film_category".
select a.category_id, l.name as category, count (a.category_id) as film_count
from sakila.film_category a
join sakila.category l on a.category_id = l.category_id
group by a.category_id, l.name;

-- Which actor has appeared in the most films? Hint: You can create a join between the tables "actor" and "film actor" and count the number of times an actor appears.
select a.actor_id, a.first_name, a.last_name, count(l.film_id) as film_count
from actor a
join film_actor l on a.actor_id = l.actor_id
group by a.actor_id, a.first_name, a.last_name
order by film_count desc
limit 1;

-- Which is the most active customer (the customer that has rented the most number of films)? Hint: Use appropriate join between the tables "customer" and "rental" and count the rental_id for each customer.
select a.customer_id, count(*) as rental_count
from rental a
join customer l on a.customer_id = l.customer_id
group by a.customer_id
order by rental_count desc
limit 1;

-- Which is the most rented film? (The answer is Bucket Brotherhood).
select a.film_id, a.title, count(d.rental_id) as rental_count
from film a
join inventory l on a.film_id = l.film_id
join rental d on l.inventory_id = d.inventory_id
group by a.film_id, a.title
order by rental_count desc
limit 1;
