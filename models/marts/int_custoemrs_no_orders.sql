{%- set status = ['return_pending','returned','complete'] -%}
with customers as (
   select * from {{ ref('stg_customers') }}
),
orders as (
   select * from {{ ref('stg_orders') }}
),
 
final as (
   select c.customer_id,
     {% for status in status -%}
    sum(case when status = '{{ status }}' then 1 else 0 end) 
            as {{ status }}_count    
       {%- if not loop.last -%}
         ,
       {% endif -%}
        {%- endfor %}
    from customers as c join orders as o on c.customer_id=o.customer_id
    group by 1
)

select * from final