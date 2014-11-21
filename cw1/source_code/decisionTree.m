function tree=decisionTree()

[examples,target]=loaddata('cleandata_students.txt'); %Loads initial data
attribs=[1:45]; %Attributes list

%Iterate through all 6 different emotions
for i=1:6
    %Replace targets equal to current emotion with 1 and everything else 
    %with 0.
    emo_target=target;
    emo_target(emo_target~=i)=0;
    emo_target(emo_target==i)=1;
    %Create a decision tree for each emotion and display it.
    [tree(i)]=decision_tree_learning(examples, attribs,emo_target);
    %DrawDecisionTree(tree(i),sprintf('Decision tree for %s',emolab2str(i)));
end

%Compute 10-fold validation and return the total error and the confusion
%matrix
[ConfusionMatrix,TotalError]=evaluation(examples,target,0)
[Precision,Recall]=precision_recall(ConfusionMatrix)
[F1Measure]=fa_measure(1,Precision,Recall)

end
