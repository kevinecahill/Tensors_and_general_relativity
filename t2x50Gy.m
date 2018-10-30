clear all
close all
clc 
sf = 16; fs = 16; ts = 12;
fig = figure;
left_color = [.5 0 .1];
right_color = [.1 0 .5];
set(fig,'defaultAxesColorOrder',[left_color; right_color]);
yyaxis left
load newx2tMV.dat;
x = newx2tMV(:,2)/10^9; y = newx2tMV(:,1);
axis([0 50 0 5])
plot(x,y,'k','LineWidth',2,'Color',[.5 0 .1])
texty=('$ a(t) $');
ylabel(texty,'Interpreter','latex','fontsize',sf,'Color',[.5 0 .1])
text('Interpreter','latex','String','$a(t)$','Position',[33.5,3],...
    'FontSize',fs,'Color',[.5 0 .1])
line([13.787 13.787], [0,1],'Color',[.5 0 .1]);
line([0 13.787], [1,1],'Color',[.5 0 .1]);
line( [0 10.228], [0.76721 0.76721],'Color',[.5 0 .1] );
hold on
yyaxis right
axis([0 50 0 10^(-26)])
load newx2trhoMv.dat;
x3 = newx2trhoMv(:,2)/10^9;
y3 = newx2trhoMv(:,1);
plot(x3,y3,'--k','LineWidth',2,'Color',[.1 0 .5]);
text('Interpreter','latex','String','$\rho_m(t)$','Position',...
    [10,0.8E-26],'FontSize',fs,'Color',[.1 0 .5])
hold on
load newx2trhoVm.dat;
x4 = newx2trhoVm(:,2)/10^9;
y4 = newx2trhoVm(:,1);
plot(x4,y4,'-.','LineWidth',2,'Color',[.1 0 .5]);
text('Interpreter','latex','String','$\rho_\Lambda$','Position',...
    [4,0.64E-26],'FontSize',fs,'Color',[.1 0 .5])
line([10.228 10.228], [0 5.9238E-027],'Color',[.1 0 .5]);
hold on
texty=('$ \rho(t) $ (kg\,m\({}^{-3}\)) ');
ylabel(texty,'Interpreter','latex','fontsize',sf,'Color',[.1 0 .5])
textx=('$ t $ (Gyr)');
xlabel(textx,'Interpreter','latex','fontsize',sf)
%title('Evolution of scalefactor and densities over 50 Gyr','fontsize',12)
print -deps ~/papers/eras/fig50Gy
print -depsc2 ~/papers/eras/fig50Gy
print -deps ~/papers/math/fig50Gy
%print -dpdf ~/papers/math/fig50Gy