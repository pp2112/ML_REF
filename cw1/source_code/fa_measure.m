function fa=fa_measure(a,pr, rc)
%Calculate the fa measure. In this case a=1 so we calculate the f1 measure.
%The results are returned in a vector
fa=(1+a).*((pr.*rc)./(a.*pr+rc));

end