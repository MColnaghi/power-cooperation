%%

clf
clc
clear
clr = [30, 120, 180;... % Blue
    218, 161, 0;... % yellow
    215, 40, 40;... % Red
    30, 30, 30;... % Black
    85, 155, 0;...  %light green
    143, 103, 0;... %brown
    95, 92, 159;... % purple
    214, 2, 126;... % pink
    84, 83, 78]/255;% grey

%%
c_values = [0.4];

ax1 = subplot(1,2,1); hold on;

for k = 1
    c = c_values(k);
    b = 1;
    w = 0;
    x = 0.01;
    alpha_values = 0:0.01:1;
    power_asymm_pd = zeros(numel(alpha_values),1)';
    power_asymm_sd = zeros(numel(alpha_values),1)';

    for i = 1:numel(alpha_values)
        alpha = alpha_values(i);
        power_asymm_pd(i) = calculate_power_asymm_PD(b,c,alpha,w);
        power_asymm_sd(i) = calculate_power_asymm_SD(b,c,alpha,w);

    end

    plot(ax1,alpha_values,power_asymm_pd,"LineWidth",2,"Color",clr(1,:))
    plot(ax1,alpha_values,power_asymm_sd,"LineWidth",2,"Color",clr(3,:))

end

xlabel(ax1,'Power asymmetry (\alpha)')
ylabel(ax1,'Asymmetric dependence')
set(ax1,'fontsize',12)
%xlabel(ax2,'Power asymmetry (\alpha)')
%ylabel(ax2,'Asymmetric dependence')
%set(ax2,'fontsize',12)

%legend(ax1,{'c = 0.7','c = 0.5','c = 0.3','c = 0.1'})
legend(ax1,{'Prisoner''s dilemma','Snowdrift'})

ax1.Legend.Position = [0.1479    0.7603    0.2301    0.1247];
box on