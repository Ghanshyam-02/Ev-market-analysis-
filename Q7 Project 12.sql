/*Q7.List down the top 10 states that had the highest compounded annual growth rate (CAGR) from 2022 to 2024 in total vehicles sold.*/

With CAGR_FY2024 as
	(
    Select st.state, sum(total_vehicles_sold) as TV_Sales2024
	from electric_vehicle_sales_by_state st
    Join dim_date d
    on st.date = d.date
    Where d.fiscal_year = 2024
    and st.vehicle_category = "2-Wheelers"
    Group by st.state
    ),
 CAGR_FY2022 as 
	(
    Select st.state, sum(total_vehicles_sold) as TV_Sales2022
	from electric_vehicle_sales_by_state st
    Join dim_date d
    on st.date = d.date
    Where d.fiscal_year = 2022
    and st.vehicle_category = "2-Wheelers"
    Group by st.state
    )
Select c.state, c.TV_Sales2024, p.TV_Sales2022,
	Case 
		When p.TV_Sales2022>0 Then
			Round((power(c.TV_Sales2024  / p.TV_Sales2022, 1/2)-1) * 100,2)
				Else 
					Null
						End as CAGR_State_Percent
	From CAGR_FY2024 c
    Join  CAGR_FY2022 p
    on c.state = p.state
    order by CAGR_State_Percent DESC
    Limit 10;