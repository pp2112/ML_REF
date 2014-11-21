function [label,depth]=check_label(example,tree,d)
depth=d+1;
%If the node's kids are empty then its a leaf node.
if isempty(tree.kids)
    label=tree.class;
%Otherwise we run this function recursively for this trees kid node. 
%This function only terminates when we reach to a leafnode and get its 
%class variable.
else
    attribute=tree.op;
    [label,depth]=check_label(example,tree.kids{example(attribute)+1},depth);
end
end