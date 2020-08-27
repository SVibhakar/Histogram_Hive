DROP TABLE Histogram;
DROP TABLE CR;
DROP TABLE CG;
DROP TABLE CB;

CREATE TABLE Histogram (
    red int,
    green int,
    blue int) 
row format delimited fields terminated by ',' stored as textfile;

load data local inpath  '${hiveconf:P}' overwrite into table Histogram;

CREATE TABLE CR (type int, red int, intensityr int);
CREATE TABLE CG (type int, green int, intensityg int);
CREATE TABLE CB (type int, blue int, intensityb int);

insert overwrite table CR select 1,Histogram.red, count(Histogram.red) from Histogram group by Histogram.red;
insert overwrite table CG select 2,Histogram.green, count(Histogram.green) from Histogram group by Histogram.green; 
insert overwrite table CB select 3,Histogram.blue, count(Histogram.blue) from Histogram group by Histogram.blue;