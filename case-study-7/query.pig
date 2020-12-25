fs -put baltimore.csv / 
a = load "/Baltimore.csv" using PigStorage(",") as (sno, date:datetime, time:datetime, code, address, description, io, weapon, post, district, nearest, longitude, latitude, premesis, total); 
b = filter a by nearest matches ".*Hill.*" or nearest matches ".*hill.*"; 
c = group b by nearest; 
d = foreach c generate group,COUNT(b); 
e = order d by $1; 
f = limit e 1; 
dump f; 

