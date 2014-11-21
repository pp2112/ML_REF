function[cbr] = retain(cbr, solvedcase)
%If the case does not exist in the cbr, store it in the end
if ( ~findcase(cbr,solvedcase) )
    index  = size(cbr.cases, 2);
    index=index+1;
    cbr.cases(index).problem = solvedcase.problem;
    cbr.cases(index).full_problem = solvedcase.full_problem;
    cbr.cases(index).solution = solvedcase.solution;
	cbr.cases(index).prob_length= solvedcase.prob_length;
else
    for i=1:size(cbr.cases)
        if isequal(cbr.cases(i).problem,solvedcase.problem)
            cbr.cases(i).typicality=cbr.cases(i).typicality+1;
        end
    end
    
end
