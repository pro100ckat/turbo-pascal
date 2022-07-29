program pp;
uses crt;

var 
ch,fl: integer;

function proverka_del(var a: integer) :boolean;
var b: integer;
fl: boolean;
begin
b:=a mod 10000;
   if b mod 8 =0 then fl:=true
else
fl:=false;

proverka_del:=fl;
end;

 begin 
 writeln('Введите число');
 readln(ch);
 writeln('true- делится на 8, false - не делится на 8');
 writeln(proverka_del(ch));
 end.



