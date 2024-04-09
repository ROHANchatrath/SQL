create database CricketProject;

SELECT 
    *
FROM
    CricketData;

/* Find the total cost for only google campaigns for all markets*/

SELECT 
    Campaign, SUM(Cost) AS TotalCost
FROM
    CricketProject.cricketdata
WHERE
    Campaign = 'Google';

/* Find the CPC value per audience(cost to click ratio)*/

SELECT 
    audience, SUM(cost) / SUM(Clicks) AS CPC
FROM
    cricketdata
GROUP BY audience;

/* Display the markets with total clicks greater than 500*/

SELECT 
    market, SUM(Clicks) totalclicks
FROM
    cricketdata
GROUP BY Market
HAVING SUM(Clicks) > 500;

/*display a new column Costnew and give it a value 'abovethreshold' if cost > 20, else below threshold*/

SELECT 
    *,
    CASE
        WHEN cost > 20 THEN 'abovethreshold'
        ELSE 'belowthreshold'
    END AS costnew
FROM
    cricketdata;

/*Display the agent with the total fees in descenfin order*/

SELECT DISTINCT
    (market)
FROM
    cricketdata;

CREATE TABLE MarketAgents (
    Market VARCHAR(3),
    AgentName VARCHAR(50)
);

INSERT INTO MarketAgents (Market, AgentName)
VALUES
    ('NZ', 'John Smith'), -- New Zealand
    ('AUS', 'Emily Johnson'), -- Australia
    ('IND', 'Raj Patel'), -- India
    ('RSA', 'Sarah van der Merwe'), -- South Africa
    ('CH', 'Wei Li'),  -- China
    ('PAK', 'Ali Khan'), -- Pakistan
    ('ARG', 'Sofia Rodriguez');-- Argentina

SELECT 
    *
FROM
    MarketAgents;

/*join*/

SELECT 
    m.AgentName, SUM(c.fees) AS fees
FROM
    cricketdata c
        INNER JOIN
    MarketAgents m ON c.Market = m.Market
GROUP BY m.AgentName
ORDER BY SUM(c.fees) DESC;

/*Display the market and total impressions value only for Facebook 
Campaigns with total impressions>10000 and sort them by country name*/

SELECT 
    Market, SUM(Impressions)
FROM
    cricketdata
WHERE
    campaign = 'Facebook'
GROUP BY Market
HAVING SUM(Impressions) > 10000
ORDER BY Market;

/*Which month and year combination had the highest number of orders*/

CREATE TABLE EcommerceData (
    Country VARCHAR(50),
    UserCode VARCHAR(4),
    OrderNum VARCHAR(4),
    OrderStatus VARCHAR(50),
    DateOrdered DATE,
    Channel VARCHAR(50)
);

INSERT INTO EcommerceData (Country, UserCode, OrderNum, OrderStatus, DateOrdered, Channel)
VALUES
    ('UK', '1234', '1234', 'Pending', '2024-04-01', 'Website'),
    ('USA', '5678', '5678', 'Shipped', '2024-04-02', 'Mobile App'),
    ('Canada', '9876', '9876', 'Delivered', '2024-04-03', 'Website'),
    ('UK', '2345', '2345', 'Pending', '2024-04-04', 'Mobile App'),
    ('USA', '6789', '6789', 'Shipped', '2024-04-05', 'Website'),
    ('Canada', '8765', '8765', 'Delivered', '2024-04-06', 'Mobile App'),
    ('UK', '3456', '3456', 'Pending', '2024-04-07', 'Website'),
    ('USA', '7890', '7890', 'Shipped', '2024-04-08', 'Mobile App'),
    ('Canada', '7654', '7654', 'Delivered', '2024-04-09', 'Website'),
    ('UK', '4567', '4567', 'Pending', '2024-04-10', 'Mobile App'),
    ('USA', '8901', '8901', 'Shipped', '2024-04-11', 'Website'),
    ('Canada', '6543', '6543', 'Delivered', '2024-04-12', 'Mobile App'),
    ('UK', '5678', '5678', 'Pending', '2024-04-13', 'Website'),
    ('USA', '9012', '9012', 'Shipped', '2024-04-14', 'Mobile App'),
    ('Canada', '5432', '5432', 'Delivered', '2024-04-15', 'Website'),
    ('UK', '1234', '9999', 'Pending', '2023-11-16', 'Website'),
    ('USA', '5678', '8888', 'Shipped', '2023-11-17', 'Mobile App'),
    ('Canada', '9876', '7777', 'Delivered', '2023-11-18', 'Website'),
    ('UK', '2345', '6666', 'Pending', '2023-11-19', 'Mobile App'),
    ('USA', '6789', '5555', 'Shipped', '2023-11-20', 'Website'),
    ('Canada', '8765', '4444', 'Delivered', '2023-11-21', 'Mobile App'),
    ('UK', '3456', '3333', 'Pending', '2023-11-22', 'Website'),
    ('USA', '7890', '2222', 'Shipped', '2023-11-23', 'Mobile App'),
    ('Canada', '7654', '1111', 'Delivered', '2023-11-24', 'Website');

SELECT 
    *
FROM
    EcommerceData;

select date_format(DateOrdered,'%Y%m'), count(distinct ordernum)
from EcommerceData
group by date_format(DateOrdered,'%Y%m')
order by count(distinct OrderNum) desc

/*What is the % of items ordered through website*/

select sum(if(Channel='Website',1,0))/count(*) as percent_items
from EcommerceData;

/*How many distinct users have a name starting with the number 1*/

SELECT 
    COUNT(DISTINCT UserCode)
FROM
    EcommerceData
WHERE
    UserCode LIKE '1%';

/*Find the ratio of shipped to pending items and display them in
separate rows for socail and direct channel*/

SELECT 
    channel,
    SUM(IF(orderstatus = 'Shipped', 1, 0)) / SUM(IF(orderstatus = 'pending', 1, 0))
FROM
    EcommerceData
WHERE
    channel = 'Website' 
UNION SELECT 
    channel,
    SUM(IF(orderstatus = 'Shipped', 1, 0)) / SUM(IF(orderstatus = 'pending', 1, 0))
FROM
    EcommerceData
WHERE
    channel = 'Mobile App';

























