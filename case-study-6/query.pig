fs -put baltimore.csv / 
a = load "/Baltimore.csv" using PigStorage(",") as (sno, date:datetime, time:datetime, code, address, description, io, weapon, post, district, nearest, longitude, latitude, premesis, total); 
b = filter a by description matches 'COMMON ASSAULT'; 
c = group b by post; 
d = foreach c generate group, b.district, COUNT(b); 
e = foreach d generate $0,flatten($1),$2; 
f = distinct e; 
g = group f by $1; 
h = foreach g generate group, MAX(f.$2); 
i = join f by $1,h by $0; 
j = filter i by $2 == $4; 
h = foreach j generate $1,$0,$2; 
dump h; 

