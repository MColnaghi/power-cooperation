%%
clr = [    
    30, 120, 180;... % Blue
    255, 130, 15;... % Orange
    45, 160, 44;... % Green
    30, 30, 30;... % Black
    215, 40, 40;... % Red
    25, 190, 210; ... % Cyan
    150, 85, 85;... % Brown
    125, 125, 15;... % Gray
    230, 120, 190;... % Pink
    150, 103, 190;... % Purple
    190, 190, 35; ... % Yellow
    ]/255;

clr = [30, 120, 180;... % Blue
    30, 30, 30;... % Black
    215, 40, 40;... % Red
    218, 161, 0;... % yellow
    85, 155, 0;...  %light green
    143, 103, 0;... %brown
    95, 92, 159;... % purple
    214, 2, 126;... % pink
    84, 83, 78]/255;% grey
%% Model Parameters

b = 1;
c = 0.4;
x = 0.01;
w_values = 0:0.01:0.9;

N = 500;
str_selection = 0.05;
alpha_values = [0.5, 1];

c0 = zeros(8,numel(w_values));
average_freq = {c0,c0,c0};

%% Frequency (equilibrium distribution)
tic

for a1 = 1:numel(alpha_values)
    alpha = alpha_values(a1);
    for k = 1:numel(w_values)
        w = w_values(k);
        %trans_mat = calculate_trans_mat_markov_chicken(b,c,alpha,x,w,N,str_selection);
        trans_mat = calculate_trans_mat_markov(b,c,alpha,x,w,N,str_selection);
        average_freq{a1}(:,k) = calculate_stat_dist_markov(trans_mat);
%        disp(stat_dist)
    end
toc
end

%% Alternative plot
%figure
clf
ax1 = subplot(1,2,1); hold on; title('Prisoner''s dilemma'); box on
%ax2 = subplot(1,2,2); hold on; title('\alpha = 1'); box on

style = {'-','-',':',':','-','-','-',':'};

k=0;

for i = [1,8,4,5]
    k=k+1;
    plot(ax1,w_values,average_freq{1}(i,:),'linewidth',2.5,'linestyle',style{k},'color',clr(k,:))
    %plot(ax2,w_values,average_freq{2}(i,:),'linewidth',2.5,'linestyle',style{k},'color',clr(k,:))
end


sum_others = sum([average_freq{1}(2,:);average_freq{1}(3,:);...
    average_freq{1}(6,:);average_freq{1}(7,:)]);

%plot(ax1,w_values,sum_others,'linewidth',2,'linestyle','--','color',clr(6,:))


%legend('CCC','CCD','CDC','DCC','CDD','DCD','DDC','DDD')
%legend(ax1,'CCC','DCC','CDD','DDD')


strategy = {[0,0,0],[0,0,1],[0,1,0],[1,0,0],[0,1,1],[1,0,1],[1,1,0],[1,1,1]};

%ax1.Legend.Position = [0.1526    0.6746    0.0936    0.2053];

for ax=[ax1]
    set(ax,'fontsize',12)
    xlim(ax,[w_values(1), w_values(end)])
    xlabel(ax,'Continuation probability (\itw\rm)')
    ylabel(ax,'Equilibrium frequency')
    %   plot(ax,[w_values(1), w_values(end)],[.125, .125],...
  %      'linestyle','-','linewidth',3,'color','k')
end

legend(ax1,'CCC','DDD','DCC','CDD','Others')

ax1.Legend.Position = [0.1486    0.6005    0.1404    0.2780];
