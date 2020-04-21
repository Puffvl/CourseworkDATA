select reservation_datetime, first_name , last_name ,car_model ,car_brand_name from reservation
left join customer c on reservation.reservation_customer_id = c.customer_id
left join cars car on reservation.reservation_car_id=car.car_id
left join car_brand br on car_brand_name_id = br.car_brand_id;


select car_model ,plate_number ,(select car_brand_name from car_brand where car_brand_name_id=car_brand_id)
from cars where car_status_id=0;


