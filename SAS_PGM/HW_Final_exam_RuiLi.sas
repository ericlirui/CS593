libname sasdata "C:\Users\Eric\Downloads\SAS_DATA";

proc copy in=sasdata out=work;
  select lung;
run;



 /* Problem 3:
selection=forward
selection=backward
selection=stepwise
selection=maxr*/
title " Multiple Regression Analysis";
proc reg data=lung outest=lung_est ;
     model     Height_oldest_child =    Age_oldest_child Weight_oldest_child 
	 Height_mother Weight_mother Height_father Weight_father
     /   dwProb dw VIF selection=forward;
      OUTPUT OUT=lung_out PREDICTED=P_HOC     RESIDUAL=R_HOC 
         L95M=l95   U95M=U95M  L95=L95  U95=U95 
       rstudent=rstudent h=lev cookd=cookd dffits=dffits
     STDP=STDP  STDR=STDR    ;  
run;
quit;

title " Multiple Regression Analysis";
proc reg data=lung outest=lung_est ;
     model     Height_oldest_child =    Age_oldest_child Weight_oldest_child 
	 Height_mother Weight_mother Height_father Weight_father
     /   dwProb dw VIF selection=backward;
      OUTPUT OUT=lung_out PREDICTED=P_HOC     RESIDUAL=R_HOC 
         L95M=l95   U95M=U95M  L95=L95  U95=U95 
       rstudent=rstudent h=lev cookd=cookd dffits=dffits
     STDP=STDP  STDR=STDR    ;  
run;
quit;

title " Multiple Regression Analysis";
proc reg data=lung outest=lung_est ;
     model     Height_oldest_child =    Age_oldest_child Weight_oldest_child 
	 Height_mother Weight_mother Height_father Weight_father
     /   dwProb dw VIF selection=stepwise;
      OUTPUT OUT=lung_out PREDICTED=P_HOC     RESIDUAL=R_HOC 
         L95M=l95   U95M=U95M  L95=L95  U95=U95 
       rstudent=rstudent h=lev cookd=cookd dffits=dffits
     STDP=STDP  STDR=STDR    ;  
run;
quit;

title " Multiple Regression Analysis";
proc reg data=lung outest=lung_est ;
     model     Height_oldest_child =    Age_oldest_child Weight_oldest_child 
	 Height_mother Weight_mother Height_father Weight_father
     /   dwProb dw VIF selection=MaxR;
      OUTPUT OUT=lung_out PREDICTED=P_HOC     RESIDUAL=R_HOC 
         L95M=l95   U95M=U95M  L95=L95  U95=U95 
       rstudent=rstudent h=lev cookd=cookd dffits=dffits
     STDP=STDP  STDR=STDR    ;  
run;
quit;



/*problem 4

*/

proc copy in=sasdata out=work;
  select heart_attack;
run;

proc logistic data=Heart_attack   descending;
  class	Anger_Treatment(ref='0')
        / param=ref ;
  model  Heart_Attack_2 = Anger_Treatment Anxiety_Treatment;
quit;

* delete the Anger_Treatment from the model ;
proc logistic data=heart_attack;
  model  Heart_Attack_2 =  Anxiety_Treatment;
quit;


/*problem 5
*/
proc copy in=sasdata out=work;
  select breast_cancer_data;
run;
PROC STANDARD 
     DATA=breast_cancer_data   MEAN=0 STD=1 
     OUT= breast_cancer_data_z ;
  VAR radius_mean texture_mean perimeter_mean area_mean smoothness_mean
	compactness_mean concavity_mean concave_points_mean symmetry_mean
	fractal_dimension_mean;
RUN;
proc princomp  data= breast_cancer_data_z  out=pca_breast_cancer_data ;
   VAR radius_mean texture_mean perimeter_mean area_mean smoothness_mean
	compactness_mean concavity_mean concave_points_mean symmetry_mean
	fractal_dimension_mean;
run;

/* problem 6*/

data Arcs;
    infile datalines;
    input Node $ A B C D E F G;
    datalines;
A   0   1   1   0  0  1  0
B   1   0   0   1  0  0  1
C   0   0   0   1  0  1  0
D   0   1   0   0  1  0  0
E   0   0   1   0  0  0  0
F   0   0   0   0  1  0  0
G   0   1   0   0  0  0  0

;
run;



proc sql;
    create table matrix_1 as
        select a/sum(a) as x1
              ,b/sum(b) as x2
              ,c/sum(c) as x3
              ,d/sum(d) as x4
			  ,e/sum(e) as x5
			  ,f/sum(f) as x6
			  ,g/sum(g) as x7
              
        from Arcs
    ;
quit;

data rank_p;
    x1=1/7; 
    x2=1/7;
    x3=1/7;
    x4=1/7;
	x5=1/7;
	x6=1/7;
	x7=1/7;
    output;
run;

proc iml;
    use matrix_1;
    read all var { x1 x2 x3 x4 x5 x6 x7 } into M;
    print M;

    use rank_p;
    read all var { x1 x2 x3 x4 x5 x6 x7 } into rank_p1;
   rank_p = t(rank_p1);
  print rank_p ;

  rank_p2=(M*rank_p);
   print rank_p2 ;

   rank_p3=(M*rank_p2 );
   print rank_p3 ;
   rank_p3b=(M**2)*rank_p;
   print rank_p3b ;

 rank_p50=(M**50)*rank_p;
   print rank_p50 ;

   
   
quit;
