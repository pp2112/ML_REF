function[solvedcase] = reuse(bestcase,newcase)
%Assign the solution of the returned best case as the solution of the case
%that we are currently checking
newcase.solution=bestcase.solution;
%Return the solved case
solvedcase=newcase;