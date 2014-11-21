function [decision_tree]=decision_tree_learning(examples,attribs,targets)

%If all the labels are the same return a leafnode with that label
if all(targets==1) || all(targets==0)
    decision_tree=struct('class',targets(1),'kids',[]);
%If the attributes list is empty return a leafnode with that label that
%appears the most in the targets vector.
elseif isempty(attribs)
    decision_tree=struct('class',majority_value(targets),'kids',[]);
else
    %Apply the ID3 algorithm on the data set to compute the attribute that
    %contributes the most for the decision
    best=choose_best_decision_attribute(attribs,examples,targets);
    tree.op=best;
    val=[0,1]; %Distinct values val[1]=0, val[2]=1
    [rows,cols]=size(examples);
    for u=1:2
        k=0;
        examples_new=[];
        targets_new=[];
        for i=1:rows
            %Create a new examples set that holds all the rows from the
            %original examples set where for the attribute(column) that was 
            %chosen as best is equal to values(u) and also create a new 
            %target vector with the corresponding label 
            if examples(i,best)==val(u)
                k=k+1;
                examples_new(k,:)=examples(i,:);
                targets_new(k)=targets(i);
            end
        end
        
        %If the new examples set is empty create a leafnode branch with
        %label the majority value of targets
        if isempty(examples_new)
            branch=struct('class',majority_value(targets),'kids',[]);
        %In the case that the new examples set is not empty then we create
        %an internal node on the tree running the decision tree algorithm
        %with the new inputs.
        else
            attribs(attribs==best)=[];
            branch=decision_tree_learning(examples_new,attribs,targets_new);
        end
        tree.kids{u}=branch;        
    end
    decision_tree=tree;
end