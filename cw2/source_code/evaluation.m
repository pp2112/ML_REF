function [cm,avg_error]=evaluation(examples,targets,whichnet)
%%whichnet=0 : One Multi Output Network
%%whichnet=1 : Six Single Output Networks

N=10; %N-Cross Validation

%VARIABLE INITIALISATIONS%
sum=0;
[examples_no, ~]=size(examples);
actual=[];
predicted=[];
currentFold=0;
error_min=1;
%The examples matrix is split test_data and train_data which correspond to
%the 10% and 90% accordingly.
for i=1:examples_no/N:examples_no
    currentFold=currentFold+1;
    %Compute test data (10 rows)
    test_data=examples(i:i+N-1,:);
    test_targets=targets(i:i+N-1);
    %Compute train data (90 rows)
    train_data=examples;
    train_data(i:i+N-1,:)=[];
    %Compute train target (90 rows)
    train_target=targets;
    train_target(i:i+N-1)=[];
    
    %Retrieve the nets for every emotion
    [P,T]=ANNdata(train_data,train_target);
    
    if whichnet==0
        %Calls the function that returns the trained mutli output network
        net=getMultiOutputNet(P,T);
        %Returns the vector containing all the predicted values for the
        %specific test data        
        y=testANN(net,test_data',whichnet);
    else
        %Calls the function that returns the trained six single output
        %networks
        nets=getSingleOutputNets(P,T);
        %Returns the vector containing all the predicted values for the
        %specific test data
        y=testANN(nets,test_data,whichnet);
    end

    %For every value that is not classified and therefore it returns zero
    %we set it to the value that appears the most in this specific vector.
    y(y==0)=mode(test_targets);
    
    %Create an overall predicted labels vector by concatenating with each y
    %vector returned.
    predicted=[predicted y'];
    %Create an overall actual labels vector by concatenating with each test
    %target vectory
    actual=[actual test_targets'];
    
    %Calculate this fold's confusion matrix, precision and recall
    %in order to display the performance per fold figure.
    cm_per_fold=conf_matrix(test_targets', y');
    [pr,rc]=precision_recall(cm_per_fold);
    f=fa_measure(1,pr,rc);
    %Calcuate the mean f1 measure for this fold
    fmean(currentFold)=mean(f);
    
    %Estimate the error for the current subset by comparing it with the
    %actual label vector
    error(currentFold)=0;
    for j=1:N
        if y(j)~=test_targets(j)
            error(currentFold)=error(currentFold)+1;
        end
    end
    error(currentFold)=error(currentFold)/N;
    
    %Find out the tree with the minimum error in order to return the
    %optimal single-output nets for saving
    if whichnet==1
        if error_min>error(currentFold)
            error_min=error(currentFold);
            optimalnet=nets;
        end
    end
    
    %Sum up all the 10 errors in order to compute the avg error later
    sum=sum+error(currentFold);
end
   
%Display performance(F1Measure) per fold figure
figure;
x_axis=[1:10];
%plot(x_axis,fmean,'LineWidth',2,'LineStyle','-');
% Create plot
plot(x_axis,fmean,'MarkerFaceColor',[0 0 1],'Marker','o','LineWidth',2);
xlabel('Folds');
ylabel({'Average Error'});
title('F1 Measure Per Fold (Single Multi-Output Network)');
ylim([0.3 1.1]);
%Compute the average total error of all folds and the average 
%confusion matrix
avg_error=(1/N)*sum;
cm=conf_matrix(actual, predicted);

end
    