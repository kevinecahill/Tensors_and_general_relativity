clear all
close all
clc 
sf = 16; fs = 16;ts=12;
fig = figure;
left_color = [.5 0 .1];
right_color = [.1 0 .5];
set(fig,'defaultAxesColorOrder',[left_color; right_color]);
yyaxis left
load newx2tRM.dat;
x = newx2tRM(:,2)/10^3; y = newx2tRM(:,1);
axis([0 100 0 0.001])
plot(x,y,'k','LineWidth',2,'Color',[.5 0 .1])
texty=('$ a(t) $');
ylabel(texty,'Interpreter','latex','fontsize',sf)
line([50.506 50.506], [0 2.919E-4]);
line([0 50.506], [2.919E-4 2.919E-4]); 
hold on
yyaxis right
axis([0 100 0 5*10^(-16)])
load newx2trhom.dat;
x3 = newx2trhom(:,2)/10^3;
y3 = newx2trhom(:,1);
plot(x3,y3,'--','LineWidth',2,'Color',[.1 0 .5]);
text('Interpreter','latex','String','$\rho_r(t)$','Position',...
    [31.5,3.60E-16],'FontSize',fs)
hold on
load newx2trhor.dat;
x4 = newx2trhor(:,2)/10^3;
y4 = newx2trhor(:,1);
plot(x4,y4,'-.','LineWidth',2,'Color',[.1 0 .5]);
text('Interpreter','latex','String','$\rho_m(t)$','Position',...
    [14,3.60E-16],'FontSize',fs)
text('Interpreter','latex','String','$a(t)$','Position',...
    [65,3.6E-16],'FontSize',fs)
line([50.506 50.506], [0 1.0751E-16]);
line([50.506 100], [1.0751E-16 1.0751E-16]); 
hold on
texty=('$ \rho(t) $ (kg/m\({}^{3}\))');
ylabel(texty,'Interpreter','latex','fontsize',sf)
textx=('$ t $ (kyr)');
xlabel(textx,'Interpreter','latex','fontsize',sf)
%title('Evolution of scalefactor and densities over first 100 kyr','FontSize',ts)
print -deps ~/papers/eras/fig100kyr
print -depsc2 ~/papers/eras/fig100kyr
print -deps ~/papers/math/fig100kyr
