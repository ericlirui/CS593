

/*HW04_solution
1)	Use logistic regression model to the “IBM Employee Attrition V2”
dataset in CANVAS to uncover the features that can predict employee attrition.
This is a subset of a fictional data set created by IBM data scientists. 
*/

PROC IMPORT OUT= WORK.IBM_attrition 
            DATAFILE= "your folder" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;

/* list of vars:
Age	Attrition	BusinessTravel	DistanceFromHome
Education	EmployeeID	EnvironmentSatisfaction	Gender
MaritalStatus	MonthlyIncome
NumCompaniesWorked	OverTime	TotalWorkingYears
*/
proc logistic data=IBM_attrition   descending;
  class  BusinessTravel (ref='Non-Travel')
          Education(ref='1')
          EnvironmentSatisfaction(ref='1') 
          Gender(ref='Female')
          MaritalStatus(ref='Single')
          NumCompaniesWorked(ref='0')
          OverTime(ref='No')
          / param=ref ;
  model  Attrition = BusinessTravel Age  
         DistanceFromHome Education EnvironmentSatisfaction
         Gender  MaritalStatus  MonthlyIncome NumCompaniesWorked
         TotalWorkingYears;
quit;

* delete the education from the model ;
proc logistic data=IBM_attrition   descending;
  class  BusinessTravel (ref='Non-Travel')
         
          EnvironmentSatisfaction(ref='1') 
          Gender(ref='Female')
          MaritalStatus(ref='Single')
          NumCompaniesWorked(ref='0')
          OverTime(ref='No')
          / param=ref ;
  model  Attrition = BusinessTravel Age  
         DistanceFromHome  EnvironmentSatisfaction
         Gender  MaritalStatus  MonthlyIncome NumCompaniesWorked
         TotalWorkingYears;
quit;

* delete the gender from the model ;
proc logistic data=IBM_attrition   descending;
  class  BusinessTravel (ref='Non-Travel')
         
          EnvironmentSatisfaction(ref='1') 
          
          MaritalStatus(ref='Single')
          NumCompaniesWorked(ref='0')
          OverTime(ref='No')
          / param=ref ;
  model  Attrition = BusinessTravel Age  
         DistanceFromHome  EnvironmentSatisfaction
       MaritalStatus  MonthlyIncome NumCompaniesWorked
         TotalWorkingYears;
quit;

* delete the monthly income from the model ;
proc logistic data=IBM_attrition   descending;
  class  BusinessTravel (ref='Non-Travel')
         
          EnvironmentSatisfaction(ref='1') 
          
          MaritalStatus(ref='Single')
          NumCompaniesWorked(ref='0')
          OverTime(ref='No')
          / param=ref ;
  model  Attrition = BusinessTravel Age  
         DistanceFromHome  EnvironmentSatisfaction
       MaritalStatus   NumCompaniesWorked
         TotalWorkingYears;
quit;
* delete the age from the model ;
proc logistic data=IBM_attrition   descending;
  class  BusinessTravel (ref='Non-Travel')
         
          EnvironmentSatisfaction(ref='1') 
          
          MaritalStatus(ref='Single')
          NumCompaniesWorked(ref='0')
          OverTime(ref='No')
          / param=ref ;
  model  Attrition = BusinessTravel   
         DistanceFromHome  EnvironmentSatisfaction
       MaritalStatus   NumCompaniesWorked
         TotalWorkingYears;
quit;

* Combine the number of the no of companies worke for *;

data IBM_attrition2;
   set IBM_attrition;
   if  NumCompaniesWorked<5 then N_companies=1;
   else if NumCompaniesWorked>7 then N_companies=8;
   else N_companies=NumCompaniesWorked;
run;

proc logistic data=IBM_attrition2   descending;
  class  BusinessTravel (ref='Non-Travel')
         
          EnvironmentSatisfaction(ref='1') 
          
          MaritalStatus(ref='Single')
          N_companies(ref='1')
          OverTime(ref='No')
          / param=ref ;
  model  Attrition = BusinessTravel   
         DistanceFromHome  EnvironmentSatisfaction
       MaritalStatus    N_companies
         TotalWorkingYears;
quit;


data Arcs;
    infile datalines;
    input Node $ A B C D E F G;
    datalines;
A   0   1   0   0  0  0  0
B   1   0   0   1  0  0  1
C   1   0   0   1  0  1  0
D   1   1   0   0  0  0  0
E   0   0   1   0  0  0  0
F   0   0   0   0  1  0  0
G   0   1   0   0  0  0  1

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
