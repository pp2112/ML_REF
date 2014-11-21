function [cm,avg_error]=evaluation(examples,targets)

N=10; %N-Cross Validation

%VARIABLE INITIALISATIONS%
sum=0;
[examples_no, ~]=size(examples);
actual=[];
predicted=[];
currentFold=0;
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
    
    %Initialise the CBR system with the computed train and target sets
    cbr=CBRinit(train_data,train_target);
    %Input the test set into the CBR to classify the label
    y=testCBR(cbr,test_data);
    
    %Create an overall predicted labels vector by concatenating with each y
    %vector returned.
    predicted=[predicted y'];
    %Create an overall actual labels vector by concatenating with each test
    %target vectory
    actual=[actual test_targets'];
    
    %Calculate this fold's confusion matrix, precision and recall
    %in order to display the performance per fold figure.
    cm_per_fold=conf_matrix(test_targets', y');
    %Also display the precision and recall per fold
    [pr,rc]=precision_recall(cm_per_fold)
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
    
    %Sum up all the 10 errors in order to compute the avg error later
    sum=sum+error(currentFold);
end
   
%Display performance(F1Measure) per fold figure
figure;
x_axis=[1:10];
plot(x_axis,fmean,'LineWidth',2,'LineStyle','-');
% Create plot
plot(x_axis,fmean,'MarkerFaceColor',[0 0 1],'Marker','o','LineWidth',2);
xlabel('Folds');
ylabel({'Performance'});
title('F1 Measure Per Fold');
ylim([0.3 1.1]);
%Compute the average total error of all folds and the average 
%confusion matrix
avg_error=(1/N)*sum;
cm=conf_matrix(actual, predicted);
Average_F1=mean(fmean)
end
    