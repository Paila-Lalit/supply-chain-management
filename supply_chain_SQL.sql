create database supplychain;
use  supplychain;

select * from d_product;
select * from supplychain.f_point_of_sale;

#-----Total_sales_YTD------

select sum(f_point_of_sale.`Sales Amount`) as TOtal_sles_YTD
from f_sales
join f_point_of_sale
on f_sales.`ï»¿Order Number`= f_point_of_sale.`ï»¿Order Number`
where f_sales.date >= date_sub(current_date(), interval year(current_date())-1 year);


#-------product-wise-sales-------

select `Product Name`,`Sales Amount` from d_product join f_point_of_sale on d_product.`ï»¿Product Key`= f_point_of_sale.`Product Key`;

#-------sales_growth------

select date(date) as sale_day ,sum(`Sales Amount`) as total_sales  from f_sales join f_point_of_sale on f_sales.`ï»¿Order Number`=f_point_of_sale.`ï»¿Order Number`
 group by date(date) order by sale_day;

#-------state_wise_sales-------

select `Cust State`,`Sales Amount` from d_customer join f_point_of_sale on d_customer.`ï»¿Cust Key`=f_point_of_sale.`Product Key`;

#--------top5_store_wise_sales------

select `Store Name`,sum(`Sales Amount`) as total_sales from d_store join f_point_of_sale on d_store.`ï»¿Store Key`=f_point_of_sale.`Product Key` 
group by `Store Name` order by total_sales desc limit 5 ;

#------region_wise_sales-----

select `Store Region`,sum(`Sales Amount`) as total_sales from d_store join f_point_of_sale on d_store.`ï»¿Store Key`= f_point_of_sale.`Product Key`
 group by `Store Region` order by total_sales;
 
#-------total_inventory-----

select sum(`Quantity on Hand`) as total_inventory
from f_inventory_adjusted;

#------inventory_value-----

select round(sum(`Cost Amount`* `Quantity on Hand`)) as total_inventory from  f_inventory_adjusted ;

#------over_stock,under_stock,out_of_stock-------

select `Product Name`,`Product Type`,`Quantity on Hand`, case
when `Quantity on Hand` > 3 and `Quantity on Hand` = 3 then 'overstock'
when `Quantity on Hand` = 0 and `Quantity on Hand`>0 then 'out_of_stock' 
when `Quantity on Hand` < 3 and `Quantity on Hand`> 0 then 'under_stock'
else 'in_stock' end as stock_status from f_inventory_adjusted;





