/*Q3.List the states with negative penetration (decline) in EV sales from 2022 to 2024?.*/

With PR_pct_Current_Period as
	(
    Select st.state, (sum(st.electric_vehicles_sold)/sum(st.total_vehicles_sold)*100) as Current_penetration_rate
	from electric_vehicle_sales_by_state st 
    Join dim_date d
    on st.date = d.date
    Where d.fiscal_year = 2024
    Group by st.state
    ),
 PR_pct_Previous_Period as 
	(
    Select st.state, (sum(st.electric_vehicles_sold)/sum(st.total_vehicles_sold)*100) as Previous_penetration_rate
	from electric_vehicle_sales_by_state st 
    Join dim_date d
    on st.date = d.date
    Where d.fiscal_year = 2023
    Group by st.state
    )
Select c.state, c.Current_penetration_rate - p.Previous_penetration_rate as PR_pct_Change
	from PR_pct_Current_Period c
    Join PR_pct_Previous_Period p
    on c.state = p.state
    Where c.Current_penetration_rate - p.Previous_penetration_rate <0
    order by PR_pct_change