function sim = manhattan(case1,case2)
%Return the sum of all differences between the problems of the two cases
%column by column
sim = 0;
for i=1:size(case1.full_problem')
    sim = sim + abs( case2.full_problem(i) - case1.full_problem(i) );
end