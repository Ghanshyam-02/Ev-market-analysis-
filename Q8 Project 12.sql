/*Q8.What are the peak and low season months for EV sales based on the data from 2022 to 2024?.*/

With New_Dim_Date as
	(Select date, fiscal_year, monthname(str_to_date(date, '%d-%b-%y')) as Month_Name
		FROM dim_date)
	Select n.Month_Name, sum(m.electric_vehicles_sold) as EV_Sales from New_Dim_Date n
        Join electric_vehicle_sales_by_makers m
        On n.date = m.date
        Where n.fiscal_year = 2022
        and m.vehicle_category = "2-Wheelers"
        Group by n.Month_Name
        Order by EV_Sales DESC