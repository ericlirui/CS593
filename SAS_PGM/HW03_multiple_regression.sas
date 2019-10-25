*-------------------------------------------------------------------------;
* Project        : Regression analysis                          ;
* Developer(s)   : Khasha Dehand                                          ;
* Comments       :   Multiple Regression                            ;
*                  Homework assignment #3                                           ;
*-------------------------------------------------------------------------;
proc copy in=sasdata out=work;
   select  Nutrition;
run;

title1 " Univariate Analysis";  
title2 "  "; 
proc univariate data=Nutrition  normal plot;
   var  	WT_GRAMS	PC_WATER	CALORIES	
       PROTEIN	FAT	SAT_FAT	MONUNSAT	POLUNSAT
       CHOLEST	CARBO	CALCIUM	PHOSPHOR	IRON
       POTASS	SODIUM	VIT_A_IU	VIT_A_RE	
       THIAMIN	RIBOFLAV	NIACIN	ASCORBIC	
       CAL_GRAM	IRN_GRAM	PRO_GRAM	FAT_GRAM 
   ;
run;

title " Multiple Regression Analysis";
proc reg data=Nutrition outest=Nutrition_est ;
     model     CALORIES =   WT_GRAMS	PC_WATER		
       PROTEIN	FAT	SAT_FAT	MONUNSAT	POLUNSAT
       CHOLEST	CARBO	CALCIUM	PHOSPHOR	IRON
       POTASS	SODIUM	VIT_A_IU	VIT_A_RE	
       THIAMIN	RIBOFLAV	NIACIN	ASCORBIC	
       CAL_GRAM	IRN_GRAM	PRO_GRAM	FAT_GRAM 
     /   dwProb dw VIF ;
      OUTPUT OUT=Nutrition_out PREDICTED=P_CALORIES     RESIDUAL=R_CALORIES 
         L95M=l95   U95M=U95M  L95=L95  U95=U95 
       rstudent=rstudent h=lev cookd=cookd dffits=dffits
     STDP=STDP  STDR=STDR    ;  
run;
quit;

 /*
selection=forward
selection=backward
selection=stepwise
selection=MAXR
*/

title " Multiple Regression Analysis";
proc reg data=Nutrition outest=Nutrition_est ;
     model     CALORIES =   WT_GRAMS	PC_WATER		
       PROTEIN	FAT	SAT_FAT	MONUNSAT	POLUNSAT
       CHOLEST	CARBO	CALCIUM	PHOSPHOR	IRON
       POTASS	SODIUM	VIT_A_IU	VIT_A_RE	
       THIAMIN	RIBOFLAV	NIACIN	ASCORBIC	
       CAL_GRAM	IRN_GRAM	PRO_GRAM	FAT_GRAM 
     /   dwProb dw VIF selection=MAXR;
      OUTPUT OUT=Nutrition_out PREDICTED=P_CALORIES     RESIDUAL=R_CALORIES 
         L95M=l95   U95M=U95M  L95=L95  U95=U95 
       rstudent=rstudent h=lev cookd=cookd dffits=dffits
     STDP=STDP  STDR=STDR    ;  
run;
quit;
