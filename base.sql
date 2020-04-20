drop database if exists base;
create database base;
use base;
drop table if exists customer;
create table customer
(
    customer_id     bigint not null auto_increment primary key,
    first_name      varchar(100),
    last_name       varchar(100),
    phone           varchar(20),
    address         varchar(100),
    country         varchar(100),
    birthday        date,
    passport_serial varchar(10),
    passport_number varchar(15)

);

drop table if exists car_types;
create table car_types
(
    type_id   bigint not null,
    type_name varchar(100),
    primary key (type_id)
);
drop table if exists car_brand;
create table car_brand
(
    car_brand_id     bigint not null,
    car_brand_name   varchar(100),
    car_country_prod varchar(100),
    primary key (car_brand_id)
);

drop table if exists car_status;
create table car_status
(

    status_id tinyint not null primary key,
    status    varchar(20)
);
drop table if exists car_service;
create table car_service
(
    service_id           bigint not null primary key,
    service_name         varchar(100),
    service_phone_number varchar(100),
    service_address      varchar(100)
);



drop table if exists `cars`;
create table `cars`
(
    car_id            bigint NOT NULL unique primary key,
    car_brand_name_id bigint not null,
    car_model         varchar(100),
    plate_number      varchar(100),
    car_release_date  date,
    car_type_id       bigint not null,
    car_transmission  varchar(100),
    car_fuel_type     varchar(100),
    car_mileage       int(7),
    car_rent_cost     int(5),
    car_status_id     tinyint(1),

    constraint car_type_id_fr
        foreign key (car_type_id) references car_types (type_id),
    constraint car_brand_name_id_fr
        foreign key (car_brand_name_id) references car_brand (car_brand_id),
    constraint car_status_id_fk
        foreign key (car_status_id) references car_status (status_id)
);

drop table if exists reservation;
create table reservation
(
    reservation_id       bigint not null primary key,
    reservation_car_id   bigint,
    reservation_datetime datetime,
    constraint reservation_car_id_fk
        foreign key (reservation_car_id) references cars (car_id)

);
drop table if exists maintenance;
create table maintenance
(
    maintenance_id     bigint not null primary key,
    maintenance_car_id bigint,
    start_date         datetime,
    stop_date          datetime,
    car_service_id     bigint,
    constraint maintenance_car_id_fk
        foreign key (maintenance_car_id) references cars (car_id),
    constraint maintenance_car_service_id_fk
        foreign key (car_service_id) references car_service (service_id)


);

drop table if exists rent;
create table rent
(

    rent_id     bigint not null auto_increment primary key unique,
    customer_id bigint,
    rent_car_id bigint,
    start_date  datetime,
    stop_date   datetime,
    constraint rent_customer_id_fk
        foreign key (customer_id) references customer (customer_id),
    constraint rent_car_id_fk
        foreign key (rent_car_id) references cars (car_id)

);

insert into car_service (service_id, service_name, service_phone_number, service_address) value
    (1, 'Леон-авто', '+79234853476' , 'Амурская 9'),
    (2, 'Темп','+78433768271','Пологая 5'),
    (3, 'Желтый бокс','+76543267181','Жигура 3а'),
    (4, 'Айр-авто','+76326221788','Победы 5');

insert into car_status (status_id, status) value (0, 'Свободна'),
    (1, 'В работе'),
    (2, 'Бронь'),
    (3, 'В сервисе');

insert into car_types (type_id, type_name) value (1, 'SUV'),
    (2, 'Truck'),
    (3, 'Sedan'),
    (4, 'Coupe'),
    (5, 'Wagon'),
    (6, 'Sports Car'),
    (7, 'Crossover'),
    (8, 'Van'),
    (9, 'Luxury Car');

insert into car_brand (car_brand_id, car_brand_name, car_country_prod) value (1, 'Toyota', 'Japan'),
    (2, 'Nissan', 'Japan'),
    (3, 'Honda', 'Japan'),
    (4, 'Suzuki', 'Japan'),
    (5, 'BMW', 'Germany'),
    (6, 'Audi', 'Germany'),
    (7, 'Mercedes', 'Germany'),
    (8, 'Volvo', 'Germany'),
    (9, 'Volkswagen', 'Germany'),
    (10, 'Jaguar', 'UK'),
    (11, 'RangeRover', 'UK'),
    (12, 'Ford', 'USA'),
    (13, 'Dodge', 'USA'),
    (14, 'Chevrolet', 'USA'),
    (15, 'Cadillac', 'USA'),
    (16, 'KIA', 'Korea'),
    (17, 'Daewoo', 'Korea');

insert into customer value (1, 'Петр', 'Иванов', '+79233458714', 'Новосибирск ул.Васюкова 13 кв.3', 'Россия',
                            '1977-05-02',0492,657837),
    (2, 'Кирил', 'Звиганов', '+7765796847', 'Хабаровск ул.Злыдня 53 кв.23', 'Россия', '1967-01-22',6372,567837),
    (3, 'Михаил', 'Пирогов', '+7265756848', 'Земск ул.Окатовая 3 кв.3', 'Россия', '1987-11-02',7591,654271),
    (4, 'Евгений', 'Каримов', '+7165756842', 'Холмск ул.Печерская 91 кв.91', 'Россия', '1979-03-02',7832,983718),
    (5, 'Трофим', 'Бодров', '+7765956843', 'Владивосток ул.Суханова 11 кв.1', 'Россия', '1951-03-12',7321,987632),
    (6, 'Дмитрий', 'Картавый', '+7565756844', 'Корсаков ул.Русская 12 кв.34', 'Россия', '1968-04-01',4764,426872),
    (7, 'Сергей', 'Ильин', '+7566392844', 'Тула ул.Покровская 15 кв.14', 'Россия', '1998-09-01',3364,666872),
    (8, 'Михаил', 'Прокопенко', '+7837465055', 'Петрозаводск ул.Жмыха 312 кв.134', 'Россия', '1955-11-08',4555,126333),
    (9, 'Роман', 'Песков', '+7333752673', 'Ильинск ул.Ленина 92 кв.99', 'Россия', '1999-12-12',6664,127342),
    (10, 'Тимофей', 'Родионов', '+7678756811', 'Новосибирск ул.Алеутская 212 кв.77', 'Россия', '1979-06-07',5564,556899),
    (11, 'Дмитрий', 'Колобасов', '+7767752291', 'Иркутск ул.Светланская 152 кв.14', 'Россия', '1988-09-03',1188,776833),
    (12, 'Семен', 'Слепаков', '+7432756712', 'Челябинск ул.Юмашева 312 кв.11', 'Россия', '1991-08-08',1164,426774);

insert into cars value (1, 1, 'Crown', 'х432ке777', '2016-02-01', 3, 'AT', 'Gasoline', 50321, 500, 0),
    (2, 3, 'Sunny', 'у756рх125', '2011-12-05', 3, 'AT', 'Gasoline', 120321, 200,1),
    (3, 2, 'Sunny', 'у756рх125', '2011-12-05', 3, 'AT', 'Gasoline', 120321, 200,1),
    (4, 2, 'M3', 'н666ре775', '2001-11-05', 3, 'AT', 'Gasoline', 10321, 700,1),
    (5, 3, 'CR-V', 'с706са775', '2014-02-05', 7, 'AT', 'Gasoline', 220321, 400,1),
    (6, 16, 'Rio', 'р601со777', '2019-12-01', 3, 'AT', 'Gasoline', 70345, 200,0),
    (7, 16, 'Rio', 'р611со777', '2019-12-02', 3, 'AT', 'Gasoline', 80355, 200,3),
    (8, 16, 'Rio', 'р612со777', '2019-12-01', 3, 'AT', 'Gasoline', 60211, 200,0),
    (9, 16, 'Rio', 'р613со777', '2019-12-02', 3, 'AT', 'Gasoline', 83312, 200,0),
    (10, 1, 'Crown', 'х123см125', '2015-02-01', 3, 'AT', 'Gasoline', 180432, 400,3),
    (11, 12, 'Mondeo', 'е101ее777', '2018-10-01', 3, 'AT', 'Gasoline', 280766, 300,1),
    (12, 16, 'Accord', 'а789ее125', '2017-04-01', 3, 'AT', 'Gasoline', 177354, 300,0),
    (13, 1, 'LandCruiserPrado', 'в899аа124', '2015-06-01', 3, 'AT', 'Diesel', 277333, 700,0),
    (14, 16, 'Pajero', 'c999ca69', '2018-11-01', 3, 'AT', 'Diesel', 77121, 600,1);


select car_model,car_brand_name,status
from cars
    left join car_brand on (car_brand_name_id=car_brand_id)
#
# #          left join car_status
# #                    on(status_id=3)
#     left join car_service on(service_id=car_service_id);
#
#






