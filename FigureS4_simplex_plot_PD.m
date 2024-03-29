%% Initialize
clf
clc
clear

b = 1;
c = 0.4;
w_values = [0.1, 0.1, 0.7, 0.7];
x=0.01;

N = 30;
str_selection = 0.1;
alpha = 0.5;
u_values = [0.01, 0.05, 0.01, 0.05];

%strategy = 1-[0,0,0; 0,0,1; 0,1,0; 1,0,0; 0,1,1; 1,0,1; 1,1,0; 1,1,1];
% i.e.: (CCC, CCD, CDC, DCC, CDD, DCD, DDC, DDD)
% c1 = flipud(colormap('gray'));
% a = numel(c1(:,1))/8;
% c1 = c1(a:end,:);
% colormap(c1)

%%
for j = 1:4
    u = u_values(j);
    w = w_values(j);

    %Payoff matrix (3 strategies only: CCC, CCD, DDD)

    pi = payoff_matrix_PD(b,c,alpha,x,w);

    pi = pi(:,[1,5,end]);
    pi = pi([1,5,end],:);

    %Transition probabilities;

    [T,F] = transition_matrix(N,str_selection,pi,u);

    [V,D] = eig(T');

    ix = find(isAlways(abs(1-diag(D))<10^(-12),'Unknown','error'));

    stationary_dist = V(:,ix)/sum(V(:,ix));


    % plot
    line_width = 2;
    k=2; %2-simplex
    simplex_vertices = eye(k+1);

    ax1 = subplot(2,2,j);
    title(['\rm\itU\rm = ', num2str(u), newline])
    hold on
    %simp_vert = [simplex_vertices, simplex_vertices(:,1)];
    %plot3(simp_vert(1,:),simp_vert(2,:),simp_vert(3,:), 'linewidth',1, 'Color',	'k');
    view([-42.4532608695652 0.125806451612902]);
    set(gca,'XColor','none','YColor','none','ZColor','none')
    scatter3(F(:,1), F(:,2), F(:,3),20,stationary_dist,'filled')
    xlabel('CCC')
    ylabel('CCD')
    colorbar(ax1)
    %ax1.Position(3) = 0.2;
    set(gca,'FontSize',12)

    % Create textbox
    annotation('textbox',...
        [0.53 0.54 0.08 0.043],'String','(C,D,D)',...
        'FontSize',12,...
        'FitBoxToText','off',...
        'EdgeColor','none');

    % Create textbox
    annotation('textbox',...
        [0.76 0.54 0.08 0.043],'String','(C,C,C)',...
        'FontSize',12,...
        'FitBoxToText','off',...
        'EdgeColor','none');

    % Create textbox
    annotation('textbox',...
        [0.08 0.067 0.08 0.043],...
        'String','(C,D,D)',...
        'FontSize',12,...
        'FitBoxToText','off',...
        'EdgeColor','none');

    % Create textbox
    annotation('textbox',...
        [0.33 0.067 0.08 0.043],'String','(C,C,C)',...
        'FontSize',12,...
        'FitBoxToText','off',...
        'EdgeColor','none');

    % Create textbox
    annotation('textbox',...
        [0.08 0.54 0.08 0.043],'String','(C,D,D)',...
        'FontSize',12,...
        'FitBoxToText','off',...
        'EdgeColor','none');

    % Create textbox
    annotation('textbox',...
        [0.33 0.54 0.08 0.043],'String','(C,C,C)',...
        'FontSize',12,...
        'FitBoxToText','off',...
        'EdgeColor','none');

    % Create textbox
    annotation('textbox',...
        [0.53 0.067 0.08 0.043],...
        'String','(C,D,D)',...
        'FontSize',12,...
        'FitBoxToText','off',...
        'EdgeColor','none');

    % Create textbox
    annotation('textbox',...
        [0.76 0.067 0.08 0.043],'String','(C,C,C)',...
        'FontSize',12,...
        'FitBoxToText','off',...
        'EdgeColor','none');

    % Create textbox
    annotation('textbox',...
        [0.645 0.425 0.08 0.043],'String','(D,D,D)',...
        'FontSize',12,...
        'FitBoxToText','off',...
        'EdgeColor','none');

    % Create textbox
    annotation('textbox',...
        [0.205 0.425 0.08 0.043],'String','(D,D,D)',...
        'FontSize',12,...
        'FitBoxToText','off',...
        'EdgeColor','none');


    % Create textbox
    annotation('textbox',...
        [0.645 0.898 0.08 0.043],'String','(D,D,D)',...
        'FontSize',12,...
        'FitBoxToText','off',...
        'EdgeColor','none');

    % Create textbox
    annotation('textbox',...
        [0.205 0.898 0.08 0.043],'String','(D,D,D)',...
        'FontSize',12,...
        'FitBoxToText','off',...
        'EdgeColor','none');

end
