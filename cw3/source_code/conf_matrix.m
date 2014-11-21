function cm=conf_matrix(a,p)
%a:Actual Targets
%p:Predicted Targets

distinct_values=6;
cm=zeros(distinct_values);

%Create the confusion matrix
for j=1:length(a)
    cm(a(j),p(j))=cm(a(j),p(j))+1;
end