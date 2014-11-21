function [cm,avg_error]=evaluation(examples,targets,strategy)

N=10; %N-Cross Validation
c=1;sum=0;
[examples_no, columns]=size(examples);
actual=[];
predicted=[];

%The examples matrix is split test_data and train_data which correspond to
%the 10% and 90% accordingly.
for i=1:examples_no/N:examples_no
    %Compute test data (10 rows)
    test_data=examples(i:i+N-1,:);
    test_targets=targets(i:i+N-1);
    %Compute train data (90 rows)
    train_data=examples;
    train_data(i:i+N-1,:)=[];
    %Compute train target (90 rows)
    train_target=targets;
    train_target(i:i+N-1)=[];
    
    %Retrieve the trees for every emotion
    trees=getTrees(train_data,train_target);
    
    %Returns the vector containing all the predicted values for the
    %specific test data
    y=testTrees(trees,test_data,strategy);
    
    %For every value that is not classified and therefore it returns zero
    %we set it to the value that appears the most in this specific vector.
    y(y==0)=mode(test_targets);
    
    %Create an overall predicted labels vector by concatenating with each y
    %vector returned.
    predicted=[predicted y'];
    %Create an overall actual labels vector by concatenating with each test
    %target vectory
    actual=[actual test_targets'];
    
    %Estimate the error for the current subset by comparing it with the
    %actual label vector
    e(c)=0;
    for j=1:N
        if y(j)~=test_targets(j)
            e(c)=e(c)+1;
        end
    end
    e(c)=e(c)/N;
    
    %Sum up all the 10 errors in order to compute the avg error later
    sum=sum+e(c);
    c=c+1;
end
%Compute the total error and the confusion matrix
avg_error=(1/N)*sum;
cm=conf_matrix(actual, predicted);

end



function [trees]=getTrees(examples, target)
attribs=[1:45]; %Attributes list
%Iterate through all 6 different emotions
for i=1:6
    %Replace targets equal to current emotion with 1 and everything else 
    %with 0.
    emo_target=target;
    emo_target(emo_target~=i)=0;
    emo_target(emo_target==i)=1;
    %Create a decision tree for each emotion and display it.
    [trees(i)]=decision_tree_learning(examples, attribs,emo_target);
end

end
    