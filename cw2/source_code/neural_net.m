function neural_net()

[x,y]=loaddata('cleandata_students.txt');
[P,T]=ANNdata(x,y);

%Evaluate the two networks
for i=1:1
    [cm(i),error(i)]=evaluation(x,y,i-1);
    [pr(i),rc(i)]=precision_recall(cm(i));
    fa(i)=fa_measure(1,pr(i), rc(i));
end
%net6=getMultiOutputNet(P,T);
%nets=getSingleOutputNets(P,T);
