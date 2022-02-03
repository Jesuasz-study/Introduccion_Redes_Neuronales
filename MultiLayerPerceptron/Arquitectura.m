%
%%arquitectura
%
%%seleccion archivo con datos de entrada y salida
%
[filename pathname] = uigetfile({'*.txt'},'File Selector');%lanza filechooser
nombreArchivoIN = strcat(pathname,filename);%concatena direccion
p = importdata(nombreArchivoIN);%almacena info en p

[filename pathname] = uigetfile({'*.txt'},'File Selector');
nombreArchivoOUT = strcat(pathname,filename);
targets = importdata(nombreArchivoOUT);

%%se muestra la forma de la grafica para P y Target
figure
plot(p,targets,'Color',[0.9,0.1,0.1]);
grid on 
%

% Se calcula el rango a trabajar
dim_p = size(p); %[101 1] dimensiones del vector P
lim_inf = p(1);
lim_sup = p(dim_p(1)); 
incremento = (lim_sup-lim_inf)/(dim_p(1)-1);%espacio entre numeros para muestra homogenea 

num_datos = dim_p(1);

%
%%Se solicita la arquitectura del M.L.P. vectores V1 y V2
%
fprintf('\n');
str_arq = input('Ingresa la arquitectura del M.L.P.: ','s'); %texto no se evalua como expresion
arq_mlp = str2num(str_arq);%arquitectura como vector
num_capas = length(arq_mlp)-1;
R = arq_mlp(1);
fprintf('Funciones de activacion:\n');
fprintf('1. purelin(n)\n2. logsig(n)\n3. tansig(n)\n\n');
str_fun = input('Ingresa las Funciones de Activacion: ','s');
fun_capa = str2num(str_fun);
disp('-Vectores de arquitectura M.L.P.-');
disp(arq_mlp);
disp(fun_capa);


%
%%Se abren archivos para graficacion en modo escritura (Esto es un poco largo...)
%
archivos_graficacion;
% Se terminan de abrir los archivos

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Se solicita el valor del factor de aprendizaje
alfa = input('Define el factor de aprendizaje (alpha): ');

% Se solicitan los valores de usuario eit,itmax, itval, numval
itmax = input('Define el numero de iteraciones maximas para aprendizaje (itmax): ');
itval = input('Define en numero para la iteracion de validacion (itval): ');
numval = input('Numero maximo de incrementos consecutivos del error de validacion (EarlyStopping): ');
eit = input('Define el valor minimo de error para una epoca (eit): ');
fprintf('\n');

% Se define el porcentaje de cada conjunto del numero total de datos
fprintf('Defina con que conjuntos trabajar:\n');
fprintf('1) 80-10-10\n');
fprintf('2) 70-15-15\n');
config = input('Opcion: ');

%
%%Se forman los subconjutnos de acuerdo al tipo de configuracion
%
switch(config)
    case 1
        num_elem_val = round(num_datos*.2); % Numero de elementos del conjunto de validacion
        num_elem_prueba = num_elem_val; % Numero de elementos del conjunto de prueba
        num_elem_ent = num_datos - 2*num_elem_val; % Numero de elementos del conjunto de entrenamiento
    case 2
        num_elem_val = round(num_datos*.15);
        num_elem_prueba = num_elem_val;
        num_elem_ent = num_datos - 2*num_elem_val;
end
%disp('Se usaran los siguientes tamanios en los subconjuntos:');
%fprintf('Conjunto de entrenamiento: %d elementos\n',num_elem_ent);
%fprintf('Conjunto de validacion: %d elementos\n',num_elem_val);
%fprintf('Conjunto de prueba: %d elementos\n',num_elem_prueba);
cto_val = ConjuntoValidacion(p,targets,num_datos,num_elem_val);
cto_prueba = ConjuntoPrueba(p,targets,num_datos,num_elem_prueba);
cto_ent = ConjuntoEntrenamiento(p,targets,num_datos,num_elem_ent,cto_val,cto_prueba);
disp('Conjunto de entrenamiento:');
disp(cto_ent);
disp('Conjunto de validacion:');
disp(cto_val);
disp('Conjunto de prueba:');
disp(cto_prueba);

%
%%Se inicializan la matriz de pesos y el vector bias con valores aleatorios
% entre -1 y 1
num_archivos_pesos = 1;
num_archivos_bias = 1;
W = cell(num_capas,1);
b = cell(num_capas,1);
disp('Valores iniciales de las matrices:');
for i=1:num_capas
    temp_W = -1 + 2*rand(arq_mlp(i+1),arq_mlp(i));
    W{i} = temp_W;
    fprintf('W_%d = \n',i);
    disp(W{i});
    temp_b = -1 + (2)*rand(arq_mlp(i+1),1);
    b{i} = temp_b;
    fprintf('b_%d = \n',i);
    disp(b{i});
    
    % Se imprimen los valores iniciales en los archivos
    for j=1:arq_mlp(i+1)
        for k=1:arq_mlp(i)
            fprintf(archivos_pesos(num_archivos_pesos),'%f\r\n',temp_W(j,k));
            num_archivos_pesos = num_archivos_pesos +1;
        end
    end
    for j=1:arq_mlp(i+1)
        fprintf(archivos_bias(num_archivos_bias),'%f\r\n',temp_b(j));
        num_archivos_bias = num_archivos_bias + 1;
    end
    
end