program sredU;
 

 
uses
  crt;
 
type
  ssilka = ^Integer;
  vector = array [1..20] of ssilka;
var
  v: vector;
  i: Integer;  
  resultOfSred: Double;
 
function sred(var x: vector): Double;  
var
  i, n: byte;
  sum: SmallInt;
begin
  sum := 0;
  n := 0;    
  for i := 1 to 20 do
    if x[i]^ > 0 then begin
      Inc(n);
      sum := sum + (x[i]^);
    end;
  if n > 0 then
    Result := sum / n 
  else
    Result := 0;
end;
 
begin
  Randomize;
  WriteLn('Массив:');
  for i := 1 to 20 do begin 
    New(v[i]);
    
    v[i]^ := Random(1000) - Random(1000); 
 
 
    Write(v[i]^, ':'); 
  end;
  WriteLn;
 
  
  resultOfSred := sred(v);
  if resultOfSred = 0 then
    Writeln('Положительных чисел нет ')
  else
    Writeln('Среднее арифметическое: ', resultOfSred);
 
  for i := 1 to 20 do
    Dispose(v[i]);
end.