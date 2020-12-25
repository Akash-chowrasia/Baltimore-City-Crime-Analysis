b = group a by district;
c = foreach b generate group,COUNT(a);
d = order c by $1 DESC;
e = limit d 1;
f = filter a by district matches e.$0 and weapon matches „KNIFE‟ and   GetYear(date) <= 2017 and (io matches „I‟ or io matche „Inside‟);  >>> g = group f by nearest;
h = foreach g generate group,COUNT(f);
I = order h by $1;
j = limit I 5;
dump j;
