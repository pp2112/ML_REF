function [fmeasure,fmean]=noisyDT()

[test_x,test_y]=loaddata('noisydata_students.txt');
[train_x,train_y]=loaddata('cleandata_students.txt');
trees=getTrees(train_x,train_y);
predicted=testTrees(trees,test_x,0);
cm=conf_matrix(test_y, predicted);
[pr,rc]=precision_recall(cm);
fmeasure=fa_measure(pr,rc,1)
fmean=mean(fmeasure)

function [trees]=getTrees(examples, target)
attribs=[1:45]; %Attributes list
%Iterate through all 6 different emotions
for i=1:6
    %Replace targets equal to current emotion with 1 and everything else 
    %with 0.
    emo_target=target;
    emo_target(emo_target~=i)=0;
    emo_target(emo_target==i)=1;
    %Create a decision tree for each emotion and display it.
    [trees(i)]=decision_tree_learning(examples, attribs,emo_target);
end
