-- Creating external table referring to gcs path
CREATE OR REPLACE EXTERNAL TABLE dataengineering-468103.demo_dataset.external_yellow_tripdata
OPTIONS (
  format = 'PARQUET',
  uris = ['gs://dataengineering-468103-terra-bucket/yellow_tripdata_2019-*.parquet', 
          'gs://dataengineering-468103-terra-bucket/yellow_tripdata_2020-*.parquet']
);

CREATE OR REPLACE EXTERNAL TABLE dataengineering-468103.demo_dataset.external_green_tripdata
OPTIONS (
  format = 'PARQUET',
  uris = ['gs://dataengineering-468103-terra-bucket/green_tripdata_2019-*.parquet', 
          'gs://dataengineering-468103-terra-bucket/green_tripdata_2020-*.parquet']
);

-- Check yellow trip data
SELECT * FROM dataengineering-468103.demo_dataset.external_yellow_tripdata limit 10;

-- Create a non partitioned table from external table
CREATE OR REPLACE TABLE dataengineering-468103.demo_dataset.yellow_tripdata_non_partitoned AS
SELECT * FROM dataengineering-468103.demo_dataset.external_yellow_tripdata;

-- Create a partitioned table from external table
CREATE OR REPLACE TABLE dataengineering-468103.demo_dataset.yellow_tripdata_partitoned
PARTITION BY
  DATE(tpep_pickup_datetime) AS
SELECT * FROM dataengineering-468103.demo_dataset.external_yellow_tripdata;

-- Impact of partition
-- Scanning 1.6GB of data
SELECT DISTINCT (VendorID)
FROM dataengineering-468103.demo_dataset.yellow_tripdata_non_partitoned
WHERE DATE(tpep_pickup_datetime) BETWEEN '2019-06-01' AND '2019-06-30';

-- Scanning ~106 MB of DATA
SELECT DISTINCT (VendorID)
FROM dataengineering-468103.demo_dataset.yellow_tripdata_partitoned
WHERE DATE(tpep_pickup_datetime) BETWEEN '2019-06-01' AND '2019-06-30';

-- Let's look into the partitions
SELECT table_name, partition_id, total_rows
FROM demo_dataset.INFORMATION_SCHEMA.PARTITIONS
WHERE table_name = 'yellow_tripdata_partitoned'
ORDER BY total_rows DESC;

-- Creating a partition and cluster table
CREATE OR REPLACE TABLE dataengineering-468103.demo_dataset.yellow_tripdata_partitoned_clustered
PARTITION BY DATE(tpep_pickup_datetime)
CLUSTER BY VendorID AS
SELECT * FROM dataengineering-468103.demo_dataset.external_yellow_tripdata;

-- Query scans 715.8 MB
SELECT count(*) as trips
FROM dataengineering-468103.demo_dataset.yellow_tripdata_partitoned
WHERE DATE(tpep_pickup_datetime) BETWEEN '2019-06-01' AND '2019-12-31'
  AND VendorID=1;

-- Query scans 564 MB
SELECT count(*) as trips
FROM dataengineering-468103.demo_dataset.yellow_tripdata_partitoned_clustered
WHERE DATE(tpep_pickup_datetime) BETWEEN '2019-06-01' AND '2019-12-31'
  AND VendorID=1;
