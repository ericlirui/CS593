*-------------------------------------------------------------------------;
* Project        : PCA analysis                          ;
* Developer(s)   : Khasha Dehand                                          ;
* Comments       :  var_covar_IML                           ;
*                   sashelp.class                                           ;
*-------------------------------------------------------------------------;

proc copy in=sashelp out=work;
  select class;
run;
PROC STANDARD 
     DATA=class MEAN=0 STD=1 
     OUT=class_z;
  VAR Age Height Weight  ;
RUN;

proc corr data=class_z cov;
 var Age Height Weight;
run; 
/* height = .35713 age + .61319 weight*/
proc reg data=class_z;
model height =age weight;
run;

proc iml;
use class_z;
read all var {age weight} into x;
print x;
use class_z;
read all var { height } into y;
print y;
b=inv(t(x)*x)*t(x)*y;
print b;





proc sgplot data=class_z  ;
    scatter     x=Height  y=Weight ; 
    ellipse     x=Height  y=Weight ; 
run;

proc univariate data=class_z;
  var Age Height Weight   ;
run;

proc princomp   data=class_z  out=PCA_class_z;
   var  Age Height Weight   ;
run;

proc corr data=PCA_class_z ;
 var Prin1 Prin2 Prin3;
run; 
proc univariate data= PCA_class_z;
  var  Prin1 Prin2 Prin3   ;
run;

proc iml;
use class_z;
read all var {Age Height Weight} into class;
close class_z ;
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

