program max_po_modul_el_mass2;
uses crt;
const nmax=3; 
const mmax=4;

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
readln(a[i,j]);
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
function max_po_mod(a:tmatrix; n,m: integer):integer;
var i,j,max: integer;
begin
max:=a[1,1];
for i:=1 to n do 
for j:=1 to m do begin
if (abs(a[i,j])>abs(max)) then 
max:=a[i,j];
end;
max_po_mod:=max;
end;
begin
read_matrix(b,n,m);
write_matrix(b,n,m);
writeln('Максимальный по мод.= ',max_po_mod(b,n,m));
end.




