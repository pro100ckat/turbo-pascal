program restoranBD;
{????????? ?.?. 9? ?????}
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
    m:integer; { ???-?? ????ᥩ ? ?? }
    a:char;

     reg:  Registers;
     mouse_x,mouse_y:word;


{______________????ࠩ?____________}

procedure copyright;
begin
 gotoxy(15,23); write(' ');
 gotoxy(15,24); write('khabarovsk, 2013');
end;


{ ------  ?몫?祭?? ??????? -------------}
procedure CursorOff; assembler;
        asm
          mov   ah,1
          mov   cx,2020h   {?????? ???栭?? ?? ?।??? ??????????}
          int   10h
        end;

{ ------  ????祭?? ??????? -------------}
procedure CursorOn; assembler;
        asm
          mov   ah,1
          mov   cx,0607h   {??⠭????? ???栭?? 6? ? 7? ??ப}
          int   10h
        end;





{-------- ????祭?? ??????? ???? -----------------------}
Procedure mouse_on;
begin

  reg.ax:=$1;
  intr($33,reg);
end;

{-------- ??।?????? ???न??? ??????? ???? ------------------}
Procedure mouse_xy(var x,y:word);
begin
  reg.ax:=$3;
  intr($33,reg);
       x:=reg.cx;
       y:=reg.dx;
end;

{-------- ?஢?ઠ ??????? ????? ?????? ???? ------------------}

function mouse_key_left : boolean ;
begin
  reg.ax:=$3;
  intr($33,reg);
if (reg.bx and 00000001)>0 then mouse_key_left:=true else mouse_key_left:=false;
end;

{-------- ?஢?ઠ ?宦????? ??????? ???? ? ⥪?⮢?? ????????? -------------}


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


{----------------- ???楤? ????㧪? ??࠭? -----------------------}
Procedure wait(x:integer);
Var j,i:integer;
Begin
For j:=1 to 1500 do
For i:=1 to x do
Write('');
End;


{------- ??ᮢ???? ?????୮? ࠬ?? --------------------------}

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




{------ ?㭪??? ??ᮢ???? ????  --------}

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
{------------ ?㭪??? ?? / ???   --------------------}

function yes_no:boolean;
begin

yes_no:=false;
if readkey IN ['y','Y','?','?'] then yes_no:=true;

end;

{------------ ???楤??? ??? ᮧ????? ????? ???⮩ ??   --------------------}
   procedure new_bd(a:string);
          begin
              textbackground(1);
               clrscr;
               gotoxy(35,8);
               write('????????!');


               gotoxy(10,12);
               write('?த?????? ᮧ????? ?????? 䠩?? [Y/N], ??? ????????? ?㤥? ???????');

               if yes_no=false then begin textbackground(1); clrscr; exit; end;
               assign(f,a);  { ??易?? ??? 䠩?? ?? ? ??६????? f }
               rewrite(f);   { ᮧ???? ????? 䠩? ?? ? ??????? ??? ?????? ?????? }
               close(f);     { ??????? 䠩? ?? }
               clrscr;
               indicator(20,8);
               gotoxy(8,15);
               textcolor(15);
               write('???? ?? - ',a,' ᮧ???. ??? ?த??????? ??????? ????? ???????');
               readkey;
               textbackground(1); clrscr;
          end;


{------------ ???楤??? ????? ??஫?   --------------------}

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
write('??? ????㯠 ? ???? ??????');
gotoxy(35,11);;
write('??????? ??஫?            ');
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
textcolor(14);textcolor(12);gotoxy(35,12);write('??஫? ?ਭ??!');
gotoxy(26,13);textcolor(15+128);write('??????? Enter ??? ?த???????...');
a:=readkey; if a=#13 then break;
end else
begin clrscr;textcolor(14);gotoxy(33,12);textcolor(12);
write('?? ????? ???????? ??஫?!');gotoxy(33,13);write('Esc - ??室 ?? ?ணࠬ??');{a:=readkey;}
if readkey=#27 then halt;
end;
until false;
end;


{------------ ???楤??? ??? ???????? ?????????饩 ??   --------------------}
   procedure open_bd(a:string);
        begin
              {$I-}
             assign(f,a);
             reset(f);     { ??????? ?????????騩 䠩? ?? ??? ?????? ?????? }
              {$i+}
        end;

{------- ???楤??? ??? ??????????? ????? ?????? ? 䠩? ??  ------------------}

   procedure add_zap_to_bd(a:string);
       begin
            textbackground(1);
               clrscr;
               gotoxy(25,2);
               write('?????????? ?????? ?? ? ????');
            open_bd(a);
            gotoxy(10,5);  write('????? ???????????? ??: ');
            if readkey=enter then zapbd.nazv:='unknown' else readln(zapbd.nazv);
            gotoxy(10,6);  write('????? ???(??): ');
            if readkey=enter then zapbd.ves:='unkn' else readln(zapbd.ves);
            gotoxy(10,7);  write('????? ????਩?????: ');
            if readkey=enter then zapbd.kkal:='unkn' else readln(zapbd.kkal);
            gotoxy(10,8);  write('???⠢ ??: ');
            if readkey=enter then zapbd.sostav:='unknown' else readln(zapbd.sostav);
            gotoxy(10,9);  write('??????䨪????: ');
            if readkey=enter then zapbd.klas:='unknown' else readln(zapbd.klas);
            gotoxy(10,10);  write('????(???):');
            if readkey=enter then zapbd.cena:='unknown' else readln(zapbd.cena);



             seek(f,filesize(f));     { ??६?????? 㪠??⥫? ? ????? 䠩??}
             write(f,zapbd);          { ???????? ?????? ? 䠩? }
             close(f);
               gotoxy(1,21);
               textcolor(15);
               write('????? ?????? ????????? ? ???? - ',a,'. ??? ?த??????? ??????? ????? ???????');
               readkey;
               textbackground(1); clrscr;

        end;




{------- ???楤??? ??? ????뢠??? ???? ????ᥩ ?? 䠩??  ?? ? ???ᨢ  ------------------}

   procedure file_to_mas(a:string;var k:integer);
       begin
          open_bd(a);
          k:=1;
            repeat
              read(f,masbd[k]);  { ?⥭?? ????? ?????? ?? 䠩?? ? ???ᨢ }
              k:=k+1;
            until eof(f)=true;  { ????뢠??? ????ᥩ ???? ?? ???⨣??? ????? 䠩?? }
         k:=k-1;
         close(f);
       end;


{------ ?뢮? ?? ??࠭ i-? ?????? ???ᨢ? ?? ?? ?-? ??ப? ??࠭? -----------}

    procedure i_zap_mas_to_screen(i,p:integer);
        begin
          if i <=20 then begin
        gotoxy(1,3+p);  write('?',i);  { ?뢮? ???浪????? ?????? ?????? }
        gotoxy(4,3+p);  write('? ',masbd[i].nazv);
        gotoxy(25,3+p); write('? ',masbd[i].ves);
        gotoxy(32,3+p); write('? ',masbd[i].kkal);
        gotoxy(38,3+p); write('? ',masbd[i].klas);
        gotoxy(61,3+p); write('? ',masbd[i].cena);
        gotoxy(80,3+P); write('?');
                               end;
        end;

{---------- ????? N1----------------------}
procedure shapka1;
begin
gotoxy(1,1);write('??????????????????????????????????????????????????????????????????????????????Ŀ');
gotoxy(1,2);write('? N?      ????????      ? ???  ? ?????    ??????䨪????     ?       ????       ?');
gotoxy(1,3);write('??????????????????????????????????????????????????????????????????????????????Ĵ');
end;


{---------- ??? ⠡???? N1----------------------}
procedure dno1;
begin


write('????????????????????????????????????????????????????????????????????????????????');
end;



{---- ???楤??? ??? ?뢮?? ???? ????ᥩ ?? ???ᨢ? ?? ??࠭ -----------}

   procedure mas_to_screen(m:integer);
       var i:integer;
       begin
        clrscr;
        shapka1;
        for i:=1 to m do
        i_zap_mas_to_screen(i,i);  dno1;
       textbackground(1); readkey; clrscr;
       end;


{---- ???楤??? ??? 㤠????? ?-? ?????? ?? ???ᨢ? ? 䠩?? ?? ----------}

   procedure del_zap_mas_and_file(a:string);
       var i,k:integer;
       label m1;
       begin
       m1:
       clrscr;
       writeln;
       writeln;
       file_to_mas(a,m);
       write('??????? ????? ?????? ??? 㤠?????:  ');


       readln(k);
       write('?????? 㬥譮 㤠????');
       if (k<1) and (k>m) then goto m1;

       for i:=k to m-1 do  masbd[i]:=masbd[i+1];
       m:=m-1;
       assign(f,a);  { ??易?? ??? 䠩?? ?? ? ??६????? f }
       rewrite(f);   { ᮧ???? ????? 䠩? ?? ? ??????? ??? ?????? ?????? }
       for i:=1 to m do   write(f,masbd[i]);  { ???????? ?????? ? 䠩? }
       close(f);
       end;


{---- ???楤??? ??? ।????஢???? ?-? ?????? ?? ? ?????? ?? ? 䠩? --------}

   procedure redakt_zap_mas_and_file(a:string);
       var i,k,m:integer;
       begin
       clrscr;
       writeln;
       writeln;
       write('??????? ????? ?? ??? ।????஢????:  ');
       readln(k);
        gotoxy(5,8);
           file_to_mas(a,m);
       clrscr;
       gotoxy(10,5);  write('????? ???????? [',masbd[k].nazv,']: ');

        if readkey=enter then          begin
        masbd[k].nazv:=masbd[k].nazv;
        write(masbd[k].nazv);
        end
        else
         readln(masbd[k].nazv);
       gotoxy(10,6);  write('????? ??? [',masbd[k].ves,']: ');
              if readkey=enter then          begin
        masbd[k].ves:=masbd[k].ves;
        write(masbd[k].ves);
        end
        else
         readln(masbd[k].ves);


              gotoxy(10,7);  write('????? ????਩?????: [',masbd[k].kkal,'] ');

              if readkey=enter then          begin
        masbd[k].kkal:=masbd[k].kkal;
        write(masbd[k].kkal);
        end
        else
         readln(masbd[k].kkal);




       gotoxy(10,8);  write('????? ??????䨪????:[',masbd[k].klas,'] ');

             if readkey=enter then          begin
        masbd[k].klas:=masbd[k].klas;
        write(masbd[k].klas);
        end
        else
         readln(masbd[k].klas);


       gotoxy(10,9);  write('????? ???⠢:[',masbd[k].sostav,']      '); writeln;gotoxy(10,10);




       if readkey=enter then          begin
        masbd[k].sostav:=masbd[k].sostav;
        write(masbd[k].sostav);
        end
        else
         readln(masbd[k].sostav);
       gotoxy(10,11);  write('????? 業?:[',masbd[k].cena,']    ');

       if readkey=enter then          begin
        masbd[k].cena:=masbd[k].cena;
        write(masbd[k].cena);
        end
        else
         readln(masbd[k].cena);
       new_bd('baza.dat');
       open_bd('baza.dat');
       for i:=1 to m do   write(f,masbd[i]);  { ???????? ?????? ? 䠩? }
       close(f);
       end;

{--------------------------------------------------------------------}



{------------ ???楤??? ??? ???᪠ ?? ?????? ?㪢?? 䠬???? ---------}

    procedure first_fam(a:string);
       var str: string[50];
           i,p,m: integer;
       begin
       clrscr;

       file_to_mas(a,m);

       gotoxy(5,3); write('??????? ???????? ??? ???᪠: ');
       readln(str);

         p:=1;
         for i:=1 to m do
          begin
            if copy(masbd[i].nazv,1,length(str))=str then
             begin
                if (p=1) then begin
                              clrscr;
                               shapka1{ ???㥬 蠯?? ⠡???? ???? ࠧ - ???楤??? shapka}
                              end;
                i_zap_mas_to_screen(i,p);
                p:=p+1;
             end;
          end;
      if (p=1) then begin  gotoxy(5,5); write( str,' ? ?? ???????????') end
      else dno1;
       textbackground(1); readkey; clrscr;
      end;

{ -------------  ?????஢?? ?? ???????? ------------------------}

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

       { _____________  ?????஢?? ?? 業? _______________}

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


{------------???楤??? ?뢮?? ?ᥩ ????ଠ樨 ? ??????⭮? ??-------------}

       procedure vivod_vsey_i_y(a:string);
       var k:integer;
       begin
       clrscr;
       file_to_mas(a,m);
       gotoxy(5,6);
       Write('????? ????? ??: '); readln(k);
       gotoxy(5,7);
       Writeln('????????: ',masbd[k].nazv);
       gotoxy(5,8);
       Writeln('????਩?????: ',masbd[k].kkal);
       gotoxy(5,9);
       writeln('???: ',masbd[k].ves);
       gotoxy(5,10);
       writeln('??????䨪????: ',masbd[k].klas);
       gotoxy(5,11);
       writeln('???⠢: ', masbd[k].sostav);

       gotoxy(20,20);
       write('??? ?த??????? ??????? ????? ???????');
               readkey;  textbackground(1);
        clrscr;

       end;

       {------------ ???楤??? ??? ???᪠ ?? ?????? ?㪢?? ??????䨪?樨 ---------}

    procedure first_klas(a:string);
       var str: string[50];
           i,p,m: integer;
       begin
       clrscr;

       file_to_mas(a,m);

       gotoxy(5,3); write('??????? ??????䨪???? ??? ???᪠: ');
       readln(str);

         p:=1;
         for i:=1 to m do
          begin
            if copy(masbd[i].klas,1,length(str))=str then
             begin
                if (p=1) then begin
                              clrscr;
                               shapka1{ ???㥬 蠯?? ⠡???? ???? ࠧ - ???楤??? shapka}
                              end;
                i_zap_mas_to_screen(i,p);
                p:=p+1;
             end;
          end;
      if (p=1) then begin  gotoxy(5,5); write( str,' ? ?? ???????????') end
      else dno1;
       textbackground(1); readkey; clrscr;
      end;



  {------------???楤??? ?뢮?? ????ଠ樨 ? ࠧࠡ??稪?-----------}

        procedure zazrab(a:string);

       begin
       clrscr;
       file_to_mas(a,m);
       gotoxy(20,8);
       writeln('|----------------------------------|');
       gotoxy(20,9);writeln('|       ?ணࠬ?? ࠧࠡ?⠫       |');
       gotoxy(20,10);writeln('|         ?祭?? 9 ?????? ?        |');
       gotoxy(20,11);writeln('|           誮?? ???? ???         |');
       gotoxy(20,12);writeln('|        ????????? ????᫠?        |');
       gotoxy(20,13);writeln('|                                  |');
       gotoxy(20,14);writeln('|                                  |');
       gotoxy(20,15);writeln('|   "???? ?????? ???? ?????࠭?"   |');
       gotoxy(20,16);writeln('|                                  |');
       gotoxy(20,17);writeln('|----------------------------------|');
       gotoxy(20,20);
       write('??? ?த??????? ??????? ????? ???????');
               readkey;  textbackground(1);
        clrscr;
       end;

    {--------???楤??? ?뢮?? ???⠪⭮? ????ଠ樨 ? ࠧࠡ??稪?-------------}
             procedure kontakt(a:string);

       begin
       clrscr;
       file_to_mas(a,m);
       gotoxy(20,8);
       writeln('|----------------------------------|');
       gotoxy(20,9); writeln('|   E-mail: pro100ckat@mail.ru     |');
       gotoxy(20,10);writeln('|    ????譨? ⥫?䮭:32-94-52     |');
       gotoxy(20,11);writeln('|       ??⮢??:89141999946        |');
       gotoxy(20,12);writeln('|                                  |');
       gotoxy(20,13);writeln('|                                  |');
       gotoxy(20,14);writeln('|                                  |');
       gotoxy(20,15);writeln('|   "???? ?????? ???? ?????࠭?"   |');
       gotoxy(20,16);writeln('|                                  |');
       gotoxy(20,17);writeln('|----------------------------------|');
       gotoxy(20,20);
       write('??? ?த??????? ??????? ????? ???????');
               readkey;  textbackground(1);
        clrscr;
       end;


{-------------- ??????? ?????? ????????? -----------------------------------}
begin
  ms[1]:='  ?????樨 ? ??        ';
  ms[2]:='  ???ᬮ?? ??          ';
  ms[3]:='  ????? ????           ';
  ms[4]:='  ?????஢?? ????      ';
  ms[5]:='  ? ?ணࠬ??          ';
  ms[6]:='  ??室                ';
  ms[7]:='                       ';


  ms1[1]:='  ??????? ????? ??         ';
  ms1[2]:='  ???????? ?? ? ??      ';
  ms1[3]:='  ??????? ?? ?? ??      ';
  ms1[4]:='  ???????஢??? ????ଠ??? ';
  ms1[5]:='  ?????                    ';

  ms2[1]:='  ???ᬮ????? ??                      ';
  ms2[2]:='  ????????? ????ଠ??? ? k-?? ??   ';
  ms2[3]:='  ?????                               ';

  ms3[1]:='  ????? ?? ????????       ';
  ms3[2]:='  ????? ?? ??????䨪?樨  ';
  ms3[3]:='  ?????                   ';

  ms4[1]:='  ?????஢?? ?? ????????           ';
  ms4[2]:='  ?????஢?? ?? 業?               ';
  ms4[3]:='  ?????஢?? ?? ??????䨪?樨      ';
  ms4[4]:='  ?????                            ';

  ms5[1]:='  ???ࠡ??稪          ';
  ms5[2]:='  ???⠪???? ??????    ';
  ms5[3]:='  ?????                ';

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
 until false;   { ??᪮?????? 横?  repeat :. until}
end.
