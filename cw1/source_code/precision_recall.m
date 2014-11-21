function [pr,rc]=precision_recall(cm)

for i=1:length(cm)
    
    pr(i)=cm(i,i)/sum(cm(:,i));
    
    rc(i)=cm(i,i)/sum(cm(i,:));

end