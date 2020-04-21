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

create index last_name_ind on customer(last_name);
create index phone_ind on customer(phone);


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
create index car_model_ind on cars(car_model);

drop table if exists reservation;
create table reservation
(
    reservation_id       bigint not null primary key,
    reservation_car_id   bigint,
    reservation_datetime datetime,
    reservation_customer_id bigint,
    constraint reservation_car_id_fk
        foreign key (reservation_car_id) references cars (car_id),
    constraint reservation_customer_id_fk
        foreign key (reservation_customer_id) references customer(customer_id)

);

drop table if exists maintenance;
create table maintenance
(
    maintenance_id     bigint not null primary key,
    maintenance_car_id bigint,
    start_date         date,
    stop_date          date,
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
















