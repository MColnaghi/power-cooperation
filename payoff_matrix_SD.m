function outcome = payoff_matrix_CH(b,c,alpha,x,w)

strategy = {[0,0,0],[0,0,1],[0,1,0],[1,0,0],[0,1,1],[1,0,1],[1,1,0],[1,1,1]};

outcome = zeros(8);

% high_power_interaction = [(alpha*b-c)/(1-w),-c,alpha*b,-1.2*c];
% low_power_interaction = [(b-c)/(1-w),-c,b,-1.2*c];
% symmetric_interaction = 0.5*high_power_interaction + 0.5*low_power_interaction;
% 
% high_power_interaction = [(alpha*b-c/2)/(1-w),alpha*b-c,alpha*b,0];
% low_power_interaction = [(b-c/2)/(1-w),b-c,b,0];
% symmetric_interaction = 0.5*high_power_interaction + 0.5*low_power_interaction;

% high_power_interaction = [w*(alpha*b-c/2),alpha*b-c,alpha*b,0];
% low_power_interaction = [w*(b-c/2),b-c,b,0];
% symmetric_interaction = 0.5*high_power_interaction + 0.5*low_power_interaction;

high_power_interaction = [((1+alpha)*b-c)/(1-w),(1+alpha)*b-2*c,(1+alpha)*b,0];
low_power_interaction = [((1-alpha)*b-c)/(1-w),(1-alpha)*b-2*c,(1-alpha)*b,0];
symmetric_interaction = [(b-c)/(1-w),b-2*c,b,0];

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

end