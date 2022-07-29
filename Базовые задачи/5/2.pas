program LB5_2;
uses crt;
var
  filename: string;
  b: integer;

procedure create;
var
  f: file of real;
  k: array[1..1000] of real;
  i: integer;
begin
  assignfile(f, 'a.txt');
  reset(f);
  for i := 1 to 10 do 
  begin
    k[i] := random(1000) / 10 - 50;
    write(f, k[i]);
  end;
  writeln('Создан файл');
  closefile(f);
end;

procedure display;
var
  t: file of real;
  k: real;
begin
  assignfile(t, 'a.txt');
  reset(t);
  while not eof(t) do 
  begin
    read(t, k);
    writeln(k);
  end;
  closefile(t);
end;

procedure sumreal(fname: string);
var
  f: file of real;
  i: integer;
  t: file of real;
   k: array[1..1000] of real;
  sum, a, qw1, qw2, min: real;
begin
  assign(f, fname);
  reset(f);
  sum := 0;
  i := 0;b:=0;
  b:=0;
  while i < filesize(f) do 
  begin
    read(f, a);
    sum := sum + a * a;
    if min > a then 
      min := a;
      
       i := i + 1;
       end;
     
       close(f);
       reset(f);
       for i:=1 to filesize(f) do
        begin
    read(f, a);
      if a=min then
       b:=i;
 end;

  qw2 := sum;
 readln;
 
  for  i := b to  filesize(f)-1  do 
  begin
    seek(f, i); 
    read(f, qw1);
    seek(f, i);
    write(f, qw2);
    qw2 := qw1;
  end;
  write(f, qw2);
  close(f);
end;

begin
  filename := 'a.txt';
  create;
  display;
  sumreal(filename);
  clrscr;
  writeln('готово');
  display;
end.