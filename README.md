# OLA Data Analysis using SQL and Power BI

## Project Overview  
This project analyzes OLA ride data using SQL for data extraction and transformation and Power BI for interactive visualization.  
The goal is to uncover key business insights, including ride trends, revenue analysis, cancellations, and customer ratings.  

## Dataset Description  
The dataset consists of 100,000 ride records with the following key attributes:  
- Booking ID – Unique identifier for each ride  
- Date & Time – When the ride was booked  
- Vehicle Type – Category of the vehicle used  
- Pickup & Drop Locations – Ride starting and ending points  
- Ride Distance – Distance covered per ride  
- Booking Status – Whether the ride was completed or canceled  
- Payment Method – Mode of payment used  
- Driver & Customer Ratings – Feedback scores from both parties  

## Technologies Used  
- SQL – Data extraction, aggregation, and analysis  
- Power BI – Dashboard creation and visualization   

# SQL Queries for OLA Booking Analysis  

## Database Schema and Queries  

The database consists of a **bookings** table with the following structure:  

```sql
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

-- 1. Retrieve all successful bookings:
SELECT * FROM bookings WHERE Booking_status = 'Success';

-- 2. Find the average ride distance for each vehicle type:
SELECT vehicle_type, ROUND(AVG(ride_distance),2) AS Avg_Distance 
FROM bookings 
GROUP BY vehicle_type;

-- 3. Get the total number of cancelled rides by customers:
SELECT COUNT(booking_status) AS Canceled_by_Customer_Count 
FROM bookings 
WHERE booking_status = 'Canceled by Customer';

-- 4. List the top 5 customers who booked the highest number of rides:
SELECT customer_id, COUNT(*) AS total_rides 
FROM bookings 
GROUP BY customer_id 
ORDER BY total_rides DESC 
LIMIT 5;

-- 5. Get the number of rides cancelled by drivers due to personal and car-related issues:
SELECT canceled_rides_by_driver, COUNT(*) 
FROM bookings 
WHERE canceled_rides_by_driver = 'Personal & Car related issue'
GROUP BY canceled_rides_by_driver;

-- 6. Find the maximum and minimum driver ratings for Prime Sedan bookings:
SELECT MAX(driver_ratings) AS Max_Rating, MIN(driver_ratings) AS Min_Rating 
FROM bookings 
WHERE vehicle_type = 'Prime Sedan';

-- 7. Find the total revenue generated from each payment method:
SELECT payment_method, SUM(booking_value) AS total_revenue 
FROM bookings
WHERE booking_value IS NOT NULL AND payment_method IS NOT NULL
GROUP BY payment_method 
ORDER BY total_revenue DESC;

-- 8. Identify the vehicle type with the highest average driver rating:
SELECT vehicle_type, ROUND(AVG(driver_ratings),2) AS avg_driver_rating
FROM bookings
WHERE driver_ratings IS NOT NULL
GROUP BY vehicle_type
ORDER BY avg_driver_rating DESC;

-- 9. Determine the percentage of rides that were canceled (either by the customer or driver):
SELECT ROUND((COUNT(CASE WHEN booking_status LIKE 'Canceled%' THEN 1 END) * 100.0) / COUNT(*), 2) 
AS canceled_percentage 
FROM bookings;

-- 10. Find the busiest pickup location based on the number of bookings:
SELECT pickup_location, COUNT(pickup_location) AS total_bookings 
FROM bookings 
GROUP BY pickup_location 
ORDER BY total_bookings DESC 
LIMIT 1;

## Power BI Project Dashboards

### Overall Analysis
![Overall Analysis](https://github.com/Pranesh034/OLA_SQL-Power-BI-Project/blob/main/Overall.png)

### Vehicle Type Analysis
![Vehicle Type Analysis](https://github.com/Pranesh034/OLA_SQL-Power-BI-Project/blob/main/Vehicle%20Type.png)

### Revenue Insights
![Revenue Insights](https://github.com/Pranesh034/OLA_SQL-Power-BI-Project/blob/main/Revenue.png)

### Ride Cancellation Trends
![Ride Cancellation Trends](https://github.com/Pranesh034/OLA_SQL-Power-BI-Project/blob/main/Cancellation.png)

### Driver Ratings Overview
![Driver Ratings Overview](https://github.com/Pranesh034/OLA_SQL-Power-BI-Project/blob/main/Ratings.png)




## Key Insights  
- Revenue: Majority of the revenue is generated through online payments.  
- Ride Trends: Prime Sedan is the most booked vehicle type.  
- Cancellations: Customer-related issues contribute to most ride cancellations.  
- Customer Satisfaction: Driver ratings vary based on vehicle type and location.  
