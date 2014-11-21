function net=getMultiOutputNet(P,T)

net = feedforwardnet([30 30],'trainscg');
%Use all data for training since we are using 10-Fold Validation for
%Testing
net.divideParam.trainRatio = 0.8;
net.divideParam.valRatio = 0.2;
net = configure(net, P,T); 
net.trainParam.epochs =100;
net.trainParam.lr = 0.05;
net.trainParam.goal = 0.01 ;
net.trainParam.min_grad = 0.01;
net.performFcn = 'msereg';
net.performParam.ratio = 0.5;
net.layers{1}.transferFcn = 'tansig';
[net,tr] = train(net, P, T);
save('net_multi', 'net');