/*Q5.How do the EV sales and penetration rates in Delhi compare to Karnataka for 2024?.*/

Select st.state, sum(st.electric_vehicles_sold),
	Round(sum(st.electric_vehicles_sold)/sum(st.total_vehicles_sold)*100,2) as Delhi_penetration_rate
	from electric_vehicle_sales_by_state st 
    Join dim_date d
    on st.date = d.date
    Where d.fiscal_year = 2024
    and st.state in ("Delhi", "Karnataka")
    group by st.state
    order by st.state;