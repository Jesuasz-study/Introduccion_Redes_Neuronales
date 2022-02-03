fileID = fopen('datP.txt','r');
dLin = fgetl(fileID);%leemos los datos que haya en la primera fila del txt
linCell = strsplit(dLin);% los separamos por cada espacio en blanco que tengan
[dontcare,features] =  size(linCell);% numero de rasgos del vector P
fclose(fileID);

W = rand(1:features);
b = rand;

fileID = fopen('datP.txt','r');
formatSpect = '%d';
p = fscanf(fileID,formatSpect,[1 Inf]);%leemos el archivo como un vector 1xInfinito
mtzP = vec2mat(p,features);%el vector lo volvemos matriz de 'features' no de columnas
fclose(fileID);

fileID = fopen('datT.txt','r');
formatSpect = '%d';
t = fscanf(fileID,formatSpect,[1 Inf]);
mtzT = vec2mat(t,1);%el num de columnas es siempre 1 porque son valores de target unicos
fclose(fileID);
btry = 2;

disp('Elige un metodo:');
disp('1.Regla de Aprendizaje');
disp('2.Metodo Grafico');
opc_menu = input('Metodo a utilizar:');
switch opc_menu
    case 1
        learningRule;
        graphic;
    case 2
        grapMetod;
        graphic;
end