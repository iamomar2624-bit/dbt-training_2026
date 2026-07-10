select
    -- raw orders
    {{ dbt_utils.generate_surrogate_key(['o.orderid', 'c.customerid', 'p.productid']) }}
    as sk_orders,
    o.orderid,
    o.orderdate,
    o.shipdate,
    o.shipmode,
    o.ordersellingprice - ordercostprice as orderprofit,
    o.ordersellingprice,
    ordercostprice,
    -- raw customer
    c.customerid,
    c.customername,
    c.segment,
    c.country,
    -- raw product
    p.category,
    p.productname,
    p.subcategory,
    p.productid
from {{ ref("raw_orders") }} as o
left join {{ ref("raw_customer") }} as c on o.customerid = c.customerid
left join {{ ref("raw_product") }} as p on o.productid = p.productid
