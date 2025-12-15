 create database sql_project_p2;
 
 USE SQL_PROJECT_P2retail_sales;
    -- create table 
    DROP TABLE IF EXISTS RETAIL_SALES;
     CREATE TABLE RETAIL_SALES (
     TRANSACTION_ID INT UNSIGNED PRIMARY KEY ,
     SALE_DATE INT  ,
     SALE_TIME TIME,
     CUSTOMER_ID INT UNSIGNED ,
     GENDER VARCHAR(15) CHECK(GENDER IN ('MALE' 'FEMALE')),
     AGE INT  ,
     CATEGORY VARCHAR(21),
     QUANTITY INT ,
     PRICE_PER_UNIT FLOAT ,
     COGS FLOAT ,
     TOTAL_SALE FLOAT
     );
     select count(*) from retail_sales_1;
     --
     
select* from retail_sales_1;

-- null values 
select * from retail_sales_1 where sale_date is null;
select* from retail_sales_1 where transaction_id is null ;

-- alteration column 
alter table retail_sales_1 rename column ï»¿transactions_id to transaction_id;

select * from retail_sales_1 where sale_time is null ;
select * from retail_sales_1 where transaction_id is null 
or sale_date is null 
or customer_id is null 
or  gender is null 
or age is null 
or category is null 
or quantiy  is null 
or price_per_unit is null 
or cogs is null 
or total_sale is null ;

delete from retail_sales_1 where transaction_id is null or sale_time is null 
or sale_date is null 
or customer_id is null 
or  gender is null 
or age is null 
or category is null 
or quantiy  is null 
or price_per_unit is null 
or cogs is null 
or total_sale is null ;
 
    set sql_safe_updates=0;
 set sql_safe_updates =1;
 ---------------------------------------------------------------------------------------
 -- data exploretions 
 select * from retail_sales_1;
 -- How many sales we have 
 select count(*) total_sales from retail_sales_1 ;
 
 -- How many uniuque customer we have 
 select count(distinct  customer_id )  as total_customer  from retail_sales_1;
 
 -- How many category we have there 
 select count(distinct category ) from retail_sales_1;
 
 -- DATA ANALYSIS & BUSINESS KEY PROBLEMS  & ANASWER 
 
 -- MY ANALYSIS & FINDINGS 
 -- Q1 write sql query to retreive all columns for sales made on 2022-11-06
 select * from retail_sales_1
 where sale_date = '05-11-2022';
 -- Q2 write query to retreive all transaction where the category is 'clothing ' and quantity sales more then 10 in month of non_2022
 select 
 * 
 from 
 retail_sales_1
 where  category = 'CLOTHING'
 and MONTH (SALE_DATE) = 11 AND YEAR(SALE_DATE) = 2022
 AND
 quantiy =4;
 
 -- Write a query to calculate the total sale ( total-sales) for each category 
 select sum(total_sale) as total_sales ,
 category ,count(category) as total_orders
 from retail_sales_1 group by 2;
 
 -- write sql query to find average age of customer who purchased item from 'beauty ' category 
 select
 round( avg(age) ,2) as average_age
 from retail_sales_1 where category = 'Beauty' ;
 
 -- write sql query  to find all transaction where total_sales is greater than 1000 
 select * from retail_sales_1 
 where total_sale > 1000;
 
 select gender , category , count(transaction_id) as total_transaction
 from retail_sales_1  
 group by gender,category  order by  gender , category  ;
 
 -- write the query to calcute averge sales for each month and find out best selling month in each year

select
 years ,
months , 
rankk 
 , average_sales from 
 (select month( sale_date ) as months
 , year( sale_date) as years
 ,avg(total_sale) as average_sales , 
 rank() over (partition by year(sale_date) order by avg(total_sale) desc) as rankk
 from retail_sales_1
 group by 1, 2) as t1
     where rankk = 1 ;
-- order by 2 ,3 desc;
 
 -- write a sql query to find the top 5 customer based on highest total_sales 
 
 select *  from retail_sales_1 ;
 select
 customer_id ,
   sum(total_sale)  as sales 
	from retail_sales_1 
       group by customer_Id  order by  sales desc limit 5 ;
       
 -- write sql query to find number of unique customer who purchased items from each category       

 select  category,
 count(customer_Id)
                    from retail_sales_1 
                    group by 1;
 
 
 -- write sql query to create each shift and number of orders ( examlpe mornning <= 12 and afternoon between 12 to 17 pm , evening >17) 
  select *  from retail_sales_1;
   
with hourly_sales as  ( select  *,
  case   
  when hour(sale_time) < 12 then 'mornning'
  when hour(sale_time)  > 12 and hour(sale_time) < 17  then  'afternoon'
  else 'night'
  end  as shift  from retail_sales_1)
  select shift ,
  count(*) as total_orders
  from hourly_sales 
  group by 
     shift  order by total_orders desc;
     
     -- end of project 
  
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 

 
 
 
 

 
	