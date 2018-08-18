##1a
use sakila;
select first_name, last_name from actor;
##1b
select concat(first_name," ", last_name) as Actor_Name
from actor;
##2a
select actor_id, first_name, last_name from actor where first_name = "Joe";
##2b
select first_name, last_name from actor where last_name like "%GEN%";
##2c
select first_name, last_name from actor where last_name like "%LI%" order by last_name, first_name;
##3a
alter table actor
add column description blob(30);
##3b
alter table actor
drop column description;
##4a
select last_name, count(*) from actor group by last_name;
##4b
select last_name, count(*) from actor group by last_name having count(*) >= 2;
##4c
update actor set first_name = 'HARPO' where first_name ='GROUCHO' and last_name = 'WILLIAMS';
##4d
update actor set first_name = 'GROUCHO' where first_name = 'HARPO' and last_name = 'WILLIAMS';
##5a
show create table address;
##6a
select first_name, last_name, address from staff 
left join 
address on staff.address_id = address.address_id;
##6b;
select staff.first_name, staff.last_name, sum(payment.amount) as total_amount from payment  
right join 
staff on payment.staff_id = staff.staff_id where payment.payment_date like "%2005-08%" group by payment.staff_id; 
##6c
select film.title, count(film_actor.actor_id) as numbers_of_actors from film_actor
inner join 
film on film_actor.film_id = film.film_id group by film_actor.film_id;
##6d
select film.title, count(inventory.inventory_id) as copies from film
inner join
inventory on film.film_id = inventory.film_id where film.title = 'Hunchback Impossible';
##6e
select customer.first_name, customer.last_name, sum(payment.amount) as total_amount_per_customer from payment
inner join 
customer on payment.customer_id = customer.customer_id group by customer.customer_id order by first_name, last_name;
##7a
select film.title, language.name as language from film
left join
language on film.language_id = language.language_id where film.title like "K%" or film.title like "Q%" and language.name = 'English';
##7b
select film.title, actor.first_name, actor.last_name 
from film_actor
inner join 
film on film_actor.film_id = film.film_id 
inner join
actor on film_actor.actor_id = actor.actor_id where film.title = 'Alone Trip';
##7c
select customer.first_name, customer.last_name, customer.email, country.country
from customer
inner join
address on customer.address_id = address.address_id
inner join
city on address.city_id = city.city_id
inner join
country on city.country_id = country.country_id where country.country = 'Canada';
##7d
select film.title 
from film
inner join 
film_category on film.film_id = film_category.film_id
inner join
category on film_category.category_id = category.category_id where category.name = 'Family';
##7e
select film.title, count(rental.customer_id) as total_rental_count
from film
inner join
inventory on film.film_id = inventory.film_id
inner join 
rental on inventory.inventory_id = rental.inventory_id group by inventory.inventory_id order by count(rental.customer_id) desc; 
##7f
select staff.store_id, sum(payment.amount) as total_revenue_in_USD
from payment
inner join
staff on payment.staff_id = staff.staff_id group by payment.staff_id;
##7g
select store.store_id, city.city, country.country
from store
inner join
address on store.address_id = address.address_id
inner join
city on address.city_id = city.city_id
inner join
country on city.country_id = country.country_id;
##7h
select category.name, sum(payment.amount) as each_genre_rental_count
from category
join 
film_category on category.category_id = film_category.category_id
join 
inventory on film_category.film_id = inventory.film_id
join
rental on inventory.inventory_id = rental.inventory_id
join
payment on payment.rental_id = rental.rental_id group by category.name order by each_genre_rental_count desc limit 5;
##8a
create view top_five_genres as
select category.name, sum(payment.amount) as each_genre_rental_count
from category
join 
film_category on category.category_id = film_category.category_id
join 
inventory on film_category.film_id = inventory.film_id
join
rental on inventory.inventory_id = rental.inventory_id
join
payment on payment.rental_id = rental.rental_id group by category.name order by each_genre_rental_count desc limit 5;
##8b
select * from top_five_genres;
##8c
drop view top_five_genres;

