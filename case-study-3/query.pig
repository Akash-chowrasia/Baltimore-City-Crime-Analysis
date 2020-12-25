fs -put baltimore.csv / 
a = load "/Baltimore.csv" using PigStorage(",") as (sno, date:datetime, time:datetime, code, address, description, io, weapon, post, district, nearest, longitude, latitude, premesis, total); 
b = filter a by GetYear(date) == 2013;
c = filter b by description  
matches 'RAPE'; 
d = foreach c generate  
post as temppost; 
t = distincts d; 
e = join b by post LEFT OUTER,t by temppost; 
f = filter e by temppost is null; 
g = group f by post; 
h = foreach g generate group,COUNT(f); 
i = filter h by $1 < 5; 
dump i; 

