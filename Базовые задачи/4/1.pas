program pp;
const
glasn=['�','�','�','�','�','�','�','�','�','�','�','�','�','�','�','�','�','�'];
var s: string;

function summ(var c: string):integer;
var p,i: integer;

begin
p:=0;
for i:=1 to length(s) do
if s[i] in glasn then p:=p+i;
summ:=p;
end;
begin
writeln('������� ������');
readln(s);
writeln(summ(s));
end.