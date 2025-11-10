/*Q4.What are the quarterly trends based on sales volume for the top 5 EV makers (4-wheelers) from 2022 to 2024?.*/

WITH RankedSales AS (
    SELECT 
        m.maker, 
        d.quarter, 
        SUM(m.electric_vehicles_sold) AS EV_Sales,
        ROW_NUMBER() OVER (PARTITION BY d.quarter ORDER BY SUM(m.electric_vehicles_sold) DESC) AS rnk
    FROM 
        electric_vehicle_sales_by_makers m
    JOIN 
        dim_date d ON d.date = m.date
    WHERE 
        m.vehicle_category = '4-Wheelers'
    GROUP BY 
        m.maker, d.quarter
)
SELECT 
    maker, 
    quarter, 
    EV_Sales
FROM 
    RankedSales
WHERE 
    rnk <= 5
ORDER BY 
    quarter, EV_Sales DESC;

        