program p5;
var
x,y,z,c: integer;
begin
writeln('Введите номер месяца');
readln(x);
case x of
1: writeln('Январь');
2: writeln('Февраль');
3: writeln('Март');
4: writeln('Апрель');
5: writeln('Май');
6: writeln('Июнь');
7: writeln('Июль');
8: writeln('Август');
9: writeln('Сентябрь');
10: writeln('Октябрь');
11: writeln('Ноябрь');
12: writeln('Декабрь')
else writeln ('Номер месяца указан неправильно');
end;
writeln('Введите год');
readln(z);
writeln('Введите число');
readln(y);
if ((z mod 4<>0)and (z mod 100<>0) and(z mod 400<>0) and (x=2) and (y=28)) or 
( ((x=1) or (x=4) or (x=6) or(x=9) or (x=11)) and (y=30)) or ((( x=3) or (x=5) or (x=7) or (x=8) or (x=10)) and (y=31))
then 
begin c:=1; 
writeln('Завтрашнее число ',c); end 

else begin
inc(y);
writeln('Завтрашнее число ',y);

end;
 
end.