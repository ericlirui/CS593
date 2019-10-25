libname sasdata "C:\Users\Eric\Downloads\SAS_DATA";

proc copy in=sasdata out=work;
	select churn;
run;


data churn2;
  set churn;
  if churn="False." then V_churn=0;
  else V_churn=1;
  if VMail_Plan='yes' then v_voiceplan=1;
  else v_voiceplan=0;

  /*  let 0-1  v_csc=0
  2,3 		 v_csc=1
  4 or more  v_csc=2*/
  if CustServ_Calls <4 and CustServ_Calls>1 then V_CSCtemp1=1;
  else V_CSCtemp1=0;
  if CustServ_Calls >=4 then V_CSCtemp2=1;
  else V_CSCtemp2=0;


  run;

  proc freq data= churn2;
  tables v_churn*V_voiceplan;
  run;
/*descending means prefer voice plan 1 not 0.*/
proc logistic data=churn2 descending;
  class V_CSCtemp1(ref='0') V_CSCtemp2(ref='0')/param=ref;
  model V_churn=V_CSCtemp1 V_CSCtemp2;
  quit;

proc logistic data=churn2 descending;
  class V_CSC2(ref='0')/param=ref;
  model V_churn=V_CSC2;
  quit;
