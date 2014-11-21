function [fmeasure,fmean]=noisyNN()

[test_x,test_y]=loaddata('noisydata_students.txt');
%[Ptest,Ttest]=ANNdata(test_x,test_y);
[train_x,train_y]=loaddata('cleandata_students.txt');
[Ptrain,Ttrain]=ANNdata(train_x,train_y);

net=getMultiOutputNet(Ptrain,Ttrain);
predicted=testANN(net,test_x',0);
cm=conf_matrix(test_y', predicted');
[pr,rc]=precision_recall(cm);
fmeasure=fa_measure(pr,rc,1)
fmean=mean(fmeasure)

