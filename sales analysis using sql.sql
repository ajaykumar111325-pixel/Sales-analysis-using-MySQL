create database sale_analysis;
use sale_analysis;
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(50)
);

INSERT INTO Customers VALUES
(1,'Amit Sharma','Delhi'),
(2,'Rohit Verma','Mumbai'),
(3,'Priya Singh','Lucknow'),
(4,'Neha Gupta','Pune'),
(5,'Rahul Yadav','Patna'),
(6,'Sneha Kapoor','Delhi'),
(7,'Ankit Mishra','Kanpur'),
(8,'Pooja Jain','Jaipur'),
(9,'Vikas Mehta','Surat'),
(10,'Karan Malhotra','Chandigarh');

CREATE TABLE Sales (
    sale_id INT PRIMARY KEY,
    customer_id INT,
    product_name VARCHAR(50),
    category VARCHAR(50),
    quantity INT,
    price INT,
    sale_date DATE
);

INSERT INTO Sales VALUES
(1,1,'Laptop','Electronics',1,55000,'2024-01-02'),
(2,2,'Mobile','Electronics',2,20000,'2024-01-03'),
(3,3,'Keyboard','Electronics',3,1500,'2024-01-04'),
(4,4,'Mouse','Electronics',2,700,'2024-01-05'),
(5,5,'Headphones','Electronics',1,2500,'2024-01-06'),
(6,6,'Tablet','Electronics',1,18000,'2024-01-07'),
(7,7,'Monitor','Electronics',1,12000,'2024-01-08'),
(8,8,'Printer','Electronics',1,9000,'2024-01-09'),
(9,9,'Camera','Electronics',1,30000,'2024-01-10'),
(10,10,'Speaker','Electronics',2,4000,'2024-01-11'),

(11,1,'Shoes','Fashion',2,2500,'2024-01-12'),
(12,2,'T-Shirt','Fashion',3,800,'2024-01-13'),
(13,3,'Jeans','Fashion',2,1800,'2024-01-14'),
(14,4,'Jacket','Fashion',1,3500,'2024-01-15'),
(15,5,'Watch','Fashion',1,5000,'2024-01-16'),
(16,6,'Bag','Fashion',2,1500,'2024-01-17'),
(17,7,'Cap','Fashion',3,500,'2024-01-18'),
(18,8,'Sunglasses','Fashion',1,2200,'2024-01-19'),
(19,9,'Belt','Fashion',2,900,'2024-01-20'),
(20,10,'Wallet','Fashion',1,1200,'2024-01-21'),

(21,1,'Book','Stationery',4,400,'2024-01-22'),
(22,2,'Pen','Stationery',10,20,'2024-01-23'),
(23,3,'Notebook','Stationery',5,100,'2024-01-24'),
(24,4,'Marker','Stationery',3,80,'2024-01-25'),
(25,5,'Stapler','Stationery',1,250,'2024-01-26'),
(26,6,'File','Stationery',6,60,'2024-01-27'),
(27,7,'Diary','Stationery',2,300,'2024-01-28'),
(28,8,'Highlighter','Stationery',4,70,'2024-01-29'),
(29,9,'Envelope','Stationery',10,10,'2024-01-30'),
(30,10,'Glue','Stationery',2,120,'2024-01-31'),

(31,1,'Laptop','Electronics',1,60000,'2024-02-01'),
(32,2,'Mobile','Electronics',1,22000,'2024-02-02'),
(33,3,'Keyboard','Electronics',2,1500,'2024-02-03'),
(34,4,'Mouse','Electronics',1,700,'2024-02-04'),
(35,5,'Headphones','Electronics',2,2600,'2024-02-05'),
(36,6,'Tablet','Electronics',1,17500,'2024-02-06'),
(37,7,'Monitor','Electronics',1,12500,'2024-02-07'),
(38,8,'Printer','Electronics',1,9200,'2024-02-08'),
(39,9,'Camera','Electronics',1,31000,'2024-02-09'),
(40,10,'Speaker','Electronics',1,4200,'2024-02-10'),

(41,1,'Shoes','Fashion',1,2600,'2024-02-11'),
(42,2,'T-Shirt','Fashion',2,850,'2024-02-12'),
(43,3,'Jeans','Fashion',1,1900,'2024-02-13'),
(44,4,'Jacket','Fashion',1,3600,'2024-02-14'),
(45,5,'Watch','Fashion',1,5200,'2024-02-15'),
(46,6,'Bag','Fashion',1,1400,'2024-02-16'),
(47,7,'Cap','Fashion',2,450,'2024-02-17'),
(48,8,'Sunglasses','Fashion',1,2100,'2024-02-18'),
(49,9,'Belt','Fashion',1,950,'2024-02-19'),
(50,10,'Wallet','Fashion',2,1300,'2024-02-20');

select * from customers;
select * from sales;

/*Q1- Total Sales Per Customer
Write a query to display customer name and total amount spent by each customer.*/
SELECT 
    c.customer_name, SUM(s.price) as total_spent
FROM
    customers c
        JOIN
    sales s ON c.customer_id = s.customer_id
GROUP BY customer_name;

/* Q2- Top 5 Highest Spending Customers
Find the top 5 customers who spent the most money.*/

SELECT 
    c.customer_name, SUM(s.price*s.quantity) AS total_spent
FROM
    customers c
        JOIN
    sales s ON c.customer_id = s.customer_id
GROUP BY customer_name
ORDER BY total_spent DESC
LIMIT 5;

/*3 Total Revenue by Category
Calculate the total revenue generated for each category.*/

select category, sum(quantity * price) as total_revenue 
from sales
group by category;

/*Q4-Customers Who Purchased Electronics*/
SELECT DISTINCT
    c.customer_name, s.category
FROM
    customers c
        JOIN
    sales s ON c.customer_id = s.customer_id
WHERE
    s.category = 'Electronics';
    
    -- Q5-Monthly Sales Revenue
SELECT 
    SUM(quantity * price) AS total_ravenue,
    MONTHNAME(sale_date) AS month
FROM
    sales
GROUP BY MONTHNAME(sale_date);

 -- Q6-Average Order Value Per Customer
select c.customer_name, avg(s.quantity*s.price) as avg_order_value
from customers c 
join sales s on c.customer_id=s.customer_id
group by c.customer_name;

 -- Q7-Product with Highest Total Sales
    
  SELECT 
    product_name, MAX(quantity * price) AS total_revenue
FROM
    sales
GROUP BY product_name
ORDER BY total_revenue DESC
LIMIT 1;
    
    /*Q8-Customers Who Purchased in Both January and February
Find customers who made purchases in both January and February 2024.*/

select c.customer_name
from customers c 
join sales s on c.customer_id = s.customer_id
group by customer_name
having
sum(case when month(sale_date)=1 then 1 else 0 end)>0
and 
sum(case when month(sale_date)=2 then 1 else 0 end)>0;

    
    
select * from customers;
select * from sales;

/*Q9-Rank Customers by Total Spending
Rank customers based on their total spending using a window function.*/

select c.customer_name,sum(s.Price* s.quantity) as total_spent,
RANK() OVER ( ORDER BY sum(s.Price * s.quantity)desc) as rnk_position
from customers c 
join sales s on c.customer_id = s.customer_id
group by c.customer_name;

/*Q10- Most Sold Product (By Quantity)
Find the product that sold the highest quantity.*/
select product_name,  sum(quantity) As total_quantity
from sales
group by product_name
order by  total_quantity desc;

/*Q11- Running Total of Sales
Calculate a running total of revenue ordered by sale_date.*/
select * ,
sum(price*quantity)  over (order by sale_date)  as running_total
from sales
order by sale_date;

/*Q12- Highest Sale in Each Category
Find the highest sale amount in each category.*/
SELECT 
    category, MAX(price * quantity) AS highest_sale
FROM
    sales
GROUP BY category;

-- Q13-Second Highest Sale Price

SELECT DISTINCT
    price
FROM
    sales
ORDER BY price DESC
LIMIT 1 OFFSET 1;

-- alternate solution

select price from(select price,
dense_rank() over (order by price desc) as rnk 
from sales) t
where rnk=2;

select * from sales;

/*Q14-Customers Who Never Bought Electronics
Find customers who never purchased products from Electronics category.*/

SELECT 
    customer_name
FROM
    customers
WHERE
    customer_id NOT IN (SELECT 
            customer_id
        FROM
            sales
        WHERE
            category = 'Electronics');

/*Q15-Category-wise Revenue Contribution
Calculate the percentage contribution of each category to total revenue.*/

SELECT 
    category,
    SUM(quantity * price) AS revenue,
    ROUND(100 * SUM(quantity * price) / (SELECT 
                    SUM(quantity * price)
                   FROM sales),2) AS percentage
                  FROM sales
                 GROUP BY category;




