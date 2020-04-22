#Имя ,Фамилия ,Марка ,Модель ,зарезервированная дата начала аренды
select first_name, last_name, car_brand_name, car_model, reservation_datetime
from reservation
         left join customer c on reservation.reservation_customer_id = c.customer_id
         left join cars car on reservation.reservation_car_id = car.car_id
         left join car_brand br on car_brand_name_id = br.car_brand_id;

#Марка ,Модель ,Гос.номер
select (select car_brand_name from car_brand where car_brand_name_id = car_brand_id) as br,
       car_model,
       plate_number
from cars
where car_status_id = 0;

#Марка, Модель, Название автосервиса, дата начала ремонта, дата окончания
select car_brand.car_brand_name, cars.car_model, car_service.service_name, start_date, stop_date
from cars,
     car_service,
     maintenance,
     car_brand
where service_id = car_service_id
  and maintenance_car_id = car_id
  and car_brand_name_id = car_brand_id;

#Имя ,Фамилия ,Марка ,Модель ,Дата начала аренды
select first_name, last_name, car_brand_name, car_model, start_date
from customer
         join rent on customer.customer_id = rent.customer_id
         join cars on rent.rent_car_id = cars.car_id
         join car_brand on cars.car_brand_name_id = car_brand.car_brand_id
where stop_date is NULL;


#Кто последний и когда брал в аренду авто с номером е506хх125
select first_name, last_name, stop_date
from rent,
     customer,
     cars
where car_id = rent_car_id
  and plate_number = 'е506хх125'
order by stop_date
    desc
limit 1
;



#Представление 1
create view view_one as
select car_brand_name, car_model, car_fuel_type, car_transmission, status
from car_brand,
     cars,
     car_status
where car_brand_name_id = car_brand_id
  and car_status_id = status_id;

select *
from view_one;

#Представление 2
create view view_two as
select first_name, last_name, car_brand_name, car_model
from view_one,
     customer,
     cars


where status = 'в работе';

select *
from view_two;

drop view view_two;







