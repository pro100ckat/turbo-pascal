program sort_mass1;
uses crt;
const nmax=12;
type
tmatrix=array[1..nmax] of integer;
var b:tmatrix;
n:integer;
procedure read_vector(var a:tmatrix; var n:integer);
var i: integer;
begin 
repeat
write('¬ведите количество элементов массива ');
readln(n);
until (n>0) and (n<=nmax);
for i:=1 to n do
begin
write('¬ведите a[',i,']= ');
readln(a[i]);
end;
end;
procedure write_vector(a:tmatrix; n:integer);
var i: integer;
begin
for i:=1 to n do
write(a[i]:3);
writeln;
end;
procedure sort_mass(a:tmatrix; n:integer);
  var i,j,c,sum: integer;
  begin
    for i := 1 to n - 1 do 
    for j := 1 to n-i do 
      if a[j] > a[j + 1] then begin
        c := a[j];
        a[j] := a[j + 1];
        a[j + 1] := c;
      end;
      for i:=1 to n do
write(a[i]:3);
writeln;
      sum:=a[1]+a[2]+a[n];
    writeln('—умма= ',sum);
  end;
begin
read_vector(b,n);
write_vector(b,n);
 sort_mass(b,n);


end.

