function found=findcase(cbr,checkcase)
found=0;
%Search all cases in cbr to check if the case alraedy exists
for i=1:size(cbr.cases')
    if isequal(cbr.cases(i).problem,checkcase.problem)
        found=1;
        break;
    end
end

    