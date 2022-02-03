disp('¡--Modo regresor--!');
tam = 5;
matriz = (0:2^(tam)-1);
matriz = de2bi(matriz);
matriz = fliplr(matriz);
aux = (0:2^(tam)-1);
matriz = [matriz aux'];

%pedimos los datos al usuario y iniciamos los pesos entre 1 y -1
epochMax = input('Numero maximo de epocas:');
Eepoch = input('Erro minimo de epoca:');
alpha = input('Factor de aprendizaje:');
clc;
%formula general r = a + (b-a).*rand(N,1). en el intervalo (a,b)
weight = -1 + (1-(-1))*rand(1,tam);
auxEepoch = 0;
matrizA = zeros(1,2^tam);
cont = 0;

for j = 1:epochMax
    for i = 1:2^(tam)
        a = purelin(weight*matriz(i,(1:tam))');
        matrizA(i) = a;
        error = matriz(i,tam+1) - a;
        
        if error ~= 0
            weight = weight + (2*alpha*error*matriz(i,(1:tam)));
        end
        auxEepoch = auxEepoch + error;
        
        subplot(2,2,1),plot(weight),title('Pesos W');
        hold on
    end
    Ecount = (1\tam)*(auxEepoch);
    if Ecount <= Eepoch && Ecount > 0
        disp('La prueba a convergido');
        disp(cont);
        break
    else
        auxEepoch = 0;
        cont = cont + 1;
    end
    
    subplot(2,2,2),plot(matrizA),title('Valores de salida');
    hold on
end
subplot(2,2,3),plot(matrizA),title('Resultado de Aprendizaje');
subplot(2,2,4),plot(aux),title('Targets');
hold on