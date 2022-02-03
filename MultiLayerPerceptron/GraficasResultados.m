% Grafica la evolucion de los errores de aprendizaje y validacion por
% epoca.
figure
rango = 1:1:it;
rango2 = itval:itval:num_it_val*itval;
s1 = scatter(rango,valores_graficacion_eap(1:it,1),'o');%%%%%%%%%%%%%
s1.MarkerFaceColor = [1 0 0];
s1.MarkerEdgeColor = 'r';
grid on
hold on
s2 = scatter(rango2,valores_graficacion_eval(itval:itval:num_it_val*itval,1),'d');
s2.MarkerFaceColor = [1 0 0];
s2.MarkerEdgeColor = 'r';
title('Error de aprendizaje y Error de validacion');
ylabel('Valor del error');
xlabel('Iteracion');
lgd = legend('Eap','Eval','Location','southoutside');
title(lgd,'Simbología');
hold off

%Grafica de evolucion de pesos
rango = 0:1:it;
for i=1:num_capas
    figure
    path = strcat(pwd,'/Valores-de-Graficacion/Capa-',num2str(i),'/Pesos/');
    for j=1:arq_mlp(i+1)
        for k=1:arq_mlp(i)
            archivo_pesos = strcat(path,'/pesos',num2str(j),'_',num2str(k),'.txt');
            simb = strcat('W(',num2str(j),',',num2str(k),')');
            evolucion_pesos = importdata(archivo_pesos); % Identificador para la grafica
            plot(rango,evolucion_pesos','DisplayName',simb);
            hold on
            grid on
        end
    end
    titulo = strcat('Evolucion de los pesos de la capa',{' '},num2str(i));
    title(titulo);
    ylabel('Valor de los pesos');
    xlabel('Iteracion');
    lgd = legend('show','Location','southoutside');
    title(lgd,'Simbología');
    hold off
end

%Grafica de evolucion de bias
rango = 0:1:it;
for i=1:num_capas
    figure
    path = strcat(pwd,'/Valores-de-Graficacion/Capa-',num2str(i),'/bias/');
    for j=1:arq_mlp(i+1)
        archivo_bias = strcat(path,'/bias',num2str(j),'.txt');
        simb = strcat('b(',num2str(j),')');
        evolucion_bias = importdata(archivo_bias); % Identificador para la grafica
        plot(rango,evolucion_bias','DisplayName',simb);
        hold on
        grid on
    end
    titulo = strcat('Evolucion de los bias de la capa',{' '},num2str(i));
    title(titulo);
    ylabel('Valor de los bias');
    xlabel('Iteracion');
    lgd = legend('show','Location','southoutside');
    title(lgd,'Simbología');
    hold off
end

for i=1:num_capas
    path = strcat(pwd,'/Resultados-finales/Capa-',num2str(i),'/');
    if ~exist(path, 'dir')
        mkdir(path);
    end
    W_temp = cell2mat(W(i));
    res_pesos = strcat(path,'/pesos.txt');
    dlmwrite(res_pesos,W_temp,';');
end

for i=1:num_capas
    path = strcat(pwd,'/Resultados-finales/Capa-',num2str(i),'/');
    if ~exist(path, 'dir')
        mkdir(path);
    end
    b_temp = cell2mat(b(i));
    res_bias = strcat(path,'/bias.txt');
    dlmwrite(res_bias,b_temp,';');
end

% Grafica conjunto de prueba
% targets VS resultados de la red.
figure
rango = cto_prueba(:,1);
s1 = scatter(rango,salida_red,'s');
s1.MarkerFaceColor = [1 0 0];
s1.MarkerEdgeColor = 'r';
grid on
hold on
s2 = scatter(rango,cto_prueba(:,2),'o');
s2.MarkerFaceColor = [0 1 0];
s2.MarkerEdgeColor = 'g';
title('Target v.s. Resultados -Cto. Prueba-)');
ylabel('f(p)');
xlabel('p');
lgd = legend('Salida de la red','Target','Location','southoutside');
title(lgd,'Simbología');
hold off

% Se propaga el conjunto de entrenamiento
salida_red = zeros(num_elem_ent,1);
for i=1:num_elem_ent
    a{1} = cto_ent(i,1); % Condicion inicial
    for k=1:num_capas
        W_temp = cell2mat(W(k));
        a_temp = cell2mat(a(k));
        b_temp = cell2mat(b(k));
        a{k+1} = funcionDeActivacion(W_temp*a_temp+b_temp,fun_capa(k));
    end
    dato_entrada = cell2mat(a(1));
    a_temp = cell2mat(a(num_capas+1));
    Ep = Ep+(1/num_elem_ent)*(cto_ent(i,2)-a_temp);
    salida_red(i) = a_temp;
end

% Graficacion de conjunto de entrenamiento
% targets VS resultados de la red.
figure
rango = cto_ent(:,1);
plot(rango,salida_red,'Color',[0.9,0.1,0.1]);
grid on
hold on
plot(rango,cto_ent(:,2),'--','Color',[0,0.7,0.9]);
title('Target v.s. Resultados -Cto. Entrenamiento-');
ylabel('f(p)');
xlabel('p');
lgd = legend('Salida de la red','Target','Location','southoutside');
title(lgd,'Simbología');
hold off
