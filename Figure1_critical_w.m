%%
clf


clr = [30, 120, 180;... % Blue
    218, 161, 0;... % yellow
    215, 40, 40;... % Red
    30, 30, 30;... % Black
    85, 155, 0;...  %light green
    143, 103, 0;... %brown
    95, 92, 159;... % purple
    214, 2, 126;... % pink
    84, 83, 78]/255;% grey


style = {'-','--','-.','-'};

ax1 = subplot(1,2,1);
hold on

b = 1;
c = [0.1, 0.2, 0.3, 0.4]';

x = 0:0.01:1;
alpha = x;

%critical_w_rand = 2./(1+alpha)*c/b;
%critical_w_rand_eta = 2./(1+alpha)*c/b+ 0.1;
%critical_w_nonrand = c./(alpha*b);

%plot(x, critical_w_nonrand, 'LineWidth',2,'Color',clr(2,:),'LineStyle','--')
%plot(x, critical_w_rand, 'LineWidth',2,'Color',clr(1,:),'LineStyle','-')
%plot(x, critical_w_rand_eta, 'LineWidth',2,'Color',clr(3,:),'LineStyle','-')

critical_w_SD = c/b*1./(1-alpha);
%critical_w_PD = 2./(1+alpha)*c/b;

%plot(x, critical_w_PD, 'LineWidth',2,'Color',clr(5,:),'LineStyle','-')
for i = 1:4
    plot(x, critical_w_SD(5-i,:), 'LineWidth',2.5,'Color',clr(i,:),'LineStyle','-')
    
end
ylim(ax1,[0,1])
xlim(ax1,[0,.8])

legend({'c = 0.4','c = 0.3','c = 0.2','c = 0.1'})

set(gca,'fontsize',12)
xlabel('Power asymmetry (\alpha)')
ylabel('Continuation probability (w)')
%legend({'Only asymmetric','Random','Random + Noise'})

ax1.Legend.Position = [0.1466    0.6569    0.1321    0.2515];
box on