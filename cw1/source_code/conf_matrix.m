function cm=conf_matrix(a,p)
distinct_values=length(unique(a));
cm=zeros(distinct_values);
%Create the confusion matrix
for j=1:length(a)
    cm(a(j),p(j))=cm(a(j),p(j))+1;
end