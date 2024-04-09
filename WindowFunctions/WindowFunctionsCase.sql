Create database WindowFunctionUseCases;

/* Cumulative Sum */
select *,
sum(sales) over (order by monthnum) as cumulativesales
from functions;

/*Comparison of Peer*/
SELECT 
    *
FROM
    peer_rank;

select 
*,dense_rank() over (partition by industry order by profit desc)
as ranking 
from peer_rank;

select 
*,rank() over (partition by industry order by profit desc)
as ranking 
from peer_rank;

/*YOY change*/
with final as (
select 
*,lag(sales) over (partition by company order by year)
as previoussales 
from yoy)
select year,company,sales, previoussales,
((sales-previoussales)/previoussales) as percentchange 
from final

/* stock moving average 3 day*/

SELECT *,
       AVG(price) OVER (ORDER BY date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS moving_average
FROM mav;























