fileID = fopen('prototipos.txt','r');%%abre el txt en modo lectura, obtiene el id del archivo
ffile = fgetl(fileID);
C = strsplit(ffile);
[dontcare,feature] = size(C);
fclose(fileID);
%feature = 3;
p = zeros(1,feature)';%%crea un array de las dimenciones del vector de entrada
for loop0 = 1:feature
    p(loop0) = input('Valor de vector prototipo:');%%lee los datos de entrada dados por el usuario
end
clc;
fileID = fopen('prototipos.txt','r');
formatSpect = '%d';%%define el formato de lectura para el archivo
%%Inf--leer hasta final de archivo
w = fscanf(fileID,formatSpect,[1 Inf]);%%leer el txt y guarda entrada en array de 1 a Inf
wMtz = vec2mat(w,feature);%%convierte el array w en una matriz de 4 columnas(feature)
[row,column] = size(wMtz);%%guarda los valores de los tamaños de la matriz
bias = linspace(feature,feature,row)';%%crea un array 1xS con los valores de bias (valMin,valMax,columnas)
n = (wMtz*p)+bias;
a = purelin(n);
fclose(fileID);

limit = (1)/(row-1);
eps = (limit-0).*rand(1,1) + 0;% .* es una multp elemento por elemento
fprintf(1,'Valor de epsilon:%f\n',eps);
w2 = ones(row,row);
for loop = 1:row
    for loop1 = 1:row
        if loop ~= loop1
            w2(loop,loop1) = -eps;
        end
    end
end
cont = 0;
epoca = 0;
graf_epoca = zeros(1,2);
graf_neurona = zeros(1,2);
graf_neurona2 = ones(1,2);
for loop = 1:50
    aux = a;
    a = poslin(w2*a);
    epoca = epoca+1;
    %plot(epoca,a);
    graf_epoca(1,loop) = epoca;
    graf_neurona(1,loop) = a(1);
    graf_neurona2(1,loop) = a(2);
    %
    if a == aux
        cont = cont+1;
    end
    if cont == 2
        break;
    end
    disp(a);
end
disp('-----------');
plot(graf_epoca,graf_neurona);
hold on
plot(graf_epoca,graf_neurona2);
for loop = 1:row
    fprintf(1,'Valor de neurona %d: %f\n',loop,a(loop));
end