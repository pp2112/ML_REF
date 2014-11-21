function sim = chebyshev(case1,case2)

%Calculate difference column by column of the problems of the two case
%Return the maximum difference
sim = 0;
max_diff = 0;
for i=1:size(case1.full_problem')
    diff = abs( case2.full_problem(i) - case1.full_problem(i) );
    if (diff > max_diff)
        max_diff = diff;
    end
end
sim = max_diff;