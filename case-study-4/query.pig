fs -put baltimore.csv / 
a = load "/Baltimore.csv" using PigStorage(",") as (sno, date:datetime, time:datetime, code, address, description, io, weapon, post, district, nearest, longitude, latitude, premesis, total); 
b = filter a by (nearest matches '.*Hill.*' or nearest matches '.*hill.*') and description matches 'HOMICIDE'; 
c = group b by nearest; 
d = foreach c generate group,COUNT(b); 
e = filter d by $1 >= 10; 
dump e; 

