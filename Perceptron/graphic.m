plot([-5 5],[0 0]);
hold on
plot([0 0],[-5 5]);
hold on

for loop=1:8
scatter(mtzP(loop,1),mtzP(loop,2));
hold on
end

p2 = -(b/W(2));
p1 = -(b/W(1));
m = (p2-0)/(0-p1);
yf1 = (m*(5))+p2;
yf2 = (m*(-5))+p2;


mP = (-1)/m;
yf3 = mP*(-5)-((mP*W(1))+W(2));

plot([0 -5],[0 yf3]);
plot([5 -5],[yf1 yf2]);
figure
plot (shift);