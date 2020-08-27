DROP TABLE Histogram;

CREATE TABLE Histogram (
    red int,
    green int,
    blue int) PARTITIONED BY (type int, count int)
row format delimited fields terminated by ',' stored as textfile;

load data local inpath  '${hiveconf:P}' overwrite into table Histogram;

INSERT INTO insert_partition_demo PARTITION(dept=1) VALUES (1, 'abc');

insert into Histogram PARTITION(type=1, count(Histogram.red)) group by Histogram.red;
insert into Histogram PARTITION(type=2, count(Histogram.green)) group by Histogram.green;
insert into Histogram PARTITION(type=3, count(Histogram.blue)) group by Histogram.blue;

SHOW PARTITION.type, Histogram.red, PARTITION.count group by Histogram.red FROM TABLE Histogram;
SHOW PARTITION.type, Histogram.green, PARTITION.count group by Histogram.green FROM TABLE Histogram;
SHOW PARTITION.type, Histogram.blue, PARTITION.count group by Histogram.blue FROM TABLE Histogram;