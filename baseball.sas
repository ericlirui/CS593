libname sasdata "C:\Users\Eric\Downloads\SAS_DATA";

proc copy in=sasdata out=work;
	select baseball;
run;

PROC STANDARD 
     DATA=Baseball MEAN=0 STD=1 
     OUT=baseball_z;
  VAR age games at_bats runs hits doubles triples RBIs walks strikeouts bat_ave on_base_pct slugging_pct stolen_bases caught_stealing;
RUN;
proc corr data=baseball_z cov;

run; 
/*principle component*/
proc princomp   data=baseball_z  out=PCA_baseball_z;
VAR age games at_bats runs hits doubles 
triples RBIs walks strikeouts bat_ave
on_base_pct slugging_pct stolen_bases caught_stealing;
run;

proc corr data=PCA_class_z ;
VAR homeruns;
run; 
proc univariate data= PCA_class_z;
var  Prin1;
run;
proc reg data =baseball_z outest = est_Baseball;
	model homeruns = age games at_bats runs hits doubles triples RBIs walks strikeouts bat_ave on_base_pct slugging_pct stolen_bases caught_stealing / stb vif dwProb dw;
	output out=reg_BaseOUT
    h = lev cookd = Cookd dffits = dffit ;
quit;

proc sgplot data=baseball;
	scatter x=stolen_bases y=caught_stealing; 
	ellipse x=stolen_bases y=caught_stealing; 
run;

proc reg data =baseball outest = est_Baseball;
	model caught_stealing = stolen_bases / stb vif dwProb dw;
	output out=reg_BaseOUT
    h = lev cookd = Cookd dffits = dffit ;
quit;

proc corr data=Baseball cov;
var caught_stealing stolen_bases;
run;



proc iml;
use baseball_z;
/*read all var {stolen_bases caught_stealing RBIs W} into class;*/
read all VARIABLES  into class;

close baseball_z ;
print class;
classt=t(class);
print classt;
ss=classt*class;
print ss;
varcovar=(classt*class)*(1/(nrow(class)-1));
print varcovar ;

call eigen(value, vector,varcovar);
print value;
print vector;
quit;

