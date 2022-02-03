location = strcat(pwd,'/Resultados-Arquitectura/');
if ~exist(location, 'dir')
        mkdir(location);
end
archivo_error = strcat(location,'/Error','_',filename,'.txt');
if ~exist(archivo_error,'file')
    id_error = fopen(archivo_error,'a');
    fprintf(id_error,'%f',Err_ap);
    fprintf(id_error,'\r\n');
else
    id_error = fopen(archivo_error,'a');
    fprintf(id_error,'%f',Err_ap);
    fprintf(id_error,'\r\n');
end
fclose(id_error);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
archivo_error2 = strcat(location,'/Arqui','_',filename,'.txt');
if ~exist(archivo_error2,'file')
    id_error = fopen(archivo_error2,'a');
    fprintf(id_error,'%c',str_arq);
    fprintf(id_error,'\r\n');
else
    id_error = fopen(archivo_error2,'a');
    fprintf(id_error,'%c',str_arq);
    fprintf(id_error,'\r\n');
end
decision = input('Revisar evolucion del error 1)SI 2)NO\nIn:');
if decision == 1
    [file_name path_name] = uigetfile({'*.txt'},'File Selector');%lanza filechooser
    nombreArchivoHelp = strcat(path_name,file_name);%concatena direccion
    valorimport = importdata(nombreArchivoHelp);
    figure
    bar(valorimport);
end
fclose(id_error);