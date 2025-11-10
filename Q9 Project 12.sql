/*Q9.What is the projected number of EV sales (including 2-wheelers and 4-wheelers) for the top 10 states by penetration rate in 2030, 
based on the compounded annual growth rate (CAGR) from previous years?.*/

With CAGR_EV_FY2024 as
	(
    Select st.state, sum(electric_vehicles_sold) as EV_Sales2024
	from electric_vehicle_sales_by_state st
    Join dim_date d
    on st.date = d.date
    Where d.fiscal_year = 2024
    Group by st.state
    ),
 CAGR_EV_FY2022 as 
	(
    Select st.state, sum(electric_vehicles_sold) as EV_Sales2022
	from electric_vehicle_sales_by_state st
    Join dim_date d
    on st.date = d.date
    Where d.fiscal_year = 2022
    Group by st.state
    )
Select c.state, p.EV_Sales2022, c.EV_Sales2024,
	Case 
		When p.EV_Sales2022>0 Then
			Round((power(c.EV_Sales2024  / p.EV_Sales2022, 1/2)-1) * 100,2)
				Else 
					Null
						End as CAGR_EV_State_Percent
	From CAGR_EV_FY2024 c
    Join  CAGR_EV_FY2022 p
    on c.state = p.state
    order by CAGR_EV_State_Percent DESC
    Limit 10;


Select e.state, p.penetration_rate, e.CAGR_EV_State_Percent,
	Round(sum(e.EV_Sales2024)*(power(1 + e.CAGR_EV_State_Percent/100, 6)),0) as EV_Projected_Sales2030
    From cagr_ev_state_percent e
    Join penetration_rate p
    on e.state = p.state
    group by e.state
    order by EV_Projected_Sales2030 DESC