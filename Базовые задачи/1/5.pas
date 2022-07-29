program p4;
var n: integer;
s,x: real;
begin
n:=2;
s:=0;
while x<=18 do begin
x:=1/n-1/(n+2);
s:=s+x;
n:=n+4;
end;
writeln(s);
end.
