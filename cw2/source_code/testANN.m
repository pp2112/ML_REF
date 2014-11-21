function y = testANN(net, x,whichnet)
%%whichnet=0 : One Multi Output Network
%%whichnet=1 : Six Single Output Networks
if whichnet==0
    out = sim( net, x);
    y=NNout2labels(out);
else
    y=testNets(net, x);
    
end
end