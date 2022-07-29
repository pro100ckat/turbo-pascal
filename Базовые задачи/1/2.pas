program p2;
var M, L, K, N, Sum: integer;
begin
writeln('Введите M, L, K, N');
readln(M, L, K, N);
if (M<L)and (M<K) and (M<N) then begin
Sum:= L+K+N;
writeln('Сумма = ',Sum);
end
else 
if (L<M) and (L<K) and (L<N) then begin
Sum:=M+K+N;
writeln('Сумма = ',Sum);
end
else
if (K<M) and (K<L) and (K<N) then begin
Sum:= M+L+N;
writeln('Сумма = ',Sum);
end
else
if (N<M) and (N<L) and (N<K) then begin
Sum:= M+L+K;
writeln('Сумма = ',Sum);
end
else begin
sum:=M+L+K+N;
writeln('Сумма = ',Sum);
end;
end.
