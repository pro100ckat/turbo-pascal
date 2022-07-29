program p3;
var x,y1: integer;
    z,y2: real;
begin 
writeln('¬ведите x');
readln(x);
y1:=x-4;
if x>-1 then 
y2:=sqrt(x)+1
else
y2:=abs(x)-1;
if y1>2*y2 then
z:=y1+y2
else
z:=3*y1-y2;
writeln(z);
end.    