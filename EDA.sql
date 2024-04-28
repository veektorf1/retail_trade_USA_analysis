select * from retail_sales;

select count(*) from retail_sales;

select round(100*sum(case when sales is not null then 1 else 0 end)::numeric/count(*),2)
from retail_sales;

select count(distinct kind_of_business) from retail_sales;

select min(sales_month),max(sales_month) from retail_sales;

select distinct reason_for_null from retail_sales;

select sales_month,sales,kind_of_business from retail_sales
where kind_of_business IN ('Women''s clothing stores','Men''s clothing stores')
and sales is null

select distinct kind_of_business
from retail_sales
except
select distinct kind_of_business
from retail_sales
where sales is null