Program Dyn;
Type elemp = ^elem; //объ€вл€ем тип указател€ на элемент списка
     elem = record //запись - элемент списка
     n:real;
     next:elemp;//указатель на следующий элемент
     end;
var start,endd,temp:^elem;//указатели на начало, конец списка и вспомогательный указатель
    i:integer;
    m,q:real;

function multminmax(start:elemp):real;//функци€, котора€ ищет максимальный, минимальный элемент и перемножает их
var  max,min:real;
     cur:elemp;//указатель - курсор при переборе списка
begin
if start<>nil then//если список не пустой
   begin
   cur:=start;//устанавливаем курсор на старт
   max:=start^.n;//задаем начальные значени€ максимума и минимума
   min:=start^.n;
   while cur<>nil do//пока не дощли до конца
      begin
      if cur^.n>max then max:=cur^.n;//провер€ем на максимум и минимум
      if cur^.n<min then min:=cur^.n;
      cur:=cur^.next;//смещаем курсор на следующий элемент
      end;
   multminmax:=min*max;//перемножаем то, что нашли
   writeln('ћинимальный элемент ',min:5:3);//выводим минимальный и максимальный элементы
   writeln('ћаксимальный элемент ',max:5:3);
   end;
end;

begin
randomize;
new(start);//выдел€ем пам€ть дл€ первого элемента
start^.n:=random(1000)/100+10;//записываем его
write(start^.n:5:3,'  ');
start^.next:=nil;
endd:=start;//конец пока что совпадает с началом
for i:=1 to 39 do
    begin
    new(endd^.next);//выдел€ем пам€ть дл€ очередного элемента
    endd:=endd^.next;//переносим конец списка на этот элемент
    endd^.n:=random(1000)/100+10;//генерируем
    endd^.next:=nil;//этот элемент пока что последний
    write(endd^.n:5:3,'  ');//выводим его
    end;
writeln('');
writeln('');
m:=multminmax(start);//ищем произведение максимума и минимума
writeln('ѕроизведение максимального и минимального элемента списка равно ',m);
new(temp);//выдел€ем пам€ть дл€ элемента
temp^.n:=m;//записываем его
temp^.next:=start;//и помещаем в начало
start:=temp;
writeln('ѕроизведение добавлено в начало списка ');




temp:=start;//курсор помещаем в начало (temp в роли курсора)
while temp<>nil do//пробегаем по списку и освобождаем пам€ть, пока не додем до конца
      begin
      temp:=start^.next;
      write(start^.n:5:3,'  ');
      dispose(start);
      start:=temp;
      end;
end.