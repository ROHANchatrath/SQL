Create database YoutubePlaylist;

USE YoutubePlaylist;

/* Find the SQL related videos */
SELECT 
    *
FROM
    `AlexTheAnalyst` AS SQL_Videos
WHERE
    title_name LIKE '%SQL%';

/* Most viewed videos */
SELECT 
    *
FROM
    `AlexTheAnalyst` AS Most_Viewed
ORDER BY views DESC;

/* Likes to views ratio */
SELECT 
    *, (likes / views) AS likesratio
FROM
    `AlexTheAnalyst` AS Likes_to_Views
ORDER BY likesratio DESC;

/* Distinct months where videos are posted */
SELECT DISTINCT
    yearmonth AS Posting_Months
FROM
    `AlexTheAnalyst` AS Distinct_Months;

/* Case statements to categorize videos per tool category */
SELECT 
    CASE
        WHEN title_name LIKE '%ython%' THEN 'Python'
        WHEN title_name LIKE '%SQL%' THEN 'SQL'
        WHEN title_name LIKE '%ablea%' THEN 'Tableau'
        WHEN title_name LIKE '%xcel%' THEN 'Excel'
        WHEN title_name LIKE '%ower%' THEN 'Power BI'
        ELSE 'other'
    END AS tool_category,
    COUNT(*) AS video_count
FROM
    `AlexTheAnalyst` AS Tool_Categories
GROUP BY tool_category;

/* Videos per month */
SELECT 
    yearmonth AS Posting_Month,
    COUNT(*) AS video_count
FROM
    `AlexTheAnalyst` AS Videos_Per_Month
GROUP BY yearmonth
ORDER BY COUNT(*) DESC;

/* Videos with more than a million views */
SELECT 
    yearmonth AS Posting_Month,
    SUM(views) AS total_views
FROM
    `AlexTheAnalyst` AS Million_Views
GROUP BY yearmonth
HAVING SUM(views) > 1000000
ORDER BY yearmonth;

/* Change in number of views */
WITH monthly_views AS (
    SELECT 
        yearmonth AS Posting_Month,
        SUM(views) AS total_views
    FROM 
        `AlexTheAnalyst`
    WHERE 
        year = 2020 AND month IN (10, 11)
    GROUP BY 
        yearmonth
    ORDER BY 
        yearmonth DESC
)
SELECT 
    Posting_Month,
    total_views,
    LAG(total_views) OVER (ORDER BY Posting_Month DESC) AS previous_month_views
FROM 
    monthly_views;
