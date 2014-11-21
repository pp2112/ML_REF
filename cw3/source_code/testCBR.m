function y=testCBR(cbr, examples)

[rows,cols]=size(examples);
for i=1:rows
    convertedCase=convertToCase(examples(i,:));
    [retrieved_case,cbr] = retrieve(cbr, convertedCase);
    solved_case = reuse(retrieved_case, convertedCase);
    cbr = retain(cbr, solved_case);
    y(i) = solved_case.solution;
end