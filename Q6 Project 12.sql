/*Q6.List down the compounded annual growth rate (CAGR) in 4-wheeler units for the top 5 makers from 2022 to 2024?.*/

With CAGR_FY2024 as
	(
    Select m.maker, sum(electric_vehicles_sold) as EV_Sales2024
	from electric_vehicle_sales_by_makers m
    Join dim_date d
    on m.date = d.date
    Where d.fiscal_year = 2024
    Group by m.maker
    ),
 CAGR_FY2022 as 
	(
    Select m.maker, sum(electric_vehicles_sold) as EV_Sales2022
	from electric_vehicle_sales_by_makers m
    Join dim_date d
    on m.date = d.date
    Where d.fiscal_year = 2022
    Group by m.maker
    )
Select c.maker, c.EV_Sales2024, p.EV_Sales2022,
	Case 
		When p.EV_Sales2022>0 Then
			Round((power(c.EV_Sales2024  / p.EV_Sales2022, 1/2)-1) * 100,2)
				Else 
					Null
						End as CAGR_Maker_Percent
	From CAGR_FY2024 c
    Join  CAGR_FY2022 p
    on c.maker = p.maker
    order by CAGR_Maker_Percent DESC
    Limit 5;