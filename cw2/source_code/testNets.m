function y=testNets(nets,test_data)
%This function classifies all the examples in the test data using the
%decision trees. 'Strategy' defines which method to follow when an example
%is classified with more than 1 emotion. 
%Strategy=0 -> The label is picked from the decision tree where the class 
%node has the biggest depth.
%Strategy=1 -> The label is picked randomly between the candidates
[test_data_rows,~]=size(test_data);
%Initialise y vector with zeros
y=zeros(10,1);
%Iterate through all the rows of the test data and predict the label using
%the trees.
for i=1:test_data_rows
    found=0;
    candidate=0;
    min_diff=1;
    %Iterate through the 6 decision trees
    for k=1:6
        %Return the classification result for the test data for every
        %emotion
        [label,value]=check_label(test_data(i,:)',nets(k).net);
        if label==1 
            %Counts how many trees return positive result
            found=found+1;
            if abs(1-value)<min_diff
                min_diff=abs(1-value);
                candidate=k;
            end
            %Store the candidates in a vector to choose from randomly
            %candidate(found)=k;
        end
        

    end
    %If the data set was not classified assign it to the label 0.
    y(i)=candidate;
     
end

end

function [label,value]=check_label(example,net)
    value=sim(net,example);
    label=round(value);

end