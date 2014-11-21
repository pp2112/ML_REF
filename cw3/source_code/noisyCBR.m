function [fmeasure,fmean]=noisyCBR()

[test_x,test_y]=loaddata('noisydata_students.txt');
[train_x,train_y]=loaddata('cleandata_students.txt');

cbr=CBRinit(train_x,train_y);
predicted=testCBR(cbr,test_x);
cm=conf_matrix(test_y', predicted');
[pr,rc]=precision_recall(cm);
fmeasure=fa_measure(pr,rc,1);
fmean=mean(fmeasure);