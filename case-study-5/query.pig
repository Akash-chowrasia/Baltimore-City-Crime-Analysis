fs -put baltimore.csv / 
a = load "/Baltimore.csv" using PigStorage(",") as (sno, date:datetime, time:datetime, code, address, description, io, weapon, post, district, nearest, longitude, latitude, premesis, total); 
b = filter a by GetYear(date) == 2014 and (district matches 'CENTRAL' or district matches 'SOUTHERN') and description matches 'BURGLARY'; 
c = group b by date; 
d = foreach c generate group, COUNT(b); 
e = group d by GetMonth($0); 
f = foreach e generate group as (a:chararray),AVG(d.$1) as (b:chararray); 
g = foreach f generate CONCAT('In Month', $0, ' Average ', $1,'Attemp to crime cases are reported'); 
dump g; 

