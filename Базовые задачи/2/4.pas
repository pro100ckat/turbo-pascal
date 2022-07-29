program Sr_geom1;
uses crt;
const
    nmax = 12;
type
    tvector=array[1..nmax] of integer;
   var b: tvector;
   n:integer;
   procedure read_mass(var a:tvector; var n: integer);
   var i:integer;
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
procedure write_mass(a:tvector;  n: integer);
   var i:integer;
   begin
   for i:=1 to n do
   write(a[i]:3);
   writeln;
   end;
 function sr_geom(a:tvector; n: integer):real;
    var i,pr,kol:integer;
    g: real;
    begin
    pr:=1;
    kol:=0;
    for i:=1 to n do
    if (i mod 2) <> 0 then begin
    pr:=pr*a[i];
    kol:=kol+1;
    end;
    g:=exp(ln(pr)/kol);
    sr_geom:=g;
    end;
 begin
 read_mass(b,n);
 write_mass(b,n);
 writeln('—реднее геом.= ',sr_geom(b,n));
end.