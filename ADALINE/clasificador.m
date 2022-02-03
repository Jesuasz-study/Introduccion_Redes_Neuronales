clear;
fileID = fopen('clasifP.txt','r');
dLin = fgetl(fileID);%leemos los datos que haya en la primera fila del txt
linCell = strsplit(dLin);% los separamos por cada espacio en blanco que tengan
[dontcare,features] =  size(linCell);% numero de rasgos del vector P
fclose(fileID);

    W = [1 0;0 1];
    b = [1;1];
    alpha = 0.04;





fileID = fopen('clasifP.txt','r');
formatSpect = '%d';
p = fscanf(fileID,formatSpect,[1 Inf]);%leemos el archivo como un vector 1xInfinito
mtzP = vec2mat(p,features);%el vector lo volvemos matriz de 'features' no de columnas
fclose(fileID);

%%%%%%%%%%%%%%
fileID = fopen('clasifT.txt','r');
dLin = fgetl(fileID);%leemos los datos que haya en la primera fila del txt
linCell = strsplit(dLin);% los separamos por cada espacio en blanco que tengan
[dontcare,features] =  size(linCell);% numero de rasgos del vector P
fclose(fileID);

fileID = fopen('clasifT.txt','r');
formatSpect = '%d';
t = fscanf(fileID,formatSpect,[1 Inf]);%leemos el archivo como un vector 1xInfinito
mtzT = vec2mat(t,features);%el vector lo volvemos matriz de 'features' no de columnas
fclose(fileID);

learning;
graphic;