
function [rho_A, rho_B] = trans_prob_btw_states(a,b,c,d,N,beta)

k = 1:(N-1);

% f = 1 - beta + beta*(...
%     a*(k-1) + b*(N-k))/(N-1);
% g = 1 - beta + beta*(...
%     c*k + d*(N-k-1))/(N-1);
f = exp(beta*(...
    a*(k-1) + b*(N-k))/(N-1));
g = exp(beta*(...
    c*k + d*(N-k-1))/(N-1));

ratio_A = g./f;
ratio_B = f./g;

p_A = zeros(N-1,1);
p_B = zeros(N-1,1);

p_A(1) = g(1)/f(1);
p_B(1) = f(1)/g(1);

for i = 2:(N-1)
    p_A(i) = p_A(i-1)*ratio_A(i);
    p_B(i) = p_B(i-1)*ratio_B(i);
end

rho_A = 1/((1 + sum(p_A)));
rho_B = 1/((1 + sum(p_B)));

end
