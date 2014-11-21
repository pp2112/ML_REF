function sim = euclidean(case1,case2)

%Calculate the euclidian distance
sum=0;
for i=1:size(case1.full_problem,2)
    %Add the differences of the problems of the two cases column by column
    %and raise the difference to the 2nd power
    sum=sum+(case1.full_problem(i)-case2.full_problem(i))^2;
end
%In the end find the square root of the sum and return it
sim=sqrt(sum);