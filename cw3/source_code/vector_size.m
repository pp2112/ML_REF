function sim = vector_size(case1,case2)

%Calculate the absolute difference of the vector sizes of the two cases
sim = abs(size(case1.problem') - size(case2.problem'));