/*Q1.List the top 3 and bottom 3 makers for the fiscal years 2023 and 2024 in terms of the number of 2-wheelers sold.*/
/*Top 3*/
Select m.maker, sum(m.electric_vehicles_sold) as EV_Sales from electric_vehicle_sales_by_makers m
	Join dim_date d
		on d.date = m.date
        Where d.fiscal_year in (2023, 2024)
        and
        m.vehicle_category = '2-Wheelers'
        group by m.maker
        Order By EV_Sales DESC
        Limit 3;
        
/*Bottom 3*/
Select m.maker, sum(m.electric_vehicles_sold) as EV_Sales from electric_vehicle_sales_by_makers m
	Join dim_date d
		on d.date = m.date
        Where d.fiscal_year in (2023, 2024)
        and
        m.vehicle_category = '2-Wheelers'
        group by m.maker
        Order By EV_Sales 
        Limit 3;

/*Q2.Identify the top 5 states with the highest penetration rate in 2-wheeler and 4-wheeler EV sales in FY 2024.*/

