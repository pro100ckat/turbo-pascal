Program Dyn;
Type elemp = ^elem; //��������� ��� ��������� �� ������� ������
     elem = record //������ - ������� ������
     n:real;
     next:elemp;//��������� �� ��������� �������
     end;
var start,endd,temp:^elem;//��������� �� ������, ����� ������ � ��������������� ���������
    i:integer;
    m,q:real;

function multminmax(start:elemp):real;//�������, ������� ���� ������������, ����������� ������� � ����������� ��
var  max,min:real;
     cur:elemp;//��������� - ������ ��� �������� ������
begin
if start<>nil then//���� ������ �� ������
   begin
   cur:=start;//������������� ������ �� �����
   max:=start^.n;//������ ��������� �������� ��������� � ��������
   min:=start^.n;
   while cur<>nil do//���� �� ����� �� �����
      begin
      if cur^.n>max then max:=cur^.n;//��������� �� �������� � �������
      if cur^.n<min then min:=cur^.n;
      cur:=cur^.next;//������� ������ �� ��������� �������
      end;
   multminmax:=min*max;//����������� ��, ��� �����
   writeln('����������� ������� ',min:5:3);//������� ����������� � ������������ ��������
   writeln('������������ ������� ',max:5:3);
   end;
end;

begin
randomize;
new(start);//�������� ������ ��� ������� ��������
start^.n:=random(1000)/100+10;//���������� ���
write(start^.n:5:3,'  ');
start^.next:=nil;
endd:=start;//����� ���� ��� ��������� � �������
for i:=1 to 39 do
    begin
    new(endd^.next);//�������� ������ ��� ���������� ��������
    endd:=endd^.next;//��������� ����� ������ �� ���� �������
    endd^.n:=random(1000)/100+10;//����������
    endd^.next:=nil;//���� ������� ���� ��� ���������
    write(endd^.n:5:3,'  ');//������� ���
    end;
writeln('');
writeln('');
m:=multminmax(start);//���� ������������ ��������� � ��������
writeln('������������ ������������� � ������������ �������� ������ ����� ',m);
new(temp);//�������� ������ ��� ��������
temp^.n:=m;//���������� ���
temp^.next:=start;//� �������� � ������
start:=temp;
writeln('������������ ��������� � ������ ������ ');




temp:=start;//������ �������� � ������ (temp � ���� �������)
while temp<>nil do//��������� �� ������ � ����������� ������, ���� �� ����� �� �����
      begin
      temp:=start^.next;
      write(start^.n:5:3,'  ');
      dispose(start);
      start:=temp;
      end;
end.