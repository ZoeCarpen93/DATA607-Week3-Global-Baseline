USE zoedb;

SELECT
	*,
    AVG(price) OVER (
        PARTITION BY item, YEAR(date)
        ORDER BY date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS ytd_avg,
    AVG(price) OVER (
        PARTITION BY item
        ORDER BY date
        ROWS BETWEEN 5 PRECEDING AND CURRENT ROW
    ) AS ma_6
FROM generated_stock_data
ORDER BY date DESC, item;


