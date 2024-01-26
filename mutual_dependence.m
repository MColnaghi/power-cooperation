function md = mutual_dependence(M)

AC = 1/2*(M(1)+M(2)-M(3)-M(4));
PC = 1/2*(M(1)-M(2)+M(3)-M(4));
JC = 1/2*(M(1)-M(2)-M(3)+M(4));

sumSquaresControl = AC.^2 + PC.^2 + JC.^2;

md = (PC.^2 + JC.^2)./sumSquaresControl;