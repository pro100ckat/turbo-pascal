program p3;
var y,x,xmin,xmax,h: real;
begin
xmin:=0;
xmax:=1;
h:=0.1;
x:=xmin;
while x<=xmax do begin
if x<0.5 then 
y:=sin(sqr(x))*cos(sqr(x-1))-sqrt(x+abs(x))
else
y:=2*exp(x-1)+sqr(ln(x))*cos(x-1);
writeln('x =',x, ' y=',y);
x:=x+h;
end;
end.
