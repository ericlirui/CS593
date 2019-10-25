proc copy in = sasdata out = work;
	select vif_example;
run;
proc reg data = vif_example;
	model y = x1 x2;
quit;
proc reg data = vif_example;
	model y = x1 x2 / vif;
quit;

title " Simple Regression for the cereal dataset rating vs. sugars ";
proc reg data= Cereal_ds	outest= est_cereal;
     model     rating = sugars   fiber	shelf	sodium	fat	protein	
				carbo	calories	vitamins / stb vif dwProb dw   ;
      OUTPUT OUT= reg_cerealOUT 
      	h= lev	 cookd= Cookd	 dffits= dffit ;  
     
  quit;

data cereal_ds2;
	set cereal_ds;
	if shelf = 1 then shelf1 = 1;
	else shelf1 = 0;
	if shelf = 2 then shelf2 = 1;
	else shelf2 = 0;
	if shelf = 3 then shelf3 = 1;
	else shelf = 0;
	shelf2_cal = shelf2 * calories;
run;
/*They are high corrlated?*/

proc reg data= Cereal_ds2	outest= est_cereal;
     model     rating = sugars   fiber	shelf1	shelf2	sodium	fat	protein	
				carbo	calories	vitamins /selection = MAXR stb vif dwProb dw   ;
      OUTPUT OUT= reg_cerealOUT 
      	h= lev	 cookd= Cookd	 dffits= dffit ;   
  quit;

/*
selection = foward; // find the most significant varibles step by step
selection = backward; // find the smallest significant baribles step by step
selection = stepwise;// combine the forward and backward
selection = MAXR;//if you want to pick best two valuables, ifyou you want to pick best three valuables, if you want to pick best ...
*/

proc reg data= Cereal_ds2	outest= est_cereal;
     model     rating = sugars   fiber	shelf2	/ stb vif dwProb dw   ;
      OUTPUT OUT= reg_cerealOUT 
      	h= lev	 cookd= Cookd	 dffits= dffit ;  
     
  quit;
