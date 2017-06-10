loaddata = load '1998~2017.csv' USING PigStorage (',')
    as (startday:chararray,judgmentDay:chararray,notificationday:chararray,gender:chararray,age:chararray,
        city:chararray,dist:chararray,vill:chararray,minimal:chararray,minimalx:chararray,minimaly:chararray,
        one:chararray,two:chararray,infectioncity:chararray,infectiondist:chararray,infectionvill:chararray,
        outside:chararray,country:chararray,count:chararray,livecode:chararray,infectioncode:chararray,
        serotype:chararray,citycode:chararray,distcode:chararray,infectioncitycode:chararray,infectiondistcode:chararray);
date = foreach loaddata generate ToDate(startday,'yyyy/MM/dd') as (startday_time:DateTime),
          gender,age,city,dist,vill,outside,country,count;

year = FILTER date BY (GetYear(startday_time) >= 2015);
out = FILTER year BY (outside == '否');

gre = GROUP out BY (city,GetYear(startday_time));

countyear = foreach gre GENERATE group.$0,COUNT(out) as count;
od = limit (ORDER countyear BY count DESC) 20;

rmf po03;
STORE od INTO 'po03' USING PigStorage (',');

