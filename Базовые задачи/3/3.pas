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
begin//������������� ������� �� ����� ������
while (i<=length(x)) and (copy(x,i,1)=' ')  do  
                                         i:=i+1;//���������� ��� ������

if i<=length(x) then//���� �� ����� ������
   begin//�� I ��������� �� ������ �������� ������� � ������ �����
   J:=i;//����������� j ������� ������� �������
   while (i<=length(x)) and (copy(x,i,1)<>' ') do 
        i:=i+1;//����� �����
        
       if (i-j>0) then //���� ����� ������ 0
       begin
       num:=num+1;//��������� ���������� ���� � �������
       a[num]:=copy(x,j,i-j);//������ ������� � ������� ����������� �����
       end;
   end;
end;
i:=1;
while i<=num do begin
mas:=0;
for ch:=1 to length(a[i]) do begin 
   //�� �h ��������� �� ������ �������� ������� � ������ �����
     mas:=mas+1;//��������� ���������� ��������� � �������
      b[mas]:=copy(a[i],ch,1);//������ ������� � ����� ������� ����������� ������
 
       end;
        if (b[1]=s) and (b[mas]=s) then writeln(a[i]);
   i:=i+1;
   end;
end;
begin
writeln('������� ������');
readln(str);
Writeln('������� ������');
readln(sim);
write_slova(str,sim,d,e,n,m);

end.


