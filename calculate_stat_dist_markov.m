%%% matrix: transition matrix, where matrix(i,j) is the transition
%%% probability from state j to state i

function stat_dist = calculate_stat_dist_markov(matrix)

[V,D] = eig(matrix);

eigenvals = round(diag(D),14);

[~,ix] = max(eigenvals);

for k = ix'
    V(:,k) = abs(V(:,k))/sum(abs((V(:,k))));
end

stat_dist = V(:,ix);

end