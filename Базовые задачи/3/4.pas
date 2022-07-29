program lab3_2_1; 

const 
nmax = 50; 
var
b: string;
n: integer;

procedure read_line(var a: string; var n: integer); 
var 
i: integer; 
begin 
write('Введите кол-во слов n='); 
readln(n); 
writeln('Вводите слова'); 
readln(a); 
end; 

procedure writeln_line(a: string; n: integer);
var 
i: integer;
begin
writeln(a);
end;

function Glasn(a: string; n: integer): integer; 
var 
kol_vo, i: integer; 
begin 
kol_vo:=0;
for i := 1 to n  do 
begin  if (a[i]='a') or (a[i]='e') or (a[i]='i') or (a[i]='o') or (a[i]='u') or (a[i]='y')
 or (a[i]='A')  or (a[i]='E')  or (a[i]='I')  or (a[i]='O')  or (a[i]='U')  or (a[i]='Y') then 
kol_vo:=kol_vo+1;
end; 
Glasn:=kol_vo;
end; 

begin 
read_line(b,n); 
writeln_line(b,n);
writeln('Количество гласных ', glasn(b, n)); 
end.