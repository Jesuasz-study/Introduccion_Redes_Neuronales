%regla de aprendizaje
%el contador va a ralizar las epocas
%cada que un vector de entrada es evaluado se termina una iteracion
%va a haber 8 iteraciones por epoca var:dates
[dates,dontknow] = size(mtzP);
shift = zeros(1,dontknow);
cont = 0;
modif = 1;
right = 0;
while cont<=10
    for loop= 1:dates
        a = hardlim((W*(mtzP(loop,:)'))+b);        
        targ = mtzT(loop);
        error = targ - a;
        if error == 1
            W = rand(1:features);
            b = rand;
            shift(modif,1) = W(1);
            shift(modif,2) = W(2);
            modif = modif + 1;
            cont = cont + 1;
        elseif error == -1
            W = rand(1:features);
            b = rand;
            shift(modif,1) = W(1);
            shift(modif,2) = W(2);
            modif = modif + 1;
            cont = cont + 1;
        elseif error == 0
            cont = cont + 1;
            right = right + 1;
        end
    end
    if(right == 8)
        break;
    else
        right=0;
    end
end