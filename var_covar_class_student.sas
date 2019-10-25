*-------------------------------------------------------------------------;
* Project        : PCA analysis                          ;
* Developer(s)   : Khasha Dehand                                          ;
* Comments       :  var_covar_IML                           ;
*                   sashelp.class                                           ;
*-------------------------------------------------------------------------;
title " ";
proc copy in=sashelp out=work;
  select class;
run;

PROC STANDARD
	DATA=class MEAN=0 STD=1
	OUT=class_z; /*nomalized data*/
	VAR Age Height Weight;
run;

proc sgplot data=class_z;
	scatter		x=Height	y=Weight;
	ellipse		x=Height	y=Weight;
run;
proc univariate data=PCA_class_z;
var Prinl Prin2 Prin3;
run;

proc iml;
use Class_z;
read all var {Age Height Weight} into Class;
close Class_z;
print class;
classt=t(class);
print classt;
ss=classt*class;
print ss;
varcovar=(classt*class)*(1/(nrow(class)-1));
print varcovar;

call eigen(value,vector,varcovar);
print value;
print vector;

quit;


