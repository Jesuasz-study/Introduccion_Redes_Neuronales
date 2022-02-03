%%archivos_graficacion;
num_archivos_pesos_total = 0;
num_archivos_bias_total = 0;

for i=1:num_capas
    for j=1:arq_mlp(i+1)
        for l=1:arq_mlp(i)
            num_archivos_pesos_total = num_archivos_pesos_total +1;
        end
    end
    num_archivos_bias_total = num_archivos_bias_total +1;
end

archivos_pesos = zeros(num_archivos_pesos_total,1);
archivos_bias = zeros(num_archivos_bias_total,1);
num_archivo = 1;
for i=1:num_capas
    path = strcat(pwd,'/Valores-de-Graficacion/Capa-',num2str(i),'/Pesos/');%pwd direccion del folder actual
    if ~exist(path, 'dir')
        mkdir(path);
    end
    for j=1:arq_mlp(i+1)
        for k=1:arq_mlp(i)
            archivo_pesos = strcat(path,'/pesos',num2str(j),'_',num2str(k),'.txt');
            archivos_pesos(num_archivo) = fopen(archivo_pesos,'w');
            num_archivo = num_archivo +1;
        end
    end
end

num_archivo = 1;
for i=1:num_capas
    path = strcat(pwd,'/Valores-de-Graficacion/Capa-',num2str(i),'/bias/');
    if ~exist(path, 'dir')
        mkdir(path);
    end
    for j=1:arq_mlp(i+1)
        archivo_bias = strcat(path,'/bias',num2str(j),'.txt');
        archivos_bias(num_archivo) = fopen(archivo_bias,'w');
        num_archivo = num_archivo +1;
    end
end