%%% Calculate the average frequency of TFT in the small mutation approximation
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

%% Initialize

b = 1;
c = 0.4;
x = 0.01;
w_values = [0, 0.5, 0.7, 0.9];

N = 50;
str_selection = 0.1;
alpha_values = 0:0.01:1;

c0 = zeros(8,numel(alpha_values));
c1 = zeros(numel(alpha_values),1);
average_freq_CH = {c0,c0,c0};
average_freq_PD = {c0,c0,c0};
coop_freq_CH = {c1,c1,c1};
coop_freq_PD = {c1,c1,c1};

strategy = 1-[0,0,0; 0,0,1; 0,1,0; 1,0,0; 0,1,1; 1,0,1; 1,1,0; 1,1,1];
avg_coop_freq = zeros(8,1);

for i = 1:8
    avg_coop_freq(i) = 0.5*strategy(i,1) + 0.5*strategy(i,2)*strategy(i,3);
end

%% Frequency (equilibrium distribution)
for a1 = 1:numel(w_values)
    w = w_values(a1);
%     for i = 1:8
%         avg_coop_freq(i) = 0.5*strategy(i,1)/(1-w) + 0.5*strategy(i,2)*strategy(i,3)/(1-w);
%     end

    for k = 1:numel(alpha_values)
        alpha = alpha_values(k);
        trans_mat_CH = calculate_trans_mat_markov_chicken(b,c,alpha,x,w,N,str_selection);
        trans_mat_PD = calculate_trans_mat_markov(b,c,alpha,x,w,N,str_selection);
        average_freq_CH{a1}(:,k) = calculate_stat_dist_markov(trans_mat_CH);
        average_freq_PD{a1}(:,k) = calculate_stat_dist_markov(trans_mat_PD);

        % Calculate cooperation frequency
        coop_freq_CH{a1}(k) = sum(avg_coop_freq.*average_freq_CH{a1}(:,k));
        coop_freq_PD{a1}(k) = sum(avg_coop_freq.*average_freq_PD{a1}(:,k));
    end
end

%% Plot

clf
ax1 = subplot(1,2,1); hold on; title('(A) Prisoner''s Dilemma'); box on
ax2 = subplot(1,2,2); hold on; title('(B) Snowdrift'); box on

%style = {'-','-.','--','-'};
style = {'-','-','-','-','-','-','-','-'};

for a1 = 1:numel(w_values)
    plot(ax1,alpha_values,coop_freq_PD{a1},'linewidth',2.5,'linestyle',style{a1},'color',clr(a1,:))
    plot(ax2,alpha_values,coop_freq_CH{a1},'linewidth',2.5,'linestyle',style{a1},'color',clr(a1,:))
end

% for a1 = 1:4
%     plot(ax1,alpha_values,coop_freq_PD{a1}./coop_freq_PD{a1}(1),'linewidth',2.5,'linestyle',style{a1},'color',clr(a1,:))
%     plot(ax2,alpha_values,coop_freq_CH{a1}./coop_freq_CH{a1}(1),'linewidth',2.5,'linestyle',style{a1},'color',clr(a1,:))
% end


legend(ax2,{'w = 0'; 'w = 0.5';  'w = 0.7';  'w = 0.9'})

for ax = [ax1, ax2]
    xlim(ax,[alpha_values(1),alpha_values(end)])
    ylim([0.2,1])
    set(ax,'FontSize',12)
    xlabel(ax,'Power asymmetry (\alpha)')
    ylabel(ax,'Average cooperation')
end

ax2.Legend.Position = [0.7721    0.6661    0.1308    0.2489];

