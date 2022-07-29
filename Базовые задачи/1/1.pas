program p1;
var y,x: real;
begin
write('x= ');
readln (x);
if x<=-3 then y:=-x-3
else if (x>-3) and (x<3) then y:=0
else y:=3-x;
writeln('y= ',y);
end.