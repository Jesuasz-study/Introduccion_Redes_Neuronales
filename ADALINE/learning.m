[dates,dontknow] = size(mtzP);
shift = zeros(1,dontknow);
cont = 0;
max = 8;

for loopis = 1:8
    for loop= 1:dates
        a = purelin((W*(mtzP(loop,:)'))+b);        
        targ = mtzT(loop,:);
        error = targ' - a;
        if error(1,1) <= 0 && error(2,1) <= 0
            W = W + (2*alpha*error*mtzP(loop,:));
            b = b + (2*alpha*error);            
        else
            cont = cont + 1;
        end
    end
end