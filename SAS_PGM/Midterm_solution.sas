/*Open the Cereals dataset in SAS and use SAS to perform the following.
a)	We are interested in predicting the rating based on sodium content. Construct the appropriate scatter plot.
b)	Based on the scatter plot, is there strong evidence of a linear relationship between the variables.
c)	Perform the appropriate regression.
d)	Which cereal is an outlier?
e)	What is the typical error in predicting rating based on sodium content?
f)	Interpret the y- intercept.
g)	Is there a significant relationship between the two variables? Why?
h)	What is the meaning of the slope?
i)	Construct a 95% confidence interval for the average nutrition rating  of all cereals with sodium content of 100.
j)	Construct a 95% confidence interval for the nutrition rating for a randomly chosen cereal with sodium content of 100.
*/

proc copy in=sasdata out=work;
  select cereal_ds;
run;

title " Simple Regression for the cereal dataset rating vs. sugars";
proc reg data=cereal_ds  outest=est_cereal ;
     model     rating = sodium    /   dwProb dw  ;
      OUTPUT OUT=reg_cerealOUT  PREDICTED=c_predict   RESIDUAL=c_Res   L95M=c_l95m  U95M=C_u95m  L95=C_l95 U95=C_u95
       rstudent=C_rstudent h=lev cookd=Cookd  dffits=dffit
     STDP=C_s_predicted  STDR=C_s_residual  STUDENT=C_student     ;  
     
  quit;

title  " Simple Regression for the cereal dataset rating vs. sugars";
title2 " Univariate analysis for the reg output dataset ";
  proc univariate data=reg_cerealout;
  *var lev cookd dffit;
  var lev ;
  run;

/*
The forced expiratory volume in one second (FEV1) measurement shows the amount of air a person can forcefully exhale in one second.
  Using the Lung dataset in CANVAS,
  develop a regression model for predicting FEV1 of the father
  using weight and height of the father as predictors.
a)	Is this a good model? Why?
b)	Are the residuals normally distributed? Why?
c)	What are the influential observations? Why?
d)	What are the high leverage observations? Why?
e)	For predicting FEV1 of the father, is height more important than weight? Why?
*/
proc copy in=sasdata out=work;
  select lung;
run;

title " Simple Regression for the FEV1 of the father";
proc reg data=lung   outest=lung_est  ;
     model      FEV1_father = Weight_father Height_Father    /  STB dwProb dw  ;
      OUTPUT OUT=reg_Lung_OUT  PREDICTED=l_predict   RESIDUAL=l_Res   L95M=c_l95m  U95M=C_u95m  L95=C_l95 U95=C_u95
       rstudent=l_rstudent h=lev cookd=Cookd  dffits=dffit
     STDP=l_s_predicted  STDR=l_s_residual  STUDENT=l_student     ;  
     
  quit;

  data lung_missing;
     set lung;
	 if _n_<10;
	 FEV1_father=.;
	 if _n_=9 then do; Weight_father=170;Height_Father=70;end;
  run;

data lung2;
   set lung lung_missing;
run; 

title " Simple Regression for the FEV1 of the father";
proc reg data=lung2   outest=lung_est  ;
     model      FEV1_father = Weight_father Height_Father    /STB   dwProb dw  ;
      OUTPUT OUT=reg_Lung_OUT  PREDICTED=l_predict   RESIDUAL=l_Res   L95M=c_l95m  U95M=C_u95m  L95=C_l95 U95=C_u95
       rstudent=l_rstudent h=lev cookd=Cookd  dffits=dffit
     STDP=l_s_predicted  STDR=l_s_residual  STUDENT=l_student     ;  
     
  quit;


title  " Simple Regression for the cereal dataset rating vs. sugars";
title2 " Univariate analysis for the reg output dataset ";
  proc univariate data=reg_Lung_OUT   normal;
  *var lev cookd dffit; 
  var l_Res;
  run;
/*
The Depression data set in CANVAS shows the result of a study on depression. Factors for predicting depression have been grouped into 20 categories (cat_01 to cat_20).
1)	Normalize the “cat_01” to “cat_20” columns using the z transformation with mean=0 and mean=1.
2)	Perform PCA analysis on the normalized cat_01 to cat_20;
3)	Find the best variables among the top 20 principal components that can predict depression.
*/
proc copy in=sasdata out=work;
  select depression;
run;

PROC STANDARD 
     DATA=depression MEAN=0 STD=1 
     OUT= depression_z;
  VAR  cat_01 - cat_20 ;
RUN;


proc princomp   data=depression_z  out=PCA_depression_z ;
   var  cat_01 - cat_20    ;
run;
