function [power_asymm,ac1,ac2,pc1,pc2,jc1,jc2] = calculate_power_asymm(mat_1,mat_2,w)

% calculate payoff matrices

r1 = mat_1(1,1)/(1-w);
s1 = mat_1(1,2);
t1 = mat_1(2,1);

r2 = mat_2(1,1)/(1-w);
s2 = mat_2(1,2);
t2 = mat_2(2,1);

% calculate PA

ac1 = 1/2*(r1+s1-t1);
pc1 = 1/2*(r1-s1+t1);
jc1 = 1/2*(r1-s1-t1);

ac2 = 1/2*(r2+s2-t2);
pc2 = 1/2*(r2-s2+t2);
jc2 = 1/2*(r2-s2-t2);

sum_squares1 = ac1.^2 + pc1.^2 + jc1.^2;
sum_squares2 = ac2.^2 + pc2.^2 + jc2.^2;

md1 = (pc1.^2 + jc1.^2)./sum_squares1;
md2 = (pc2.^2 + jc2.^2)./sum_squares2;

power_asymm = md2 - md1;
