clc;
clear;
disp('1.Modo regresor');
disp('2.Modo clasificador');
opt = input('Elije el modo:');

switch opt
    case 1
        regresor;
    case 2
        clasificador;
end
