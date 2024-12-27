clear all
close all
clc 
set(groot,'defaultAxesColor', 'white');
sf = 16; fs = 16; ts = 12
fig = figure;
yyaxis left
load x2t.dat; 
x = x2t(:,2)/10^9; y = x2t(:,1);
axis([0 14 0 1])
plot(x,y,'k','LineWidth',2)
hold on
load x2t5.dat; 
x = x2t5(:,2)/10^9; y = x2t5(:,1);
plot(x,y,'--k','LineWidth',2)
texty=('$ a(t) $');
ylabel(texty,'Interpreter','latex','fontsize',sf)
hold on
text('Interpreter','latex','String','$a(t)$','Position',[7,0.66], ...
    'FontSize',fs)
text('Interpreter','latex','String','$a_0(t)$','Position',[7,0.36], ...
    'FontSize',fs)
hold on
yyaxis right
axis([0 14 0 10])
x3 = x2t(:,2)/10^9;
y3 = x2t(:,3);
plot(x3,y3,'k:','LineWidth',1.5)
hold on
texty=('$ z(t) $');
ylabel(texty,'Interpreter','latex','fontsize',sf)
text('Interpreter','latex','String','$z(t)$','Position',[7,1.1], ...
    'FontSize',fs)
textx=('$ t $ (Gyr)');
xlabel(textx,'Interpreter','latex','fontsize',sf)
%title('Evolution of scalefactor over 14 Gyr','FontSize',ts)
print -deps ~/papers/math/cosmoFigs/fig14Gy/fig145Gy
print -deps ~/papers/math/fig145Gy