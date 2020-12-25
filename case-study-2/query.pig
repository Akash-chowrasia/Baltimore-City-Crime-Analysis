fs -put baltimore.csv / 
a = load "/Baltimore.csv" using PigStorage(",") as (sno, date:datetime, time:datetime, code, address, description, io, weapon, post, district, nearest, longitude, latitude, premesis, total); 
b = filter a by (GetMonth(date) >= 08 or GetMonth(date) <= 02) and disctrict matches "NORTHEASTERN";
c = group b by time;
d = foreach c generate group,COUNT(b);
e = order d by $1 DESC;
f = limit e 5;
x = order f by $0 DESC;
g = limit x 1;
h = order f by $0;
I = limit h 1;
j = join g by GetMonth($0),I by GetMonth($0);
k = foreach j generate GetHour($0) as (h1:chararray),GetMinute($0) as (m1:chararray),GetSecond($0) as (s1:chararray),GetHour($2) as (h2:chararray),  GetMinute($2) as (m2:chararray),GetSecond($2) as (s2:chararray);
l = fooreach k generate CONCAT("From", $0 ,":", $1, ":", $2, "To" ,$3 ,":", $4, ":", $5);
dump l;
