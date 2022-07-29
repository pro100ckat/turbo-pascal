program pp;
const
glasn=['а','е','ё','и','о','у','э','ю','я','А','Е','Ё','И','О','У','Э','Ю','Я'];
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
writeln('Введите строку');
readln(s);
writeln(summ(s));
end.