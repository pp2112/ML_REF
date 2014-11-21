function cbr
[x,y]=loaddata('cleandata_students.txt');
cbr=CBRinit(x,y);
[cm,e]=evaluation(x,y)
[pr,rc]=precision_recall(cm);
fa=fa_measure(1,pr,rc)