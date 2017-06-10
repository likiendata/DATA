loaddata = load '1998~2017.csv' USING PigStorage (',')
    as (startday:chararray,judgmentDay:chararray,notificationday:chararray,gender:chararray,age:chararray,
	city:chararray,dist:chararray,vill:chararray,minimal:chararray,minimalx:chararray,minimaly:chararray,
	one:chararray,two:chararray,infectioncity:chararray,infectiondist:chararray,infectionvill:chararray,
	outside:chararray,country:chararray,count:chararray,livecode:chararray,infectioncode:chararray,
	serotype:chararray,citycode:chararray,distcode:chararray,infectioncitycode:chararray,infectiondistcode:chararray);
date = foreach loaddata generate ToDate(startday,'yyyy/MM/dd') as (startday_time:DateTime),
          gender,age,city,dist,vill,outside,country,count;
out = FILTER date BY (outside == '否');

gr = GROUP out BY GetYear(startday_time);
countyear = foreach gr GENERATE group,COUNT(out);
rmf po01;
STORE countyear INTO 'po01' USING PigStorage (',');

