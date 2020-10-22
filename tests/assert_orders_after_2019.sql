select * from {{ref('stg_orders')}} 
where year(order_date) <=2019