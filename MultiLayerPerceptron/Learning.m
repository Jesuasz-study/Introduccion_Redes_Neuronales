%%Learning
% Se utiliza una cell para guardar las salidas de cada capa
a = cell(num_capas+1,1);

% Se utiliza una cell para guardas las sensitividades de cada capa y las
% matrices de derivadas.
S = cell(num_capas,1);
F_m = cell(num_capas,1);
X = input('Presiona ENTER para comenzar el aprendizaje...');

% Comienza el aprendizaje
early_stopping = 0;
Err_val = 0;
Err_ap = 0;
valores_graficacion_eap = zeros(itmax,1);
valores_graficacion_eval = zeros(ceil(itmax/itval),1);
count_val = 0;
num_it_val = 0; % Numero de iteraciones de validacion realizadas
for it=1:itmax
    num_archivos_pesos = 1;
    num_archivos_bias = 1;
    Eap = 0; % Error de aprendizaje
    % Si no es una iteracion de validacion
    if(mod(it,itval)~=0)
        for dato=1:num_elem_ent
            
            a{1} = cto_ent(dato,1); % Condicion inicial
            
            % Se propaga hacia adelante el elemento del cto. de
            % entrenamiento
            for k=1:num_capas
                W_temp = cell2mat(W(k));
                a_temp = cell2mat(a(k));
                b_temp = cell2mat(b(k));
                a{k+1} = funcionDeActivacion(W_temp*a_temp+b_temp,fun_capa(k));
            end
            a_temp = cell2mat(a(num_capas+1));
            ej = cto_ent(dato,2)-a_temp;
            Eap = Eap+(ej/num_datos);
            
            % Se calculan las sensitividades y se propagan hacia atras,
            % es decir, inicia el backpropagation.
            F_m{num_capas} = obtenerF(fun_capa(num_capas),arq_mlp(num_capas+1),a_temp);
            F_m_temp = cell2mat(F_m(num_capas));
            S{num_capas} = -2*F_m_temp*(ej);
            for m = num_capas-1:-1:1
                W_temp = cell2mat(W(m+1));
                a_temp = cell2mat(a(m+1));
                S_temp = cell2mat(S(m+1));
                F_m{m} = obtenerF(fun_capa(m),arq_mlp(m+1),a_temp);
                F_m_temp = cell2mat(F_m(m));
                S{m} = F_m_temp*(W_temp')*S_temp;
            end
            
            % Se aplican las reglas de aprendizaje
            for k=num_capas:-1:1
                W_temp = cell2mat(W(k));
                b_temp = cell2mat(b(k));
                a_temp = cell2mat(a(k));
                S_temp = cell2mat(S(k));
                W{k} = W_temp-(alfa*S_temp*(a_temp'));
                b{k} = b_temp-(alfa*S_temp);
                W_temp = cell2mat(W(k));
                b_temp = cell2mat(b(k));
            end
            
        end
        Err_ap = Eap;
        
        % Se guarda el valor de graficación de Eap
        valores_graficacion_eap(it) = Eap;
        
    % Si es una iteracion de validacion    
    else
        E_val = 0;
        num_it_val = num_it_val + 1;
        for dato=1:num_elem_val
            a{1} = cto_val(dato,1); % Condicion inicial
            % Se propaga hacia adelante el elemento del cto. de
            % validacion.
            for k=1:num_capas
                W_temp = cell2mat(W(k));
                a_temp = cell2mat(a(k));
                b_temp = cell2mat(b(k));
                a{k+1} = funcionDeActivacion(W_temp*a_temp+b_temp,fun_capa(k));
            end
            a_temp = cell2mat(a(num_capas+1));
            e_val = cto_val(dato,2)-a_temp;
            E_val = E_val+(e_val/num_elem_val);
        end
        
        % Se guarda el valor para graficacion
        valores_graficacion_eval(it) = E_val;
        
        if count_val == 0
            Err_val = E_val;
            count_val = count_val+1;
            fprintf('Count val = %d\n',count_val);
        else
            if E_val > Err_val
                Err_val = E_val;
                count_val = count_val+1;
                fprintf('Count val = %d\n',count_val);
                if count_val == numval
                    early_stopping = 1;
                    fprintf('Early stopping en iteracion %d\n',it);
                    break;
                end
            else
                Err_val = 0;
                count_val = 0;
                fprintf('Count val = %d\n',count_val);
            end
        end
    end
    
    % Se imprimen los valores de pesos y bias modificados a archivo
    num_archivos_pesos = 1;
    num_archivos_bias = 1;
    for k=num_capas:-1:1
        W_temp = cell2mat(W(k));
        b_temp = cell2mat(b(k));
        for j=1:arq_mlp(k+1)
            for l=1:arq_mlp(k)
                fprintf(archivos_pesos(num_archivos_pesos),'%f\r\n',W_temp(j,l));
                num_archivos_pesos = num_archivos_pesos +1;
            end
        end
        for j=1:arq_mlp(k+1)
            fprintf(archivos_bias(num_archivos_bias),'%f\r\n',b_temp(j));
            num_archivos_bias = num_archivos_bias + 1;
        end
    end
    
    % Se comprueban las condiciones de finalizacion
    if Eap <= eit && Eap >= 0 && mod(it,itval) ~= 0
        Err_ap = Eap;
        fprintf('Aprendizaje exitoso en la iteracion %d\n',it);
        break;
    end
end

if it == itmax
    disp('Se llego a itmax.');
end

% Se imprimen a archivo los ultimos valores de pesos y bias de cada capa
if early_stopping == 1
% Se imprimen los valores de pesos y bias modificados a archivo
    num_archivos_pesos = 1;
    num_archivos_bias = 1;
    for k=num_capas:-1:1
        W_temp = cell2mat(W(k));
        b_temp = cell2mat(b(k));
        for j=1:arq_mlp(k+1)
            for l=1:arq_mlp(k)
                fprintf(archivos_pesos(num_archivos_pesos),'%f\r\n',W_temp(j,l));
                num_archivos_pesos = num_archivos_pesos +1;
            end
        end
        for j=1:arq_mlp(k+1)
            fprintf(archivos_bias(num_archivos_bias),'%f\r\n',b_temp(j));
            num_archivos_bias = num_archivos_bias + 1;
        end
    end
end

% Se cierran los archivos de valores de graficacion de pesos y bias
for i=1:num_archivos_pesos_total
    fclose(archivos_pesos(i));
end
for i=1:num_archivos_bias_total
    fclose(archivos_bias(i));
end

% Se propaga el conjunto de prueba
Ep = 0; % Error de prueba
salida_red = zeros(num_elem_prueba,1);
for i=1:num_elem_prueba
    a{1} = cto_prueba(i,1); % Condicion inicial
    % Se propaga hacia adelante el elemento del cto. de prueba
    for k=1:num_capas
        W_temp = cell2mat(W(k));
        a_temp = cell2mat(a(k));
        b_temp = cell2mat(b(k));
        a{k+1} = funcionDeActivacion(W_temp*a_temp+b_temp,fun_capa(k));
    end
    dato_entrada = cell2mat(a(1));
    a_temp = cell2mat(a(num_capas+1));
    Ep = Ep+(1/num_elem_prueba)*(cto_prueba(i,2)-a_temp);
    salida_red(i) = a_temp;
end

% Se imprimen los valores finales de Eap, Ep y Eval
fprintf('Error de entrenamiento = %f\n',Err_ap);
fprintf('Error de validacion = %f\n',Err_val);
fprintf('Error de prueba = %f\n',Ep);