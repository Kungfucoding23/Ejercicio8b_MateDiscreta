{Escribir un programa Pascal que lea la matriz de adyacencia de un grafo y calcule los grados de cada
vértice.}
program Ejercicio_8b;
type
  Matriz = array[1..10,1..10] of word;
var
  mat: Matriz;
  N, M, grado: byte;
Procedure LeeMatriz(var mat: Matriz; var N, M: byte);
var
  i, j: byte;
  arch: text;
begin
  assign(arch, 'matriz2.txt'); reset(arch);
  while not eof(arch) do
  begin
    readln(arch, N, M);
    for i:=1 to N do
        for j:= 1 to M do
            begin
              read(arch ,mat[i,j]);
            end;
  end;
  close(arch);
end;
Procedure showMat(mat: Matriz; N, M: byte);
var
  i, j: byte;
begin
  for i:= 1 to N do
  begin
    for j:= 1 to M do
        write(mat[i,j]: 4);
    writeln();
  end;
end;
// calcula los grados de salida de cada vertice
Procedure grafoNoDirigido(mat: Matriz; N, M: byte);
var
  i, j, grado: byte;
begin                                           // queda ver que se cumpla tanto para grafo dirigido como no dirigido
  for i:= 1 to N do
  begin
    grado:= 0;
    for j:= 1 to M do
      begin
        if i = j then  // esto no es necesario si es grafo dirigido
           grado:= grado + (mat[i,j]*2)
           else
             grado:= grado + mat[i,j];
      end;
    writeln('El grado de el vertice ',i,' es: ', grado);
  end;
end;
// calcula los grados de entrada de cada vertice
Procedure grafoDirigido(mat: Matriz; N, M: byte); // la columna determina los grados de entrada
var
  i, j, gradoS, gradoE: byte;
begin
  for i:= 1 to N do
  begin
    gradoS:= 0;
    for j:= 1 to N do
    begin
      gradoS:= gradoS + mat[i,j];
    end;
    writeln('El grado de salida de el vertice ',i,' es: ',gradoS);
  end;
  writeln;
  for j:= 1 to M do
  begin
    gradoE:= 0;
    for i:= 1 to N do
    begin
      gradoE:= gradoE + mat[i,j];
    end;
    writeln('El grado de entrada de el vertice ',i,' es: ', gradoE);
  end;
end;
Function dirigido_NoDirigido(mat: Matriz; N, M: byte): boolean;  //Para un grafo NO DIRIGIDO la matriz de adyacencia es simetrica
var
  i, j: byte;
begin
  dirigido_NoDirigido:= true; // si es true es no dirigido
  for i:= 1 to N do
  begin
    for j:= 1 to M do
    begin
      if mat[i,j] <> mat[j,i] then // no es simetrica, entonces es grafo dirigido
         dirigido_NoDirigido:= false;
    end;
  end;
end;
begin
  LeeMatriz(mat, N, M);
  showMat(mat, N, M);
  writeln;
  if dirigido_NoDirigido(mat, N, M) then
     grafoNoDirigido(mat, N, M)
     else
       grafoDirigido(mat, N, M);
  readln();
end.

