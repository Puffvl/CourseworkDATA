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

#Марка, Модель, Название автосервиса, дата начала ремонта, дата окрнчания
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





