function convertedCase=convertToCase(example)
index=1;
%Get the columns of the example
cols=size(example,2);
%Iterate through the attributes to create the problem vector
for i=1:cols
    if example(i)==1
        convertedCase.problem(index)=i;
        index=index+1;
    end
    convertedCase.full_problem(i)=example(i);
    
end
convertedCase.prob_length=size(convertedCase.problem,2);