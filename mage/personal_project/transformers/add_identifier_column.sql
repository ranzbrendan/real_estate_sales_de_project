SELECT * FROM {{ df_1 }};

ALTER TABLE `crack-celerity-435208-v5.real_estate_sales_db.source_table`
ADD COLUMN sale_id INT64, 
ADD COLUMN row_num INT64;

UPDATE `crack-celerity-435208-v5.real_estate_sales_db.source_table` AS t
SET 
    sale_id = tmp.sale_id,
    row_num = tmp.row_num
FROM (
  SELECT 
    serial_number, 
    list_year, 
    date_recorded, 
    town, 
    DENSE_RANK() OVER(ORDER BY serial_number, list_year, date_recorded, town) AS sale_id,
    ROW_NUMBER() OVER(PARTITION BY serial_number, list_year, date_recorded, town) AS row_num
  FROM `crack-celerity-435208-v5.real_estate_sales_db.source_table`
) AS tmp
WHERE t.serial_number = tmp.serial_number
  AND t.list_year = tmp.list_year
  AND t.date_recorded = tmp.date_recorded
  AND t.town = tmp.town;

DELETE FROM `crack-celerity-435208-v5.real_estate_sales_db.source_table`
WHERE row_num > 1;

ALTER TABLE `crack-celerity-435208-v5.real_estate_sales_db.source_table`
DROP COLUMN row_num;
  