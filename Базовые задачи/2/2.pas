program kol_vo_summ;
uses crt;
const nmax=4; 
const mmax=5;

type tmatrix=array[1..nmax,1..mmax] of integer;
var b:tmatrix;
n,m: integer;
procedure read_matrix(var a:tmatrix; var n,m: integer);
var i,j: integer;
begin 
repeat
write('Введите количество строк матрицы ');
read(n);
until (n>0) and (n<=nmax);
repeat
write('Введите количество столбцов матрицы ');
read(m);
until (m>0) and (m<=mmax);
for i:=1 to n do
for j:=1 to m do begin
writeln('Введите a[',i,',',j,']= ');
read(a[i,j]);
writeln;
end;
end;
procedure write_matrix(a:tmatrix; n,m: integer);
var i,j: integer;
begin
for i:=1 to n do begin
for j:=1 to m do
write(a[i,j]:3);
writeln;
end;
end;
function kol_vo(a:tmatrix; n,m: integer):integer;
var i,j,kol: integer;
begin
kol:=0;
 i:=3;  
for j:=1 to m do
if abs(a[i,j])>1 then
kol:=kol+1;
kol_vo:=kol;
end;
function Sum_kv(a:tmatrix; n,m: integer):integer;
var i,j,sum: integer;
begin
sum:=0;
 i:=3;  
for j:=1 to m do
if abs(a[i,j])>1 then 

sum:=sum+sqr(a[3,j]);
Sum_kv:=sum;
end;
begin
read_matrix(b,n,m);
write_matrix(b,n,m);
writeln('Количество= ',kol_vo(b,n,m));
writeln('Сумма квадратов= ',Sum_kv(b,n,m));
end.