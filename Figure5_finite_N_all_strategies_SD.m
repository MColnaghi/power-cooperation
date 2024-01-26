%%
clr = [30, 120, 180;... % Blue
    85, 155, 0;...  %light green
    30, 30, 30;... % Black
    143, 103, 0;... %brown
    218, 161, 0;... % yellow
    215, 40, 40;... % Red
    95, 92, 159;... % purple
    214, 2, 126;... % pink
    84, 83, 78]/255;% grey

%% Model Parameters

b = 1;
c = 0.4;
x = 0.01;
w_values = 0:0.01:0.9;

N = 100;
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
        trans_mat = calculate_trans_mat_markov_chicken(b,c,alpha,x,w,N,str_selection);
        %trans_mat = calculate_trans_mat_markov(b,c,alpha,x,w,N,str_selection);
        average_freq{a1}(:,k) = calculate_stat_dist_markov(trans_mat);
%        disp(stat_dist)
    end
toc
end

%% plot
clf

ax2 = subplot(1,2,1); hold on; title('Snowdrift'); box on

style = {'-',':',':',':','-','-','-',':'};

k=0;

plot(ax2,w_values,average_freq{1}(1,:),'linewidth',2.5,'linestyle',style{1},'color',clr(1,:))
plot(ax2,w_values,average_freq{1}(8,:),'linewidth',2.5,'linestyle',style{1},'color',clr(3,:))
%plot(ax2,[0,0],[0,0],'linewidth',2.5,'linestyle',style{2},'color',clr(4,:))
%plot(ax2,[0,0],[0,0],'linewidth',2.5,'linestyle',style{2},'color',clr(5,:))
plot(ax2,w_values,average_freq{1}(2,:),'linewidth',2.5,'linestyle',style{2},'color',clr(2,:))

sum_others = sum([average_freq{1}(3,:);average_freq{1}(4,:);...
    average_freq{1}(5,:);average_freq{1}(6,:);...
    average_freq{1}(7,:),]);

%plot(ax2,w_values,sum_others,'linewidth',2,'linestyle','--','color',clr(6,:))

legend('CCC','DDD','CCD', 'Others')
%legend(ax2,'CCC','DDD','DCC','CDD','CCD')


strategy = {[0,0,0],[0,0,1],[0,1,0],[1,0,0],[0,1,1],[1,0,1],[1,1,0],[1,1,1]};

ax2.Legend.Position = [0.1501    0.6995    0.0989    0.2114];

for ax=[ax2]
    set(ax,'fontsize',12)
    xlim(ax,[w_values(1), w_values(end)])
    xlabel(ax,'Continuation probability (\itw\rm)')
    ylabel(ax,'Equilibrium frequency')
    %   plot(ax,[w_values(1), w_values(end)],[.125, .125],...
  %      'linestyle','-','linewidth',3,'color','k')
end
