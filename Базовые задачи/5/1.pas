
var
  Inf, Outf: text;
  min: integer;

function fmin(inf1: text): integer;
  var
    mn: set of char;
    count,i,j,min:integer;
    instr,iword: string;
  begin
    mn:= ['1','2','3','4','5','6','7','8','9','0'];
    assign(inf1,'input.txt');
    reset(inf1);
    min:= 0;
    i:= 1;
    while not eof(inf1) do
      begin
        readln(inf1,instr);
        instr:= instr + ' ';
          while i <= length(instr) do
          begin
            if instr[i] <> ' ' then
            begin
              iword:= iword + instr[i];
              inc(i)
            end
            else
            begin
              delete(instr,1,i);
              for j:= 1 to length(iword) do
                if iword[j] in mn then inc(count);
              if (count > min) and (count <> 0) then min:= count;
              i:= 1;
              iword:='';
              count:= 0
            end
          end
      end;
      fmin:= min;
      close(inf1);
  end;
  
procedure wr(var inf1,outf1: text; min:integer);
  var
    mn: set of char;
    i,j,count: byte;
    instr,iword: string;
  begin
    assign(inf1,'input.txt');
    assign(outf1,'output.txt');
    rewrite(outf1);
    reset(inf1);
    iword:='';
    mn:= ['1','2','3','4','5','6','7','8','9','0'];
    i:= 1;
    while not eof(inf1) do
      begin
        readln(inf1,instr);
        instr:= instr+' ';
          while i <= length(instr) do
          begin
            if instr[i] <> ' ' then
            begin
              iword:= iword + instr[i];
              inc(i)
            end
            else
            begin
              delete(instr,1,i);
              for j:= 1 to length(iword) do
                if iword[j] in mn then inc(count);
              if count = min then writeln(outf1,iword);
              i:= 1;
              iword:='';
              count:=0;
            end
          end
      end;
      close(inf1);
      close(outf1)
    end;
  
  Begin
    min:= fmin(inf);
    writeln(min);
    wr(inf,outf,min);
  End.