program pp;
const
nmax=50;

type
stud=record
fam: string[30];
imya: string[20];
game: boolean;
phone: string;
end;

type mass=array[1..nmax] of stud;

procedure read_mass(var n: integer; var a: mass);
var i: integer;
begin
writeln('Введите число учащихся');
readln(n);
for i:=1 to n do
begin
writeln('Введите фамилию');
readln(a[i].fam);
writeln('Введите имя');
readln(a[i].imya);
writeln('Введите телефон');
readln(a[i].phone);
writeln('Увлечение играми');
readln(a[i].game);
end;
end;

function phone( var famil:string; a: mass; n:integer):string;
var f:boolean;
i:integer;
begin
f:=false;
i:=1;
while(i<=n)and (f=false) do
if a[i].fam=famil then
 begin
  f:=true;
  phone:=a[i].phone;
 end
else i:=i+1;
if (f=false) then phone:='NO';
end;

procedure writeln_mass(n:integer; a:mass);
var fl: boolean;
i: integer;
begin
fl:=false;
for i:=1 to n do 
if (a[i].game=true) then 
fl:=true;
if fl=false then
writeln('Играющих нет')
else begin
writeln('Играют: ');
 for i:=1 to n do
if (a[i].game=true) then 
writeln(a[i].fam); 
end;
 
fl:=false;
for i:=1 to n do
if (a[i].game=false) then
fl:=true; 
if fl=false then writeln('Не играющих нет')
else begin
writeln('Не играют');
for i:=1 to n do
if (a[i].game=false) then
writeln(a[i].fam);
end;
end;
function kolvo_igr(a: mass; n: integer):integer;
var sumt,i: integer;
begin
sumt:=0;
for i:=1 to n do 
if (a[i].game=true) then 
 sumt:=sumt+1; 
kolvo_igr:=sumt;
end;

function kolvo_ne_igr(a: mass; n:integer):integer;
var sumf,i: integer;
begin
sumf:=0;
for i:=1 to n do
if (a[i].game=false) then 
 sumf:=sumf+1;
kolvo_ne_igr:=sumf;
end;

var
p:mass;
n:integer;
fm: string;
begin 
read_mass(n,p);
writeln('Введите фамилию');
readln(fm);
writeln(phone(fm,p,n));
 writeln_mass(n,p);
writeln('Играют: ',kolvo_igr(p,n));
writeln('Не играют: ',kolvo_ne_igr(p,n));
end.