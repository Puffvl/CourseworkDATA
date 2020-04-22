#Список зарезервированных авто
#Имя ,Фамилия ,Марка ,Модель ,зарезервированная дата начала аренды
select first_name, last_name, car_brand_name, car_model, reservation_datetime
from reservation
         left join customer c on reservation.reservation_customer_id = c.customer_id
         left join cars car on reservation.reservation_car_id = car.car_id
         left join car_brand br on car_brand_name_id = br.car_brand_id;

#Список свободных авто
#Марка ,Модель ,Гос.номер
select (select car_brand_name from car_brand where car_brand_name_id = car_brand_id) as br,
       car_model,
       plate_number
from cars
where car_status_id = 0;

#Список авто в ремонте
#Марка, Модель, Название автосервиса, дата начала ремонта, дата окончания
select car_brand.car_brand_name, cars.car_model, car_service.service_name, start_date, stop_date
from cars,
     car_service,
     maintenance,
     car_brand
where service_id = car_service_id
  and maintenance_car_id = car_id
  and car_brand_name_id = car_brand_id;

#Список авто в аренде
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
limit 1;



#Представление 1
#Список всех автомобилей со статусами
create view view_one as
select car_brand_name, car_model, car_fuel_type, car_transmission, status
from car_brand,
     cars,
     car_status
where car_brand_name_id = car_brand_id
  and car_status_id = status_id;

#Представление 2
#Список автомобилей в аренде
create view view_two as
select car_brand_name, car_model, last_name, first_name, start_date
from car_brand,
     customer,
     cars,
     rent
where car_brand_id = car_brand_name_id
  and rent_car_id = car_id
  and rent.customer_id = customer.customer_id
  and stop_date is NULL;

#Триггер следит что бы дата окончания аренды не была меньше и не больше текущей даты.
drop trigger insert_stop_date;
delimiter //
create trigger insert_stop_date
    before update
    on rent
    for each row
begin
    if new.stop_date <> current_date() then
        signal sqlstate '45001' set message_text = 'Некорректная дата !';
    end if;
end //
delimiter ;

update rent
set stop_date='2020-04-23'
where rent_car_id = 2
  and customer_id = 11;


#Триггер следит что бы не было клиетов с одинаковыми номерами паспортов
drop trigger insert_new_customer;
delimiter //
create trigger insert_new_customer
    before insert
    on customer
    for each row
begin
    if new.passport_number in (select passport_number from customer)  then
        signal sqlstate '45002' set message_text = 'Такой клиент уже есть !';
    end if;
end //
delimiter ;

insert customer(customer_id, first_name, last_name, phone, address, country,
                birthday, passport_serial, passport_number)
value (13,'Сергей','Бочкарев','+79145873672','г.Тула','Россия','1988-02-05',0309,987632);












