function nets=getSingleOutputNets(P, T)

for i=1:6
    Tnew=T(i,:);
    net = feedforwardnet([30 30],'trainscg');
    net.divideParam.trainRatio = 1;
    net.divideParam.valRatio = 0;
    net.divideParam.testRatio = 0.0;
    net = configure(net, P, Tnew); 
    net.trainParam.epochs =100;
    net.trainParam.lr = 0.05;
    net.trainParam.goal = 0.01 ;
    net.trainParam.min_grad = 0.01;
    net.layers{1}.transferFcn = 'tansig';
    net.performFcn = 'msereg';
    net.performParam.ratio = 0.5;
    nets(i).net = train(net, P, Tnew);
end