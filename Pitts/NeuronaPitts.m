disp('1.Compuerta AND');
disp('2.Compuerta OR');
disp('3.Compuerta NOT');
opc_menu = input('Compueta a que desee aprender:');
switch opc_menu
    case 1  %AND
        disp('Operador --AND--');
        no_input = input ('Datos de entrada: ');%Ingrese el no. de datos de entrada
        %Creo un vector que contiene los valores de la tabla de verdad
        %En formato decimal
        vector_in = (0:2^(no_input)-1);
        %de2bi convierte a un decimal en un vector binario
        %el vector de decimales lo vuelve una matriz de binarios 
        matriz = de2bi(vector_in);
        %Se cambia el orden de los datos para comenzar con el mas significativo
        matriz = fliplr(matriz);
        weight = zeros(no_input,1); %Matriz que contiene pesos para cada dato de entrada
        %El ciclo pide el valor de los pesos al usuario
        for i = 1:no_input
            aux_for = input('Valor de W: ');
            weight(i,1) = aux_for;
        end        
        umbral = input('Valor de Umbral: '); %Ingresa valor de umbral
        value_a = zeros(2^(no_input),1); %guardará resultados
        
        for i = 1:2^(no_input)%recorre filas
            N = 0;%reinicia el valor de N por fila
            for j = 1:no_input%Recorre las columnas de una sola fila
                N = N + matriz(i,j)*weight(j,1);
            end
            if N > umbral%evalua dato con umbral
                value_a(i,1) = 1;
            else
                value_a(i,1) = 0;
            end
        end
        disp('--Tabla de verdad--');
        disp(value_a);
    case 2  %OR
        disp('Operador --OR--');
        no_input = input ('Datos de entrada: ');%Ingrese el no. de datos de entrada
        %Creo un vector que contiene los valores de la tabla de verdad
        %En formato decimal
        vector_in = (0:2^(no_input)-1);
        %de2bi convierte a un decimal en un vector binario
        %el vector de decimales lo vuelve una matriz de binarios 
        matriz = de2bi(vector_in);
        %Se cambia el orden de los datos para comenzar con el mas significativo
        matriz = fliplr(matriz);
        weight = zeros(no_input,1); %Matriz que contiene pesos para cada dato de entrada
        %El ciclo pide el valor de los pesos al usuario
        for i = 1:no_input
            aux_for = input('Valor de W: ');
            weight(i,1) = aux_for;
        end        
        umbral = input('Valor de Umbral: '); %Ingresa valor de umbral
        value_a = zeros(2^(no_input),1); %guardará resultados
                
        for i = 1:2^(no_input)%recorre todas las filas
            N = 0;%reinicia el valor de N para cada nueva fila
            for j = 1:no_input%Recorre las columnas de una sola fila
                N = N + matriz(i,j)*weight(j,1);
            end
            if N > umbral
                value_a(i,1) = 1;
            else
                value_a(i,1) = 0;
            end
        end
        disp('--Tabla de verdad--');
        disp(value_a);
    case 3  %NOT
       disp('Operador --NOT--')
       umbral = input('Ingrese valor de umbral:');
       peso = input('Ingrese valor del peso sinaptico:');
       datos_in = (0:1);
       matriz_in = de2bi(datos_in);
       value_a = [0;0];
       
       N = 0;
       for i = 1:2
           N = matriz_in(i,1)*peso;
           if N > umbral
               value_a(i,1) = 1;
           else
               value_a(i,1) = 0;
           end
       end
       disp('--Tabla de verdad--');
       disp(value_a);
end