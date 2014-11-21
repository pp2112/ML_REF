function best_attr=choose_best_decision_attribute(attribs,examples,targets)
%Calculate positive and negative labels in the targets vector
pt=length(find(targets==1));
nt=length(find(targets==0));

%For every attribute calculate the positive and negative target for each
%value 0 and 1.
for j=1:length(attribs),
    p1=0;p2=0;n1=0;n2=0;
    e=examples(:,attribs(j));
    %returns the indexes of the cells that equal to 0 or 1.
    e1=find(e==0);
    e2=find(e==1);
    
    %finds if the current value for the attribute is positive or negative
    %regarding to the targets vector and adds it to the appropriate
    %counter.
    for k=1:length(e1),
        if targets(e1(k))==1
            p1=p1+1;
        else
            n1=n1+1;
        end
    end
    
    for k=1:length(e2),
        if targets(e2(k))==1
            p2=p2+1;
        else
            n2=n2+1;
        end
    end
    %REMAINDER Calculation
    rem(j)=(abs((p1+n1))/abs((pt+nt+eps)))*Information(p1,n1)+(abs((p2+n2))/abs((pt+nt+eps)))*Information(p2,n2);
    %GAIN Calculation
    gain(j)=Information(pt,nt) - rem(j);
end

%Initially set the max gain to the gain of the first attribute.
gain_max=gain(1);
best_attr=1;
%Iterate through the gains of all attributes and compute which attribute
%has the maximum gain. 
for j=2:length(attribs),
    if gain(j)>=gain_max
        gain_max=gain(j);
        best_attr=attribs(j);
    end
end

end

%Implements the I() function
function i=Information(p,n)
   i=((-p+eps)/(p+n+eps))*log2((p+eps)/(p+n+eps))-((n+eps)/(p+n+eps))*log2((n+eps)/(p+n+eps));
end

    