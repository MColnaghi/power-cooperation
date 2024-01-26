%% Model Parameters

c = 0.4;
b = 1;
%w = 0.5;
x = 0.001;
%alpha = 0.3;
w_values = (0:0.005:0.99);
alpha_values = 0:0.0025:1;

m1 = zeros(numel(alpha_values),numel(w_values));
is_ess = {m1,m1,m1,m1,m1,m1,m1,m1,m1};


%% Payoff calculations
tic
for k = 1:numel(w_values)
    w = w_values(k);
    for j = 1:numel(alpha_values)
        alpha = alpha_values(j);
        %pi = payoff_matrix_CH(b,c,alpha,x,w);
        pi = payoff_matrix_PD(b,c,alpha,x,w);
        pi = pi';
        best = zeros(8,1);
        for i = 1:8
            [~,best(i)] = max(pi(i,:));
            is_ess{i}(j,k) = best(i) == i;
        end
    end
end

is_ess{9} = is_ess{3} | is_ess{4} | is_ess{5} | ...
    is_ess{6} | is_ess{7} | is_ess{2};

toc

%%
strategy_set = {'\rm\it(C,C,C)', '\rm\it(C,C,D)', '\rm\it(C,D,C)', '\rm\it(D,C,C)', ...
    '\rm\it(C,D,D)', '\rm\it(D,C,D)', '\rm\it(D,D,C)', '\rm\it(D,D,D)'};

clf
for i = 2:9
    ax = subplot(3,3,i);
    surf(ax,w_values,alpha_values,int8(is_ess{i-1}), ...
        'EdgeColor','none')
    xlabel('w')
    ylabel('\alpha')
    view(gca,[0 90]);
    title(strategy_set{i-1})
    xlim(ax,[min(w_values),max(w_values)])
    ylim(ax,[min(alpha_values),max(alpha_values)])
    caxis(ax,[0,1])
    set(ax,'fontsize',12)
end

ax = subplot(3,3,1);
surf(ax,w_values,alpha_values,int8(is_ess{9}), ...
    'EdgeColor','none')
title(ax,{'all adaptive strategies'})
xlabel(ax,'w')
ylabel(ax,'\alpha')
view(ax,[0 90]);
xlim(ax,[min(w_values),max(w_values)])
ylim(ax,[min(alpha_values),max(alpha_values)])
set(ax,'fontsize',12)

% %%
% strategy_set = {'CCC', 'DDD', 'CCD', 'CDD', 'DCC', ...
%             'CDC', 'DCD', 'DDC'};
% 
% cell_1 = is_ess{2};
% cell_2 = is_ess{4};
% is_ess{2} = is_ess{8};
% is_ess{8} = cell_1;
% is_ess{4} = is_ess{6};
% is_ess{6} = cell_2;

shift = 0.03* [-1.5,-.5,.5,1.5,-1.5,-.5,.5,1.5];

clf
%colormap summer
for i = 2:9
    ax = subplot(2,4,i-1);
    
    if i == 9
    surf(ax,[-2,-1],[-2,-1],ones(2), ...
        'EdgeColor','none')
    hold on
    end
    caxis(ax,[0,1])

    surf(ax,w_values,alpha_values,int8(is_ess{i-1}), ...
        'EdgeColor','none')

    caxis(ax,[0,1])
    xlabel('w')
    ylabel('\alpha')
    view(gca,[0 90]);
    title(strategy_set{i-1})
    xlim(ax,[min(w_values),max(w_values)])
    ylim(ax,[min(alpha_values),max(alpha_values)])
    set(ax,'fontsize',12)

    if i ==9
        legend(ax, 'ESS')
        drawnow
        legend('boxoff')  
        ax.Legend.Position = [0.385    0.015    0.0797    0.0421];
        ax.Legend.FontSize = 14;
    end


    ax.Position(1) = ax.Position(1)+shift(i-1);
    ax.Position(2) = ax.Position(2)+0.04;
    ax.Position(3) = ax.Position(3)+0.02;
    ax.Position(4) = ax.Position(4)-0.02;
    
    if i > 5
        ax.Position(2) = ax.Position(2)+0.01;
    end


    if i ==8
        legend(ax, 'Unstable')
        drawnow
        legend('boxoff')  
        ax.Legend.Position = [0.5395    0.015    0.0797    0.0421];
        ax.Legend.FontSize = 14;
    end
    
end



%%
% clf
% x_iso = cell(4,1);
% y_iso = cell(4,1);
% colormap hot
% for i = 4:9
%     ax = subplot(3,2,i-3);
% 
%     surf(ax,w_values,alpha_values,int8(is_ess{i-1}), ...
%         'EdgeColor','none')
%     xlabel('\itw')
%     ylabel('\alpha')
%     view(gca,[0 90]);
%     title(strategy_set{i-1})
%     xlim(ax,[min(w_values),max(w_values)])
%     ylim(ax,[min(alpha_values),max(alpha_values)])
%     caxis(ax,[0,1])
%     set(gca,'FontSize',12)
% end

% ax = subplot(3,3,1);
% surf(ax,w_values,alpha_values,int8(is_ess{9}), ...
%     'EdgeColor','none')
% title(ax,{'adaptive'})
% xlabel(ax,'w')
% ylabel(ax,'\alpha')
% view(ax,[0 90]);
% xlim(ax,[min(w_values),max(w_values)])
% ylim(ax,[min(alpha_values),max(alpha_values)])