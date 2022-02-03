plot([-5 5],[0 0]);
hold on
plot([0 0],[-5 5]);
hold on

for loop=1:8
scatter(mtzP(loop,1),mtzP(loop,2));
hold on
end

p2 = -(b(1,1)/W(2,1));
p1 = -(b(2,1)/W(1,1));
m = (p2-0)/(0-p1);
yf1 = (m*(5))+p2;
yf2 = (m*(-5))+p2;


p2b = -(b(1,1)/W(2,2));
p1b = -(b(2,1)/W(1,2));
mb = (p2b-0)/(0-p1b);
yf1b = (mb*(5))+p2b;
yf2b = (mb*(-5))+p2b;

    
mP = (-1)/m;
yf3 = mP*(-5)-((mP*W(1,1))+W(2,1));

mPb = (-1)/mb;
yf3b = mPb*(-5)-((mPb*W(1,2))+W(2,2));

%plot([0 -5],[0 yf3]);
plot([5 -5],[yf1 yf2]);
plot([5 -5],[yf1b/5 yf2b/5]);
%figure
%plot (shift);