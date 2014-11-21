function[closer_case,newcbr] = retrieve(cbr,newcase);
index=1;
bestcase=0;
min=1000;

for i=1:size(cbr.cases,2)
    %Apply the similarity function
    distance=euclidean(cbr.cases(i),newcase);
    if distance==min
        %Found a case with the same distance as min. Store it in the
        %min_cases vector
        min_cases(index)=i;
        index=index+1;
    elseif distance<min
        %Found new case with smaller distance. Reset the min_cases vector
        %with only the current case found and also store the cases that
        %have the same min distance.
        min_cases=[i];
        %Reset the counter
        index=1;
        %Set new min distance
        min=distance;
        %Store best case for later use
        bestcase=i;
    end
end

max_typicality=-1;
index=1;
%Vector that stores the cases with the max typicality. There are times
%where one or more cases will also have the same typicality and then
%choosing the best case is done randomly amongs those cases.
same_typicality=[];
if size(min_cases,2)>1
    for i=1:size(min_cases,2)
        case_i=min_cases(i);
        if cbr.cases(case_i).typicality>=max_typicality
            bestcase=case_i;
            max_typicality=cbr.cases(case_i).typicality;
            same_typicality(index)=case_i;
            index=index+1;
        end
    end
end

min_vsize_diff=100;
%If cases that where found with the same similarity, also have the same
%typicality then we choose the one that has the smaller difference in length.
if size(same_typicality,2)>1
    for i=1:size(same_typicality,2)
        case_i=same_typicality(i);
        vsize_diff=abs(cbr.cases(case_i).prob_length-newcase.prob_length);
        if vsize_diff<=min_vsize_diff
            min_vsize_diff=vsize_diff;
            bestcase=case_i;
        end
    end
end

closer_case=cbr.cases(bestcase);
%Increase the typicality of the chose best case
cbr.cases(bestcase).typicality=cbr.cases(bestcase).typicality+1;
%Return the updated CBR
newcbr=cbr;