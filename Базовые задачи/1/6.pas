program p5;
var
x,y,z,c: integer;
begin
writeln('������� ����� ������');
readln(x);
case x of
1: writeln('������');
2: writeln('�������');
3: writeln('����');
4: writeln('������');
5: writeln('���');
6: writeln('����');
7: writeln('����');
8: writeln('������');
9: writeln('��������');
10: writeln('�������');
11: writeln('������');
12: writeln('�������')
else writeln ('����� ������ ������ �����������');
end;
writeln('������� ���');
readln(z);
writeln('������� �����');
readln(y);
if ((z mod 4<>0)and (z mod 100<>0) and(z mod 400<>0) and (x=2) and (y=28)) or 
( ((x=1) or (x=4) or (x=6) or(x=9) or (x=11)) and (y=30)) or ((( x=3) or (x=5) or (x=7) or (x=8) or (x=10)) and (y=31))
then 
begin c:=1; 
writeln('���������� ����� ',c); end 

else begin
inc(y);
writeln('���������� ����� ',y);

end;
 
end.