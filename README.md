# Monthly_Retail_Trade_USA
Insights on data available on retail economic activity in the United States from 1992-2020
In my analysis I'll focus primarly on women's and men's clothing sales

# 1. Data exploration
* Columns in dataset
  ![image](https://github.com/veektorf1/Monthly_Retail_Trade_USA/assets/125961580/54b7057c-2a26-4a9c-a1e8-8db1f80eab2b)

* Total numbers of records
![image](https://github.com/veektorf1/Monthly_Retail_Trade_USA/assets/125961580/24fb27a4-3790-4a74-ae72-84d9fa35a0e4)

* There are 65 categories of businesses.
![image](https://github.com/veektorf1/Monthly_Retail_Trade_USA/assets/125961580/5e03721b-b60b-4da0-af1a-05adb327874d)

* Data is available starting from January 1992 to December 2020
![image](https://github.com/veektorf1/Monthly_Retail_Trade_USA/assets/125961580/85cb9df1-0e58-42bb-85e9-15a8d32fa941)

* Percentage of not null sales records
  
![image](https://github.com/veektorf1/Monthly_Retail_Trade_USA/assets/125961580/a5098698-49bf-4a06-ae81-5bab9acf738c)

* Reasons for null sales records
  
![image](https://github.com/veektorf1/Monthly_Retail_Trade_USA/assets/125961580/db2b2c0a-738a-4e07-8985-a74f1807f2b0)

# 2. Data analysis
 The category i'm analysing primarly is men's and women's clothing stores.
 There are two null values in 2020 for men's sales
 
 ![image](https://github.com/veektorf1/Monthly_Retail_Trade_USA/assets/125961580/9e1245e0-2ccd-4556-8c89-b3b1e2fc633d)

  ### Yearly sales share
  On the chart we can discern a downwards trend for men's clothing sales in comparison to women's sales
  
 ![image](https://github.com/veektorf1/Monthly_Retail_Trade_USA/assets/125961580/a6711a89-6cac-481d-bd47-d2f20f573893)
 ![image](https://github.com/veektorf1/Monthly_Retail_Trade_USA/assets/125961580/43ae0ca7-e362-441d-8185-37640ae3bc1e)
![image](https://github.com/veektorf1/Monthly_Retail_Trade_USA/assets/125961580/7b24f7bc-fdc6-444d-9702-2817daa63813)

The 2020 drop in difference is mainly caused by the fact of 2 null values in men's clothing sales

![graph_visualiser-1712211361838](https://github.com/veektorf1/Monthly_Retail_Trade_USA/assets/125961580/6df72aaf-44a8-40ae-98cb-6d3396d06560)

In general men's share on clothing sales in on downwards trend since mid/late 90's

### Monthly sales share
Now I'm going to do the same as above but for every month individually
![image](https://github.com/veektorf1/Monthly_Retail_Trade_USA/assets/125961580/f00f0370-b823-4c15-beff-322025ec5e6b)

![pct_monthly_men_women](https://github.com/veektorf1/Monthly_Retail_Trade_USA/assets/125961580/a84aa4f3-0d46-43bd-a759-85be2fa53b0a)


As we can see percentage of men's sales increase seasonally in the christmas period than women's clothing sales

![monthly_sales](https://github.com/veektorf1/Monthly_Retail_Trade_USA/assets/125961580/6e19157c-64ec-4f47-81e2-ae9e7232a7e3)

Cristmas period appears to influence people's buying tendency.
After December, a noticable drop in January/February is clearly visible.
Another noteworthy thing is how much sales plummeted after COVID-19 lockdown (2020).

We can apply rolling average to make smoother visualization
Rolling average for women's sales:
![image](https://github.com/veektorf1/Monthly_Retail_Trade_USA/assets/125961580/b523a39b-1ba5-4d28-9d85-bb0b0fb05ee8)

![rolling_avg_women](https://github.com/veektorf1/Monthly_Retail_Trade_USA/assets/125961580/1de56574-9e36-4db2-a0c8-9fd516b37438)


### YoY Growth
For each month I'll compare cumulative sales of last 12 months
First of all, let's get cumulative sales of last 12 months
![image](https://github.com/veektorf1/Monthly_Retail_Trade_USA/assets/125961580/f2e7af7c-60a2-42c0-b37e-1e8078a3369b)

![cumulative_yearly_Sales](https://github.com/veektorf1/Monthly_Retail_Trade_USA/assets/125961580/ab8cc9e3-68ba-4457-86fe-706d129f0e9f)

Apart from covid economic recession, there is also quite distinguishable impact of Great Recession which took place in 2008-2009

Now, let's use lag function to stack it up against last_year result in order to get YoY growth
![image](https://github.com/veektorf1/Monthly_Retail_Trade_USA/assets/125961580/36e3d805-d32a-4210-9b31-c3d1f598cfeb)

![yoy-growth](https://github.com/veektorf1/Monthly_Retail_Trade_USA/assets/125961580/b265188b-d7a0-45a7-a8f0-d1436ecae61e)

It affirms my previous statements about massive drops standing out, in 2009 (-13% growth for men and -9% growth for women's sales) and 2020 ( down to about -30% of yoy growth). Also there is less one another decline only in men's sales category in 2002 reaching -10% yoy growth.


### Seasonal flactuations
Here I'm going to compare sales from two periods of the year:
  - December
  - Rest of the year
This will provide a better insight on increasing buying power during Christmas. I'll take into account women's clothing sales
![image](https://github.com/veektorf1/Monthly_Retail_Trade_USA/assets/125961580/73111a7e-2320-4aec-b7d7-119df7cb5964)

![december_to_rest_ratio](https://github.com/veektorf1/Monthly_Retail_Trade_USA/assets/125961580/7298bfad-5bf9-46be-82dd-877214364d1f)

Ratio in the 2010's is about 1.3/1.4 (exception is 2020 COVID Christmas) while in the 90's and early to mid 00's it was oscilationg about 1.6. People back in 1990-2006 used to spend more on clothing for christmas than it is in 2010's which could be affected by Great Recession.













