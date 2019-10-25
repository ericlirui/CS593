*-------------------------------------------------------------------------;
* Project        : Reg. analysis                          ;
* Developer(s)   : Khasha Dehand                                          ;
* Comments       :   Simpe Reg.                           ;
*                  Homework assignment #2                                           ;
*-------------------------------------------------------------------------;
proc copy in=sasdata out=work;
   select  baseball ;
run;
/* Filter out all batters with fewer than 100
  at bats.Standardize all thenumerical
  variables using z-scores.
*/

data baseball2;
  set baseball;
  if at_bats <100 then delete;
run;
title "Simple Regression Analysis"; 
title2 " Univariate Analysis"; 
proc univariate data= baseball2 normal plot;
  VAR stolen_bases caught_stealing
   ;
run;
proc sgplot data=baseball2    ;
    scatter      x=stolen_bases   y=caught_stealing   ; 
    ellipse       x=stolen_bases   y=caught_stealing   ; 
run;


title " Simple Regression for the cereal dataset rating vs. sugars";
proc reg data=baseball2 outest=baseball_est ;
     model    caught_stealing  = stolen_bases   /   dwProb dw  ;
      OUTPUT OUT=basell_out PREDICTED=P_caught    RESIDUAL=R_caught
         L95M=l95   U95M=U95M  L95=L95  U95=U95 
       rstudent=rstudent h=lev cookd=cookd dffits=dffits
     STDP=STDP  STDR=STDR    ;  
     
  quit;
