function y=testTrees(trees,test_data,strategy)
%This function classifies all the examples in the test data using the
%decision trees. 'Strategy' defines which method to follow when an example
%is classified with more than 1 emotion. 
%Strategy=0 -> The label is picked from the decision tree where the class 
%node has the biggest depth.
%Strategy=1 -> The label is picked randomly between the candidates
[test_data_rows,test_data_columns]=size(test_data);
%Initialise y vector with zeros
y=zeros(10,1);
%Iterate through all the rows of the test data and predict the label using
%the trees.
for i=1:test_data_rows
    found=0;
    depth=[];
    min_depth=999;
    max_depth=-1;
    candidate=[];
    %Iterate through the 6 decision trees
    for k=1:6
        %Return the classification result for the test data for every
        %emotion
        [res,depth]=check_label(test_data(i,:),trees(k),0);
        if (depth>max_depth)
            max_depth=depth;
            label_max=k;
        end
        if res==1 
            %Counts how many trees return positive result
            found=found+1;
            %Check if the current depth was bigger
            if (min_depth>depth)
                min_depth=depth;
                label_min=k;
            end
            %Store the candidates in a vector to choose from randomly
            candidate(found)=k;
        end
        

    end
    %If the data set was not classified assign it to the label 0.
    if found==0
        y(i)=label_max;
    else
        %If the data set was classified as 1 or more emotions we apply one
        %of the following strategies to pick only one emotion.
        if strategy==0 %Choose the label that was decided in the deepest node
            y(i)=label_min;
        elseif strategy==1 %Choose a random label between the candidates.
            y(i)=candidate(randi(found));
        end
    end
     
end

end

function [label,depth]=check_label(example,tree,dep)
%d=d+1;
%If the node's kids are empty then its a leaf node.
if isempty(tree.kids)
    depth=dep;
    label=tree.class;
%Otherwise we run this function recursively for this trees kid node. 
%This function only terminates when we reach to a leafnode and get its 
%class variable.
else
    attribute=tree.op;
    [label,depth]=check_label(example,tree.kids{example(attribute)+1},dep+1);
end
end