CREATE TABLE bookings (
    Date TIMESTAMP, 
    Time TIME,
    Booking_ID VARCHAR(20) PRIMARY KEY,
    Booking_Status VARCHAR(50),
    Customer_ID VARCHAR(20),
    Vehicle_Type VARCHAR(50),
    Pickup_Location VARCHAR(100),
    Drop_Location VARCHAR(100),
    V_TAT INT NULL,
    C_TAT INT NULL,
    Canceled_Rides_by_Customer VARCHAR(50) NULL,
    Canceled_Rides_by_Driver VARCHAR(50) NULL,
    Incomplete_Rides VARCHAR(10) NULL,
    Incomplete_Rides_Reason TEXT NULL,
    Booking_Value NUMERIC(10,2) NULL,
    Payment_Method VARCHAR(50) NULL,
    Ride_Distance NUMERIC(10,2) NULL,
    Driver_Ratings NUMERIC(3,1) NULL,
    Customer_Rating NUMERIC(3,1) NULL,
    Vehicle_Images TEXT NULL
);



COPY bookings 
FROM 'C:\Users\Harish\Downloads\Bookings-100000-Rows.csv' 
WITH CSV HEADER DELIMITER ',' NULL 'null';


select count(Booking_ID) from bookings;



-- 1.	Retrieve all successful bookings:

select * from bookings where Booking_status = 'Success';

-- 2.	Find the average ride distance for each vehicle type:

select vehicle_type, round(avg (ride_distance),2) Avg_Distance from bookings group by vehicle_type;

-- 3.	Get the total number of cancelled rides by customers:

select count(booking_status) Canceled_by_Customer_Count 
from bookings where booking_status = 'Canceled by Customer';

-- 4.	List the top 5 customers who booked the highest number of rides:

select customer_id, count (*) total_rides from bookings 
group by customer_id order by total_rides desc limit 5;

-- 5.	Get the number of rides cancelled by drivers due to personal and car-related issues:

select canceled_rides_by_driver, count(*) from bookings 
where canceled_rides_by_driver = 'Personal & Car related issue'
group by canceled_rides_by_driver;


-- 6.	Find the maximum and minimum driver ratings for Prime Sedan bookings:

select max(driver_ratings) Max_Rating, min(driver_ratings) Min_Rating 
from bookings where vehicle_type = 'Prime Sedan';

-- 7. Find the total revenue generated from each payment method:

select payment_method, sum(booking_value) as total_revenue from bookings
where booking_value is not null and payment_method is not null
group by payment_method order by total_revenue desc;


-- 8. Identify the vehicle type with the highest average driver rating:

select vehicle_type, round(avg(driver_ratings),2) as avg_driver_rating
from bookings
where driver_ratings is not null
group by vehicle_type
order by avg_driver_rating desc;


-- 9. Determine the percentage of rides that were canceled (either by the customer or driver):

select 
round((count(case when booking_status like 'Canceled%' then 1 end) * 100.0) / count(*), 2) 
as canceled_percentage from bookings;

-- 10. Find the busiest pickup location based on the number of bookings:

select pickup_location, count(pickup_location) total_bookings from bookings 
group by pickup_location order by total_bookings desc limit 1;
