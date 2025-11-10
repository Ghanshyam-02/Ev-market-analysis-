/*Q2.Identify the top 5 states with the highest penetration rate in 2-wheeler and 4-wheeler EV sales in FY 2024.*/
/*Create store procedure*/

Select st.state, (sum(st.electric_vehicles_sold)/sum(st.total_vehicles_sold)*100) as penetration_rate
	from electric_vehicle_sales_by_state st 
    Join dim_date d
    on st.date = d.date
    Where d.fiscal_year = 2024
    and st.vehicle_category = "2-Wheelers"
    Group by st.state
    order by penetration_rate DESC
    Limit 3;