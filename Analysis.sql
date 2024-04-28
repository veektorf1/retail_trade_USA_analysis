--------------------------------------------------------------------
-- yearly pct men and women clothing sales
select year_date,men_sales,women_sales,
round(100*men_sales::numeric/(men_sales+women_sales),2) as men_pct,
round(100*women_sales::numeric/(men_sales+women_sales),2) as women_pct
from 
(
	select date_part('year',sales_month) as year_date,
	sum(case when kind_of_business='Men''s clothing stores' then sales end) as men_sales,
	sum(case when kind_of_business='Women''s clothing stores' then sales end) as women_sales
	from retail_sales
	WHERE kind_of_business in ('Men''s clothing stores','Women''s clothing stores')
	group by year_date
)
order by year_date;

------------------------------------------------------------------
-- PCT monthly sales
WITH monthly_sales AS (
    SELECT 
        sales_month,
        SUM(CASE WHEN kind_of_business = 'Men''s clothing stores' THEN sales ELSE 0 END) AS men_sales,
        SUM(CASE WHEN kind_of_business = 'Women''s clothing stores' THEN sales ELSE 0 END) AS women_sales,
        SUM(sales) AS total_sales_per_month
    FROM public.retail_sales
    WHERE kind_of_business IN ('Men''s clothing stores', 'Women''s clothing stores') and sales_month<'2020-10-01' --skip two null values
    GROUP BY sales_month
)
SELECT 
    sales_month,
    men_sales,
    women_sales,
    round(men_sales * 100.0 / total_sales_per_month) AS men_sales_percentage,
    round(women_sales * 100.0 / total_sales_per_month) AS women_sales_percentage
FROM monthly_sales
order by sales_month;

--------------------------------------------------------
-- Rolling average
WITH rolling_average_data AS (
    SELECT 
		kind_of_business,
        sales_month,
        ROUND(AVG(sales) OVER (ORDER BY sales_month ROWS BETWEEN 11 PRECEDING AND CURRENT ROW), 3) AS rolling_avg,
        COUNT(sales) OVER (ORDER BY sales_month ROWS BETWEEN 11 PRECEDING AND CURRENT ROW) AS record_count
    FROM retail_sales
    WHERE kind_of_business='Women''s clothing stores'
)

SELECT 
	kind_of_business,
    sales_month,
    rolling_avg,
    record_count
FROM rolling_average_data
WHERE record_count = 12;

-----------------------------------------------------------
-- Yoy Growth
with cumulative_sales as (
	select sales_month,mens_cumulative_sales,
	lag(mens_cumulative_sales,12) over (order by sales_month) as men_last_year_cumulative_sales,
	womens_cumulative_sales,
	lag(womens_cumulative_sales,12) over (order by sales_month) as women_last_year_cumulative_sales
	from(
		SELECT sales_month,--kind_of_business,
		max(case when kind_of_business='Men''s clothing stores' then last_12months_sales end) as mens_cumulative_sales,
		max(case when kind_of_business='Women''s clothing stores' then last_12months_sales end) as womens_cumulative_sales
		from (
			select sales_month,kind_of_business,
			count(sales) OVER (partition BY kind_of_business
								 ORDER BY sales_month rows between 11 preceding and current row ) as records_count,
			sum(sales) OVER (partition BY kind_of_business
								 ORDER BY sales_month rows between 11 preceding and current row ) as last_12months_sales
			from retail_sales
			WHERE kind_of_business IN('Men''s clothing stores','Women''s clothing stores')
			)
		WHERE records_count=12 --12months 
		group by sales_month 
		order by sales_month
		)
	where mens_cumulative_sales is not null and mens_cumulative_sales is not null
)
select sales_month,
round(100.0*mens_cumulative_sales/men_last_year_cumulative_sales,2)-100 as men_yoy_growth_pct,
round(100.0*womens_cumulative_sales/women_last_year_cumulative_sales,2)-100 as women_yoy_growth_pct
from cumulative_sales
where men_last_year_cumulative_sales is not null;

------------------------------------------------------------
-- Seasonal flactuations
SELECT
year_date,
max(case 
	when frame LIKE '%Not december' then avg_frame else 0 
end) as "Not december",
max(case 
	when frame LIKE '%Not december' then 0 else avg_frame 
end) as "december",

round(max(case 
	when frame LIKE '%Not december' then 0 else avg_frame 
end)/max(case 
	when frame LIKE '%Not december' then avg_frame else 0 
end),2) as december_to_rest_ratio
FROM
(
	SELECT distinct date_part('year',sales_month) as year_date,
	date_part('year',sales_month)||' '|| CASE
		WHEN EXTRACT(month from sales_month) !=12 THEN 'Not december'
		ELSE 'December'
		END as frame,
	AVG(SALES) OVER 
	(
		PARTITION BY CASE
		WHEN date_part('month',sales_month) !=12 THEN 'Not december'
		ELSE 'December' END, date_part('year',sales_month)
	) as avg_frame
	FROM PUBLIC.RETAIL_SALES
	WHERE kind_of_business IN('Women''s clothing stores')
	ORDER by 1
)
group by year_date;

-----------------------------------------------------------------------
--- GREAT RECESSION
WITH not_null_business AS (
    SELECT DISTINCT kind_of_business
    FROM retail_sales
    EXCEPT
    SELECT DISTINCT kind_of_business
    FROM retail_sales
    WHERE sales IS NULL
),
cumulative_sales as (
	SELECT *, 
	lag(last_12months_sales,12) over (partition by kind_of_business order by sales_month) as last_year_cumulative_sales
	from (
				select sales_month,kind_of_business,
				count(sales) OVER (partition BY kind_of_business
									 ORDER BY sales_month rows between 11 preceding and current row ) as records_count,
				sum(sales) OVER (partition BY kind_of_business
									 ORDER BY sales_month rows between 11 preceding and current row ) as last_12months_sales
				from retail_sales
				WHERE kind_of_business IN(SELECT kind_of_business FROM not_null_business)
			)
			WHERE records_count=12 --12months 
	)
select kind_of_business,
MIN(round(100.0*last_12months_sales/last_year_cumulative_sales,2)-100) as yoy_growth_pct
from cumulative_sales
where last_year_cumulative_sales is not null
and sales_month between '2008-01-01' and '2010-12-01'
group by kind_of_business
order by yoy_growth_pct desc 
		


