*-------------------------------------------------------------------------;
* Project        : PCA analysis                          ;
* Developer(s)   : Khasha Dehand                                          ;
* Comments       :   Principal Component                            ;
*                  Homework assignment #1                                           ;
*-------------------------------------------------------------------------;
proc copy in=sasdata out=work;
   select  baseball ;
run;
/* Filter out all batters with fewer than 100
  at bats.Standardize all thenumerical
  variables using z-scores.
*/
/* Suppose that we are interested in
    estimating the number of home runs based on the other
      numerical variables in the data set
*/
data baseball2;
  set baseball;
  if at_bats <100 then delete;
run;



PROC STANDARD 
     DATA=Baseball2   MEAN=0 STD=1 
     OUT= Baseball2_z ;
  VAR age games	at_bats	runs hits doubles
      triples		RBIs	walks
      strikeouts	bat_ave
      on_base_pct	slugging_pct
      stolen_bases	caught_stealing
   ;
RUN;
/* Suppose that we are interested in
    estimating the number of home runs based on the other
      numerical variables in the data set
*/
title "Principal Component Analysis"; 
title2 " Univariate Analysis"; 
proc univariate data=Baseball2_z;
  VAR age games	at_bats	runs hits doubles
      triples		RBIs	walks
      strikeouts	bat_ave
      on_base_pct	slugging_pct
      stolen_bases	caught_stealing
   ;
run;
proc princomp   data= Baseball2_z  out=pca_Baseball ;
   VAR age games	at_bats	runs hits doubles
      triples		RBIs	walks
      strikeouts	bat_ave
      on_base_pct	slugging_pct
      stolen_bases	caught_stealing
   ;
run;
proc sgplot data= pca_Baseball  ;
    scatter      x=Prin1   y=homeruns  ; 
    ellipse      x=Prin1   y=homeruns    ;
run;

