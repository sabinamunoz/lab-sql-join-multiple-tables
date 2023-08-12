use sakila;

-- 1. Write a query to display for each store its store ID, city, and country.
select store_id, city, country from store
left join address
on store.address_id = address.address_id
left join city
on address.city_id = city.city_id
left join country
on city.country_id = country.country_id;

-- 2. Write a query to display how much business, in dollars, each store brought in.
select staff.store_id, sum(amount) from payment
left join staff
on payment.staff_id = staff.staff_id
left join store
on staff.store_id = store.store_id
group by staff.store_id;


-- 3. What is the average running time of films by category?
select name, round(avg(length),2)
from film
left join film_category on film_category.film_id = film.film_id
left join category on category.category_id = film_category.category_id
group by name; 

-- 4. Which film categories are longest? (by average?? or the longest legnth of film in its category?)
-- > Sports
select name, round(avg(length),2) as length
from film
left join film_category on film_category.film_id = film.film_id
left join category on category.category_id = film_category.category_id
group by name
order by length desc;




-- select film.film_id, length, name, dense_rank() over (partition by name order by length desc) as `rank`
-- from film
-- left join film_category on film_category.film_id = film.film_id
-- left join category on category.category_id = film_category.category_id;



-- 5. Display the most frequently rented movies in descending order.
select i.film_id, f.title, count(*) as total_rent from rental r
left join inventory i on i.inventory_id=r.inventory_id
left join film f on i.film_id = f.film_id
group by i.film_id
order by total_rent desc;


-- 6. List the top five genres in gross revenue in descending order.
-- > Sports, Sci_fi, Animation, Drama, Comedy

select c.name, sum(p.amount) as revenues from payment p
left join rental r on r.rental_id = p.rental_id
left join inventory i on i.inventory_id = r.inventory_id
left join film_category fc on fc.film_id = i.film_id
left join category c on c.category_id = fc.category_id
group by c.name
order by revenues desc
limit 5;


-- 7. Is "Academy Dinosaur" available for rent from Store 1? > No
select * from rental r
left join inventory i on i.inventory_id = r.inventory_id
left join film f on f.film_id = i.film_id
where i.store_id =1 and f.title = 'Academy Dinosaur' and return_date is null;
