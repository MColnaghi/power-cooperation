function [T,F] = transition_matrix(N,beta,m,u)

a11 = m(1,1);
a12 = m(1,2);
a13 = m(1,3);
a21 = m(2,1);
a22 = m(2,2);
a23 = m(2,3);
a31 = m(3,1);
a32 = m(3,2);
a33 = m(3,3);

num_list = N+1 - (0:(N-1));
T = zeros(sum(num_list)+1);
F = zeros(sum(num_list)+1,3);
%T = sparse([]);
sum_k = 0;

X = 0;
T(1,1) = 1-u;
T(1,2) = u/2;
T(1,N+2) = u/2;


F(1,:) = [0,0,1];

for Y = 1:N % X = 0
    Z =(N-X-Y);
    payoff_CCD = (a21*X + a22*(Y-1) + a23*Z)/(N-1);
    payoff_DDD = (a31*X + a32*Y + a33*(Z-1))/(N-1);
%         f_CCD = 1 -beta +beta*payoff_CCD;
%         f_DDD = 1 -beta +beta*payoff_DDD;
        f_CCD = exp(beta*payoff_CCD);
        f_DDD = exp(beta*payoff_DDD);
        av_fit = (Y*f_CCD + Z*f_DDD);

    i = Y + 1;

        T(i,i - 1)     = (Y/N)*(1/av_fit)*( (1-u)*Z*f_DDD + u/2*(Y*f_CCD));
        T(i,i + 1)     = (Z/N)*(1/av_fit)*( (1-u)*Y*f_CCD + u/2*(Z*f_DDD));
        T(i,i + N-X)   = (Y/N)*(1/av_fit)*( u/2*(Z*f_DDD + Y*f_CCD));
        T(i,i + N-X+1) = (Z/N)*(1/av_fit)*( u/2*(Z*f_DDD + Y*f_CCD));

    T(i,i) = 1 - T(i,i - 1) -T(i,i + 1) - T(i,i + N-X+1) - T(i,i + N-X);
    F(i,:) = [X,Y,Z]/N;
end
sum_k = sum_k + (N-X+1);

for X = 1:N-1
    Y = 0;
    Z =(N-X-Y);
    payoff_CCC = (a11*(X-1) + a12*Y + a13*Z)/(N-1);
    payoff_CCD = (a21*X + a22*(Y-1) + a23*Z)/(N-1);
    payoff_DDD = (a31*X + a32*Y + a33*(Z-1))/(N-1);
%         f_CCC = 1 -beta +beta*payoff_CCC;
%         f_CCD = 1 -beta +beta*payoff_CCD;
%         f_DDD = 1 -beta +beta*payoff_DDD;
        f_CCC = exp(beta*payoff_CCC);
        f_CCD = exp(beta*payoff_CCD);
        f_DDD = exp(beta*payoff_DDD);
        av_fit = (X*f_CCC + Y*f_CCD + Z*f_DDD);

    i = sum_k + 1;

        T(i,i - N-2+X) = (X/N)*(1/av_fit)*( (1-u)*Z*f_DDD + u/2*(X*f_CCC + Y*f_CCD));
        T(i,i - N-1+X) = (X/N)*(1/av_fit)*( u/2*(X*f_CCC + Z*f_DDD));
        T(i,i + 1)     = (Z/N)*(1/av_fit)*( u/2*(X*f_CCC + Z*f_DDD));
        T(i,i + N-X+1) = (Z/N)*(1/av_fit)*( (1-u)*X*f_CCC + u/2*(Z*f_DDD + Y*f_CCD));    
    T(i,i) = 1 -T(i,i - N-1+X) -T(i,i - N-2+X) -T(i,i + 1) - T(i,i + N-X+1);
    F(i,:) = [X,Y,Z]/N;

    for Y = 1:(N-X-1)
        Z =(N-X-Y);
        payoff_CCC = (a11*(X-1) + a12*Y + a13*Z)/(N-1);
        payoff_CCD = (a21*X + a22*(Y-1) + a23*Z)/(N-1);
        payoff_DDD = (a31*X + a32*Y + a33*(Z-1))/(N-1);
%         f_CCC = 1 -beta +beta*payoff_CCC;
%         f_CCD = 1 -beta +beta*payoff_CCD;
%         f_DDD = 1 -beta +beta*payoff_DDD;
        f_CCC = exp(beta*payoff_CCC);
        f_CCD = exp(beta*payoff_CCD);
        f_DDD = exp(beta*payoff_DDD);
        av_fit = (X*f_CCC + Y*f_CCD + Z*f_DDD);

        i = sum_k + Y + 1;
        T(i,i - N-2+X) = (X/N)*(1/av_fit)*( (1-u)*Z*f_DDD + u/2*(X*f_CCC + Y*f_CCD));
        T(i,i - N-1+X) = (X/N)*(1/av_fit)*( (1-u)*Y*f_CCD + u/2*(X*f_CCC + Z*f_DDD));
        T(i,i - 1)     = (Y/N)*(1/av_fit)*( (1-u)*Z*f_DDD + u/2*(X*f_CCC + Y*f_CCD));
        T(i,i + 1)     = (Z/N)*(1/av_fit)*( (1-u)*Y*f_CCD + u/2*(X*f_CCC + Z*f_DDD));
        T(i,i + N-X)   = (Y/N)*(1/av_fit)*( (1-u)*X*f_CCC + u/2*(Z*f_DDD + Y*f_CCD));
        T(i,i + N-X+1) = (Z/N)*(1/av_fit)*( (1-u)*X*f_CCC + u/2*(Z*f_DDD + Y*f_CCD));

        T(i,i) = 1 -T(i,i - N-2+X) -T(i,i - N-1+X) - T(i,i - 1)...
            -T(i,i + 1) - T(i,i + N-X+1) - T(i,i + N-X);

        % (i,i - N-2+X) == (X-1,Y,Z+1)
        % (i,i - N-1+X) == (X-1,Y+1,Z)
        % (i,i-1) == (X,Y-1,Z+1)
        % (i,i+1) == (X,Y+1,Z-1)
        % (i,i + N-X) == (X+1,Y-1,Z)
        % (i,i + N-X+1) == (X+1,Y,Z-1)
    F(i,:) = [X,Y,Z]/N;

    end

    Y = N-X;
    Z =(N-X-Y); %Z=0
    payoff_CCC = (a11*(X-1) + a12*Y + a13*Z)/(N-1);
    payoff_CCD = (a21*X + a22*(Y-1) + a23*Z)/(N-1);
%         f_CCC = 1 -beta +beta*payoff_CCC;
%         f_CCD = 1 -beta +beta*payoff_CCD;
%         f_DDD = 1 -beta +beta*payoff_DDD;
        f_CCC = exp(beta*payoff_CCC);
        f_CCD = exp(beta*payoff_CCD);
        f_DDD = exp(beta*payoff_DDD);
        av_fit = (X*f_CCC + Y*f_CCD + Z*f_DDD);

    i = sum_k + Y + 1;

        T(i,i - N-2+X) = (X/N)*(1/av_fit)*( u/2*(X*f_CCC + Y*f_CCD));
        T(i,i - N-1+X) = (X/N)*(1/av_fit)*( (1-u)*Y*f_CCD + u/2*(X*f_CCC + Z*f_DDD));
        T(i,i - 1)     = (Y/N)*(1/av_fit)*( u/2*(X*f_CCC + Y*f_CCD));
        T(i,i + N-X)   = (Y/N)*(1/av_fit)*( (1-u)*X*f_CCC + u/2*(Z*f_DDD + Y*f_CCD));

    T(i,i) = 1 -T(i,i - N-2+X) -T(i,i - N-1+X) - T(i,i - 1) - T(i,i + N-X);

    sum_k = sum_k + (N-X+1);
    F(i,:) = [X,Y,Z]/N;
end

T(end,end)=1-u;
T(end,end-1)=u/2;
T(end,end-2)=u/2;
F(end,:) = [1,0,0];

end







