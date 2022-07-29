program MaximuM;
uses crt;
const 
mmax=10;
nmax=10;
type
tvector=array[1..mmax,1..nmax] of integer;   
var
b: tvector;
m,n: integer;	
 
 procedure read_matrix(var matrix:tvector; var m, n: integer);
 var i,j: integer;
 Begin
 repeat
write('Ââåäèòå êîëè÷åñòâî ñòğîê ìàòğèöû ');
read(m);
until (m>0) and (m<=nmax);
repeat
write('Ââåäèòå êîëè÷åñòâî ñòîëáöîâ ìàòğèöû ');
read(n);
until (n>0) and (n<=mmax);
for i:=1 to m do begin
for j:=1 to n do begin
writeln('Ââåäèòå a[',i,',',j,']= ');
 readln(matrix[i,j]);
 end;
 end;
 end;
 
 
 procedure write_matrix(var matrix: tvector; var m,n:integer);
var i,j: integer;
begin
for i:=1 to n do begin
for j:=1 to m do
write(matrix[i,j]:3);
writeln;
end;
end;

function stroka_s_minim_el(var matrix: tvector; var m,n: integer): integer;
 var flag,smin,min,i,j: integer;
begin
 min:= matrix[1,1];
for i:=1 to m do begin
for j:=1 to n do begin
if matrix[i,j]<min then
min:=matrix[i,j];
end;
end;
flag:=0;
for i:=1 to m do begin
for j:=1 to n do begin
if matrix[i,j]=min then 
if flag=0 then
begin
smin:=i;
flag:=1;
end;
end;
end;
stroka_s_minim_el:=smin;
end;

procedure dobavlenie_stroki(var matrix: tvector; var m: integer; n: integer);
var i,j,smin: integer;
begin
for i:=m+1  downto smin+2 do begin
for j:=1 to n do begin
matrix[i,j]:=matrix[i-1,j];
end;
end;

i:=smin+1;
for j:=1 to n do begin
matrix[smin+1,j]:=matrix[1,j];
end;
end;


procedure write_matrix_nov(var matrix: tvector; var m,n : integer);
var i,j: integer;
begin
 for i:=1 to m+1 do begin
for j:=1 to n do
write(matrix[i,j]:3);
writeln;
end;
 end;
 begin
 read_matrix(b,m,n);
write_matrix(b,m,n);
writeln('Còğîêà ñ ìèíèìàëüíûì ıëåìåíòîì ',stroka_s_minim_el(b,m,n));
dobavlenie_stroki(b,m,n);
write_matrix_nov(b,m,n);
end.
  