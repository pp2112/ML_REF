function maj_value=majority_value(targets)
%find() returns all the indexes where the targets vector content is equal
%to a specific value. In our case 0 or 1.
ones=length(find(targets==1));
zeros=length(find(targets==0));
if ones>zeros
    maj_value=1;
else
    maj_value=0;
end