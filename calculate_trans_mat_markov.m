%%
function trans_mat = calculate_trans_mat_markov(b,c,alpha,x,w,N,str_selection)

strategy = {[0,0,0],[0,0,1],[0,1,0],[1,0,0],[0,1,1],[1,0,1],[1,1,0],[1,1,1]};

outcome = zeros(8);

symmetric_interaction =  [           (b-c)/(1-w), -c,           b, 0];
high_power_interaction = [ ((1+alpha)*b-c)/(1-w), -c, (1+alpha)*b, 0];
low_power_interaction  = [ ((1-alpha)*b-c)/(1-w), -c, (1-alpha)*b, 0];

for i = 1:8
    for j = 1:8
        a1 = [0,0,0];
        
        for k = 1:3
            if k==1
                k2 = 1;
            elseif k==2
                k2 = 3;
            elseif k==3
                k2 = 2;
            end
            
            if strategy{i}(k) == 0 && strategy{j}(k2) == 0 % mutual cooperation
                a1(k) = 1;
            end
            if strategy{i}(k) == 0 && strategy{j}(k2) == 1 % sucker's payoff
                a1(k) = 2;
            end
            if strategy{i}(k) == 1 && strategy{j}(k2) == 0 % temptation to defect
                a1(k) = 3;
            end
            if strategy{i}(k) == 1 && strategy{j}(k2) == 1 % mutual defection
                a1(k) = 4;
            end
        end
        
        outcome(i,j) = 0.5*symmetric_interaction(a1(1)) +...
            0.25*high_power_interaction(a1(2)) + 0.25*low_power_interaction(a1(3));
        
    end
end

trans_mat = zeros(8);

for i = 1:8
    for j = i:8
        if i==j
            continue
        end
        
        a1 = outcome(i,i);
        b1 = outcome(i,j);
        c1 = outcome(j,i);
        d1 = outcome(j,j);
        
        [rho_A, rho_B] = trans_prob_btw_states(a1,b1,c1,d1,N,str_selection);
        
        trans_mat(i,j) = rho_A/8;
        trans_mat(j,i) = rho_B/8;
        
    end
end

for i = 1:8
    trans_mat(i,i) = 1-sum(trans_mat(:,i));
end

end