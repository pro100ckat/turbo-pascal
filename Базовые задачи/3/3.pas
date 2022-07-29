program pp;
const 
nmax = 50;
type tslova=array[1..nmax] of string;
var
n,m:integer;
str,sim: string;
d,e:tslova;
procedure write_slova(x,s: string; var a,b: tslova; var num,mas: integer);
var  i,j,ch: integer;
begin
num:=0;
i:=1;
while i<=length(x) do
begin//Просматриваем символы до конца строки
while (i<=length(x)) and (copy(x,i,1)=' ')  do  
                                         i:=i+1;//Пропускаем все побелы

if i<=length(x) then//Если не конец строки
   begin//То I находится на первом значимом символе в начале слова
   J:=i;//Присваиваем j позицию первого симовла
   while (i<=length(x)) and (copy(x,i,1)<>' ') do 
        i:=i+1;//Длина слова
        
       if (i-j>0) then //если длина больше 0
       begin
       num:=num+1;//Увеливаем количество слов в массиве
       a[num]:=copy(x,j,i-j);//Каждой позиции в массиве присваиваем слово
       end;
   end;
end;
i:=1;
while i<=num do begin
mas:=0;
for ch:=1 to length(a[i]) do begin 
   //То сh находится на первом значимом символе в начале слова
     mas:=mas+1;//Увеливаем количество симоволов в массиве
      b[mas]:=copy(a[i],ch,1);//Каждой позиции в новом массиве присваиваем символ
 
       end;
        if (b[1]=s) and (b[mas]=s) then writeln(a[i]);
   i:=i+1;
   end;
end;
begin
writeln('Введите строку');
readln(str);
Writeln('Введите символ');
readln(sim);
write_slova(str,sim,d,e,n,m);

end.


