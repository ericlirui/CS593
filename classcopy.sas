libname sasdata "C:\Users\Eric\Downloads\SAS_DATA";

proc copy in=sasdata out=work;
	select cereal_ds;
run;

proc univariate data=cereal_ds;
var rating fiber sugars weight;
run;


title " simple Regression for the cereal dataset rating vs. sugars";

proc reg data=cereal_ds outest=est_cereal;
	/*model rating = sugars/dwProb dw;*/
	model rating = sugars/;
	OUTPUT OUT=reg_cerealOUT
	h=lev cookd=Cookd dffits=dffit
	;
	quit;

title " Multipe Regression for the cereal dataset rating vs. shelf";
proc reg data=cereal_ds;

modle rating = shelf / ;
;
run;


title " Multipe Regression for the cereal dataset rating vs. sugar and fiber";
proc reg data=cereal_ds;

modle rating = sugars fiber / ;
	OUTPUT OUT=reg_cerealOUT
	h=lev cookd=Cookd dffits=dffit
	;
	quit;

