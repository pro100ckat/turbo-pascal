program restoranBD;
{Коваленко В.А. 9В класс}
uses Crt,Dos;
const up   =#72;
const down =#80;
const enter=#13;
Type restoran=record
nazv:string[10];
ves:string[4];
kkal:string[5];
sostav:string[100];
klas:string[15];
cena:string[8];
end;
var
      ms: array[ 1 .. 20 ] of string;
      ms1: array[ 1 .. 20 ] of string;
      ms2: array[ 1 .. 20 ] of string;
      ms3: array[ 1 .. 20 ] of string;
      ms4: array[ 1 .. 20 ] of string;
      ms5: array[ 1 .. 20 ] of string;

    f: file of restoran;
    zapbd: restoran;
    masbd: array[0..60] of restoran;
    m:integer; { кол-во записей в БД }
    a:char;

     reg:  Registers;
     mouse_x,mouse_y:word;


{______________Копирайт____________}

procedure copyright;
begin
 gotoxy(15,23); write(' ');
 gotoxy(15,24); write('khabarovsk, 2013');
end;


{ ------  Выключение курсора -------------}
procedure CursorOff; assembler;
        asm
          mov   ah,1
          mov   cx,2020h   {Убрать мерцание за пределы знакоместа}
          int   10h
        end;

{ ------  Включение курсора -------------}
procedure CursorOn; assembler;
        asm
          mov   ah,1
          mov   cx,0607h   {Установить мерцание 6й и 7й строк}
          int   10h
        end;





{-------- Включение курсора мыши -----------------------}
Procedure mouse_on;
begin

  reg.ax:=$1;
  intr($33,reg);
end;

{-------- Определение координат курсора мыши ------------------}
Procedure mouse_xy(var x,y:word);
begin
  reg.ax:=$3;
  intr($33,reg);
       x:=reg.cx;
       y:=reg.dx;
end;

{-------- Проверка нажатия левой кнопки мыши ------------------}

function mouse_key_left : boolean ;
begin
  reg.ax:=$3;
  intr($33,reg);
if (reg.bx and 00000001)>0 then mouse_key_left:=true else mouse_key_left:=false;
end;

{-------- Проверка нхождения курсора мыши в текстовом диапазоне -------------}


function mouse_diapazon(x1,y1,x2,y2:word) : boolean ;
var x,y:word;
begin
  reg.ax:=$3;
  intr($33,reg);
       x:=reg.cx;
       y:=reg.dx;

if ((y>=y1*8-8) and (y<y2*8)) and ((x>=x1*8) and (x<=(x2-2)*8)) then mouse_diapazon:=true else mouse_diapazon:=false;
end;
{================================}


{----------------- Процеду загрузки экрана -----------------------}
Procedure wait(x:integer);
Var j,i:integer;
Begin
For j:=1 to 1500 do
For i:=1 to x do
Write('');
End;


{------- Рисование одинарной рамки --------------------------}

procedure ramka(x1,y1,x2,y2:integer);

var yg1,yg2,yg3,yg4:char;
lg,lv:char;
i:integer;
begin
textcolor(15);
yg1:=#218; yg2:=#191; yg3:=#217; yg4:=#192;
lg:=#196; lv:=#179;

gotoxy(x1,y1); write(yg1);
gotoxy(x2,y1); write(yg2);
gotoxy(x2,y2); write(yg3);
gotoxy(x1,y2); write(yg4);
for i:=x1+1 to x2-1 do
begin
gotoxy(i,y1); write(lg);
gotoxy(i,y2); write(lg);
end;
for i:=y1+1 to y2-1 do
begin
gotoxy(x1,i); write(lv);
gotoxy(x2,i); write(lv);
end;
end;




{------ Функция рисования меню  --------}

function menu( mas: array of string; n,x0,y0:integer):integer;
  var k,i,j, y: integer;
  a,b:word;
  tmp:string[80];
  begin



CursorOff;
  tmp:='';
    for i:=1 to length(mas[1]) do tmp:=tmp+' ';
  textbackground(3);
  gotoxy(x0,y0); write(tmp);
  gotoxy(x0,y0+n+1); write(tmp);
  y:=1;
  textcolor(15);
  repeat
     for i:=0 to n-1 do begin
       if (i+1)=y then textbackground(5) else textbackground(3);
       gotoxy(x0,y0+i+1);   write(mas[i]);
     end;
       textbackground(3);
       ramka(x0-1,y0,x0+length(mas[1]),y0+n+1);
       if keypressed then
       case  readkey of
      down : if y < n then y:=y +1 else  y:=1;

      up      : if y<>1 then y:=y - 1 else y:=n;
      enter  : begin  menu:= y;   CursorOn; exit;    end;
    end;

    { - - - - - - - - - - -}
      if mouse_key_left=true then
   begin
   for j:=1 to n do
  if mouse_diapazon(x0,y0+j,x0+length(mas[1])-1,y0+j)
  then  begin

   for i:=0 to n-1 do begin
       if (i+1)=j then textbackground(5) else textbackground(3);
       gotoxy(x0,y0+i+1);   write(mas[i]);
     end;
     textbackground(3);
     ramka(x0-1,y0,x0+length(mas[1]),y0+n+1);
             wait(25);
  CursorOn;  menu:= j;   exit;    end;
 end;
  { - - - - - - - - - - -}


until false;

end;

{------------------------------------------------}
Procedure indicator(x,y:integer);
Var i:integer;
Begin
Textcolor(3);
Gotoxy(x,y); write(chr(201));
Gotoxy(x,y+4); write(chr(200));
Gotoxy(x+48,y); write(chr(187));
Gotoxy(x+48,y+4); write(chr(188));
For i:=1 to 47 do begin
Gotoxy(x+i,y); write(chr(205));
Gotoxy(x+i,y+4); write(chr(205));
End;
For i:=1 to 3 do begin
Gotoxy(x,y+i); write(chr(186));
Gotoxy(x+48,y+i); write(chr(186));
end;
y:=y+2;
x:=x+2;
Textcolor(2);
GotoXY(x,y);
Write(Chr(179));
GotoXy(x,y+1);
Write('0%');
GotoXY(x+20,y);
Write(Chr(179));
GotoXY(x+20,y+1);
Write('50%');
GotoXY(x+41,y);
Write(Chr(179));
GotoXY(x+40,y+1);
Write('100%');
For i:=1 to 42 do
Begin
GotoXY(x+i-1,y);
Write(Chr(177));
Wait(8);
End;
End;
{------------ Функция Да / Нет   --------------------}

function yes_no:boolean;
begin

yes_no:=false;
if readkey IN ['y','Y','Н','н'] then yes_no:=true;

end;

{------------ Процедура для создания новой пустой БД   --------------------}
   procedure new_bd(a:string);
          begin
              textbackground(1);
               clrscr;
               gotoxy(35,8);
               write('ВНИМАНИЕ!');


               gotoxy(10,12);
               write('Продолжить создание нового файла [Y/N], вся инфориция будет УДАЛЕНА');

               if yes_no=false then begin textbackground(1); clrscr; exit; end;
               assign(f,a);  { связать имя файла БД с переменной f }
               rewrite(f);   { создать новый файл БД и открыть для записи данных }
               close(f);     { закрыть файл БД }
               clrscr;
               indicator(20,8);
               gotoxy(8,15);
               textcolor(15);
               write('Файл БД - ',a,' создан. Для продолжения нажмите любую клавишу');
               readkey;
               textbackground(1); clrscr;
          end;


{------------ Процедура ввода пароля   --------------------}

procedure password;
var j,q,t:integer;
begin
repeat
clrscr;
j:=1;q:=1;
textcolor(14);textcolor(15);
gotoxy(30,9);
write('_________________________');
gotoxy(30,10);
write('Для доступа к базе данных');
gotoxy(35,11);;
write('Введите пароль            ');
gotoxy(30,12);
t:=39;
repeat
  a:=readkey; gotoxy(t+1,13);textcolor(12);write('*'); t:=t+1;
  case q of
    1: if a<>#49 then j:=0;
    2: if a<>#49 then j:=0;
    3: if a<>#49 then j:=0;
  end;
  q:=q+1;
  until a=#13;
if j=1 then begin clrscr;
textcolor(14);textcolor(12);gotoxy(35,12);write('Пароль принят!');
gotoxy(26,13);textcolor(15+128);write('Нажмите Enter для продолжения...');
a:=readkey; if a=#13 then break;
end else
begin clrscr;textcolor(14);gotoxy(33,12);textcolor(12);
write('Вы ввели неверный пароль!');gotoxy(33,13);write('Esc - выход из программы');{a:=readkey;}
if readkey=#27 then halt;
end;
until false;
end;


{------------ Процедура для открытия существующей БД   --------------------}
   procedure open_bd(a:string);
        begin
              {$I-}
             assign(f,a);
             reset(f);     { открыть существующий файл БД для записи данных }
              {$i+}
        end;

{------- Процедура для добавленияя одной записи в файл БД  ------------------}

   procedure add_zap_to_bd(a:string);
       begin
            textbackground(1);
               clrscr;
               gotoxy(25,2);
               write('Добавление нового блюда в Меню');
            open_bd(a);
            gotoxy(10,5);  write('Введи наименование блюда: ');
            if readkey=enter then zapbd.nazv:='unknown' else readln(zapbd.nazv);
            gotoxy(10,6);  write('Введи вес(гр): ');
            if readkey=enter then zapbd.ves:='unkn' else readln(zapbd.ves);
            gotoxy(10,7);  write('Введи калорийность: ');
            if readkey=enter then zapbd.kkal:='unkn' else readln(zapbd.kkal);
            gotoxy(10,8);  write('Состав блюда: ');
            if readkey=enter then zapbd.sostav:='unknown' else readln(zapbd.sostav);
            gotoxy(10,9);  write('Классификация: ');
            if readkey=enter then zapbd.klas:='unknown' else readln(zapbd.klas);
            gotoxy(10,10);  write('Цена(руб):');
            if readkey=enter then zapbd.cena:='unknown' else readln(zapbd.cena);



             seek(f,filesize(f));     { переместить указатель в конец файла}
             write(f,zapbd);          { записать данные в файл }
             close(f);
               gotoxy(1,21);
               textcolor(15);
               write('Новая запись добавлена в Файл - ',a,'. Для продолжения нажмите любую клавишу');
               readkey;
               textbackground(1); clrscr;

        end;




{------- Процедура для считывания всех записей из файла  БД в массив  ------------------}

   procedure file_to_mas(a:string;var k:integer);
       begin
          open_bd(a);
          k:=1;
            repeat
              read(f,masbd[k]);  { чтение одной записи из файла в массив }
              k:=k+1;
            until eof(f)=true;  { считывание записей пока не достигнут конец файла }
         k:=k-1;
         close(f);
       end;


{------ Вывод на экран i-й записи массива БД на р-ю строку экрана -----------}

    procedure i_zap_mas_to_screen(i,p:integer);
        begin
          if i <=20 then begin
        gotoxy(1,3+p);  write('│',i);  { Вывод порядкового номера записи }
        gotoxy(4,3+p);  write('│ ',masbd[i].nazv);
        gotoxy(25,3+p); write('│ ',masbd[i].ves);
        gotoxy(32,3+p); write('│ ',masbd[i].kkal);
        gotoxy(38,3+p); write('│ ',masbd[i].klas);
        gotoxy(61,3+p); write('│ ',masbd[i].cena);
        gotoxy(80,3+P); write('│');
                               end;
        end;

{---------- Шапка N1----------------------}
procedure shapka1;
begin
gotoxy(1,1);write('┌──┬────────────────────┬──────┬─────┬──────────────────────┬──────────────────┐');
gotoxy(1,2);write('│ N│      Название      │ Вес  │ Ккал│    Классификация     │       Цена       │');
gotoxy(1,3);write('├──┼────────────────────┼──────┼─────┼──────────────────────┼──────────────────┤');
end;


{---------- Низ таблицы N1----------------------}
procedure dno1;
begin


write('└──┴────────────────────┴──────┴─────┴──────────────────────┴──────────────────┘');
end;



{---- Процедура для вывода всех записей из массива на экран -----------}

   procedure mas_to_screen(m:integer);
       var i:integer;
       begin
        clrscr;
        shapka1;
        for i:=1 to m do
        i_zap_mas_to_screen(i,i);  dno1;
       textbackground(1); readkey; clrscr;
       end;


{---- Процедура для удаления К-й записи из массива и файла БД ----------}

   procedure del_zap_mas_and_file(a:string);
       var i,k:integer;
       label m1;
       begin
       m1:
       clrscr;
       writeln;
       writeln;
       file_to_mas(a,m);
       write('Введите номер записи для удаления:  ');


       readln(k);
       write('Запись умешно удалена');
       if (k<1) and (k>m) then goto m1;

       for i:=k to m-1 do  masbd[i]:=masbd[i+1];
       m:=m-1;
       assign(f,a);  { связать имя файла БД с переменной f }
       rewrite(f);   { создать новый файл БД и открыть для записи данных }
       for i:=1 to m do   write(f,masbd[i]);  { записать данные в файл }
       close(f);
       end;


{---- Процедура для редактирования К-й записи БД и записи ее в файл --------}

   procedure redakt_zap_mas_and_file(a:string);
       var i,k,m:integer;
       begin
       clrscr;
       writeln;
       writeln;
       write('Введите номер блюда для редактирования:  ');
       readln(k);
        gotoxy(5,8);
           file_to_mas(a,m);
       clrscr;
       gotoxy(10,5);  write('Введи название [',masbd[k].nazv,']: ');

        if readkey=enter then          begin
        masbd[k].nazv:=masbd[k].nazv;
        write(masbd[k].nazv);
        end
        else
         readln(masbd[k].nazv);
       gotoxy(10,6);  write('Введи вес [',masbd[k].ves,']: ');
              if readkey=enter then          begin
        masbd[k].ves:=masbd[k].ves;
        write(masbd[k].ves);
        end
        else
         readln(masbd[k].ves);


              gotoxy(10,7);  write('Введи калорийность: [',masbd[k].kkal,'] ');

              if readkey=enter then          begin
        masbd[k].kkal:=masbd[k].kkal;
        write(masbd[k].kkal);
        end
        else
         readln(masbd[k].kkal);




       gotoxy(10,8);  write('Введи классификацию:[',masbd[k].klas,'] ');

             if readkey=enter then          begin
        masbd[k].klas:=masbd[k].klas;
        write(masbd[k].klas);
        end
        else
         readln(masbd[k].klas);


       gotoxy(10,9);  write('Введи состав:[',masbd[k].sostav,']      '); writeln;gotoxy(10,10);




       if readkey=enter then          begin
        masbd[k].sostav:=masbd[k].sostav;
        write(masbd[k].sostav);
        end
        else
         readln(masbd[k].sostav);
       gotoxy(10,11);  write('Введи цену:[',masbd[k].cena,']    ');

       if readkey=enter then          begin
        masbd[k].cena:=masbd[k].cena;
        write(masbd[k].cena);
        end
        else
         readln(masbd[k].cena);
       new_bd('baza.dat');
       open_bd('baza.dat');
       for i:=1 to m do   write(f,masbd[i]);  { записать данные в файл }
       close(f);
       end;

{--------------------------------------------------------------------}



{------------ Процедура для поиска по первым буквам фамилии ---------}

    procedure first_fam(a:string);
       var str: string[50];
           i,p,m: integer;
       begin
       clrscr;

       file_to_mas(a,m);

       gotoxy(5,3); write('Введите название для поиска: ');
       readln(str);

         p:=1;
         for i:=1 to m do
          begin
            if copy(masbd[i].nazv,1,length(str))=str then
             begin
                if (p=1) then begin
                              clrscr;
                               shapka1{ рисуем шапку таблицы один раз - процедура shapka}
                              end;
                i_zap_mas_to_screen(i,p);
                p:=p+1;
             end;
          end;
      if (p=1) then begin  gotoxy(5,5); write( str,' в БД отсутствует') end
      else dno1;
       textbackground(1); readkey; clrscr;
      end;

{ -------------  Сортировка по названию ------------------------}

    procedure sortirovka_po_NAZV(a:string);

       var j,i,m:integer;
       begin
       file_to_mas(a,m);
       For i:=1 to m do
         For j:=1 to m-1 do
             if masbd[j].nazv>masbd[j+1].nazv then
                begin
                 zapbd:=masbd[j];
                 masbd[j]:=masbd[j+1];
                 masbd[j+1]:=zapbd;
                end;


     mas_to_screen(m);
       end;

       { _____________  Сортировка по цене _______________}

       procedure sortirovka_po_cena(a:string);

       var j,i,m,x,code,y:integer;
       begin
       file_to_mas(a,m);
       For i:=1 to m do
         For j:=1 to m-1 do
             if (masbd[j].cena<masbd[j+1].cena) and (length(masbd[j].cena)<=length(masbd[j+1].cena))  then
                begin
                 zapbd:=masbd[j];
                 masbd[j]:=masbd[j+1];
                 masbd[j+1]:=zapbd;
                end;


     mas_to_screen(m);
       end;


       procedure sortirovka_po_klas(a:string);

       var j,i,m:integer;
       begin
       file_to_mas(a,m);
       For i:=1 to m do
         For j:=1 to m-1 do
             if masbd[j].klas>masbd[j+1].klas then
                begin
                 zapbd:=masbd[j];
                 masbd[j]:=masbd[j+1];
                 masbd[j+1]:=zapbd;
                end;


     mas_to_screen(m);
       end;


{------------Процедура вывода всей информации о конкретном блюде-------------}

       procedure vivod_vsey_i_y(a:string);
       var k:integer;
       begin
       clrscr;
       file_to_mas(a,m);
       gotoxy(5,6);
       Write('Введи номер блюда: '); readln(k);
       gotoxy(5,7);
       Writeln('Название: ',masbd[k].nazv);
       gotoxy(5,8);
       Writeln('Калорийность: ',masbd[k].kkal);
       gotoxy(5,9);
       writeln('Вес: ',masbd[k].ves);
       gotoxy(5,10);
       writeln('Классификация: ',masbd[k].klas);
       gotoxy(5,11);
       writeln('Состав: ', masbd[k].sostav);

       gotoxy(20,20);
       write('Для продолжения нажмите любую клавишу');
               readkey;  textbackground(1);
        clrscr;

       end;

       {------------ Процедура для поиска по первым буквам классификации ---------}

    procedure first_klas(a:string);
       var str: string[50];
           i,p,m: integer;
       begin
       clrscr;

       file_to_mas(a,m);

       gotoxy(5,3); write('Введите классификацию для поиска: ');
       readln(str);

         p:=1;
         for i:=1 to m do
          begin
            if copy(masbd[i].klas,1,length(str))=str then
             begin
                if (p=1) then begin
                              clrscr;
                               shapka1{ рисуем шапку таблицы один раз - процедура shapka}
                              end;
                i_zap_mas_to_screen(i,p);
                p:=p+1;
             end;
          end;
      if (p=1) then begin  gotoxy(5,5); write( str,' в БД отсутствует') end
      else dno1;
       textbackground(1); readkey; clrscr;
      end;



  {------------Процедура вывода информации о разработчике-----------}

        procedure zazrab(a:string);

       begin
       clrscr;
       file_to_mas(a,m);
       gotoxy(20,8);
       writeln('|----------------------------------|');
       gotoxy(20,9);writeln('|       Программу разработал       |');
       gotoxy(20,10);writeln('|         ученик 9 класса В        |');
       gotoxy(20,11);writeln('|           школы МБОУ ЛИТ         |');
       gotoxy(20,12);writeln('|        Коваленко Вячеслав        |');
       gotoxy(20,13);writeln('|                                  |');
       gotoxy(20,14);writeln('|                                  |');
       gotoxy(20,15);writeln('|   "База данных меню ресторана"   |');
       gotoxy(20,16);writeln('|                                  |');
       gotoxy(20,17);writeln('|----------------------------------|');
       gotoxy(20,20);
       write('Для продолжения нажмите любую клавишу');
               readkey;  textbackground(1);
        clrscr;
       end;

    {--------Процедура вывода контактной информации о разработчике-------------}
             procedure kontakt(a:string);

       begin
       clrscr;
       file_to_mas(a,m);
       gotoxy(20,8);
       writeln('|----------------------------------|');
       gotoxy(20,9); writeln('|   E-mail: pro100ckat@mail.ru     |');
       gotoxy(20,10);writeln('|    Домашний телефон:32-94-52     |');
       gotoxy(20,11);writeln('|       Сотовый:89141999946        |');
       gotoxy(20,12);writeln('|                                  |');
       gotoxy(20,13);writeln('|                                  |');
       gotoxy(20,14);writeln('|                                  |');
       gotoxy(20,15);writeln('|   "База данных меню ресторана"   |');
       gotoxy(20,16);writeln('|                                  |');
       gotoxy(20,17);writeln('|----------------------------------|');
       gotoxy(20,20);
       write('Для продолжения нажмите любую клавишу');
               readkey;  textbackground(1);
        clrscr;
       end;


{-------------- ГЛАВНЫЙ МОДУЛЬ ПРОГРАММЫ -----------------------------------}
begin
  ms[1]:='  Операции с БД        ';
  ms[2]:='  Просмотр БД          ';
  ms[3]:='  Поиск блюд           ';
  ms[4]:='  Сортировка блюд      ';
  ms[5]:='  О программе          ';
  ms[6]:='  Выход                ';
  ms[7]:='                       ';


  ms1[1]:='  Создать новую БД         ';
  ms1[2]:='  Добавить блюдо в БД      ';
  ms1[3]:='  Удалить блюдо из БД      ';
  ms1[4]:='  Редактировать информацию ';
  ms1[5]:='  Назад                    ';

  ms2[1]:='  Просмотреть БД                      ';
  ms2[2]:='  Простреть информацию о k-ом блюде   ';
  ms2[3]:='  Назад                               ';

  ms3[1]:='  Поиск по названию       ';
  ms3[2]:='  Поиск по классификации  ';
  ms3[3]:='  Назад                   ';

  ms4[1]:='  Сортировка по названию           ';
  ms4[2]:='  Сортировка по цене               ';
  ms4[3]:='  Сортировка по классификации      ';
  ms4[4]:='  Назад                            ';

  ms5[1]:='  Разработчик          ';
  ms5[2]:='  Контактные данные    ';
  ms5[3]:='  Назад                ';

 textbackground(1);
clrscr;
cursoroff;
textcolor(15);
copyright;
indicator(18,9);


clrscr;
password;
clrscr;
textbackground(1);
 repeat


      case  menu(ms,6,30,7) of
          1:  begin clrscr; textbackground(1);
                    clrscr;
                    case  menu(ms1,5,25,7) of
                           1: begin new_bd('baza.dat'); end;
                           2:  begin add_zap_to_bd('baza.dat');   end;
                           3:  begin  del_zap_mas_and_file('baza.dat');
                        readkey;  file_to_mas('baza.dat',m);
                           mas_to_screen(m);      end;
                           4:  begin redakt_zap_mas_and_file('baza.dat'); clrscr; end;
                           5:  begin  textbackground(1); clrscr;   end;
              end;         end;
          2:  begin
                    textbackground(1);
                    clrscr;
                    case  menu(ms2,3,25,7) of
                           1:  begin file_to_mas('baza.dat',m); mas_to_screen(m);  end;
                           2:  begin vivod_vsey_i_y('baza.dat')     end;
                           3:  begin  textbackground(1); clrscr;    end;
              end;

              end;

          3:  begin
                    textbackground(1);
                    clrscr;
                    case  menu(ms3,3,25,7) of
                           1:  begin  first_fam('BAZA.dat');    end;
                           2:  begin  first_klas('BAZA.dat');   end;
                           3:  begin  textbackground(1); clrscr;           end;
              end;

              end;
          4:  begin
                     textbackground(1);
                    clrscr;
                    case  menu(ms4,4,25,7) of
                           1:  begin sortirovka_po_nazv('baza.dat');    end;
                           2:  begin sortirovka_po_cena('baza.dat');    end;
                           3:  begin sortirovka_po_klas('baza.dat');    end;
                           4:  begin  textbackground(1); clrscr;   end;

              end;

              end;


          5:  begin
                                 textbackground(1);
                    clrscr;
                    case  menu(ms5,3,25,7) of
                           1:  begin zazrab('baza.dat');    end;
                           2:  begin kontakt('baza.dat');    end;
                           3:  begin  textbackground(1); clrscr;   end;
              end;


             end;
          6:  begin exit; end;
       end;
 until false;   { Бесконечный цикл  repeat :. until}
end.
