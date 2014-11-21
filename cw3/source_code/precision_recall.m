function [pr,rc]=precision_recall(cm)
%This function calculates the precision and recall rates from the confusion
%matrix
for i=1:length(cm)
    
    pr(i)=(cm(i,i)+eps)/(sum(cm(:,i))+eps);
    
    rc(i)=(cm(i,i)+eps)/(sum(cm(i,:))+eps);

end