function [cbr] = CBRinit(examples, targets);
%Get the rows and cols of examples
[rows, cols]=size(examples);

%Iterate through each example and create the vector that consists of only
%the attributes where we have 1.
for i=1:rows
    index=1;
    for j=1:cols
        if examples(i,j)==1
            %Problem vector
            cbr.cases(i).problem(index)=j;
            index=index+1;
        end
        %Also store the full binary problem
        cbr.cases(i).full_problem(j)=examples(i,j);
    end
    %Store the problem vector length
    cbr.cases(i).prob_length=index-1;
    %Store to the solution the corresponding target
    cbr.cases(i).solution=targets(i);
    %Reset the typicality measure for later use
    cbr.cases(i).typicality=0;
end
            