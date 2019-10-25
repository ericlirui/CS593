
*-------------------------------------------------------------------------;
* Project        :   Big data                                      ;
* Developer(s)   :  Khasha Dehand                                         ;
* Comments       :  Matrix Multiplication in big data                          ;
*-------------------------------------------------------------------------;

data Matrix_A ;
  input a1 a2 a3 a4;  
datalines;
11	12	13	14 
21	22	23	24	 
31	32	33	34	 
41	42	43	44	 
;
run;
data Matrix_B;
 input b1 b2;
datalines;
111	112
121	122
131	132
141	142
;
run;


proc iml;
    use  Matrix_A;
    read all var { a1 a2 a3 a4  } into A;
    print A;
    use   Matrix_B;
    read all var { b1 b2  } into B;
    print b;
    C=A*B;
    print C;

quit;
/*
data Matrix_A1 ;
  input a1 a2  ;  
datalines;
11	12	 
21	22	 
31	32	 
41	42	 
;
run;

data Matrix_B1;
 input b1 b2;
datalines;
111	112
121	122
;
run;
Data Matrix_A2;
 input a3 a4  ;  
 datalines;
 13	14 
 23	24	 
 33	34	 
 43	44	 
;
run;

 
data Matrix_B2;
 input b1 b2;
datalines;
131	132
141	142
;
run;
*/







option autosignon=yes;
option sascmd="!sascmd"; 
rsubmit task1 wait=no  sysrputsync=yes;
data Matrix_A1 ;
  input a1 a2  ;  
datalines;
11	12	 
21	22	 
31	32	 
41	42	 
;
run;

data Matrix_B1;
 input b1 b2;
datalines;
111	112
121	122
;
run;

proc iml;
    use  Matrix_A1;
    read all var { a1 a2    } into A1;
    print A1;
    

    use   Matrix_B1;
    read all var { b1 b2  } into B1;
    print B1;
    C1=A1*B1;
	print c1;
create Matrix_c1 from c1[colname={"c1" "c2"}] ; /** create data set **/
append from c1;       /** write data in vectors **/
close Matrix_c1; /** close the data set **/
 quit; 

%sysrput pathtask1=%sysfunc(pathname(work));
endrsubmit;

   RDISPLAY;
  RGET task1;


rsubmit task2 wait=no  sysrputsync=yes;
Data Matrix_A2;
 input a3 a4  ;  
 datalines;
 13	14 
 23	24	 
 33	34	 
 43	44	 
;
run;

 
data Matrix_B2;
 input b1 b2;
datalines;
131	132
141	142
;
run;


 
 proc iml;
    use  Matrix_A2;
    read all var { a3 a4    } into A2;
    print A2; 
     use   Matrix_B2;
    read all var { b1 b2  } into B2;
    print B2;
    
	C2=A2*B2;
     print C2;
	 create Matrix_c2 from C2[colname={"c1" "c2"}] ; /** create data set **/
append from C2;       /** write data in vectors **/
close Matrix_c2; /** close the data set **/
quit;

%sysrput pathtask2=%sysfunc(pathname(work));
endrsubmit;
 RDISPLAY;
 * RGET task2;

LISTTASK _ALL_;

waitfor _all_ task1 task2;
%put &pathtask1;
%put &pathtask2;
*first task;
libname rwork1 slibref=work server=task1; 
*second taks;
libname rwork2 slibref=work server=task2;
 libname lib1_wk "&pathtask1";
 libname  lib2_wk "&pathtask2";

 data Matrix_C1;
   set rwork1.Matrix_C1;
 run;

data Matrix_C2;
   set rwork2.Matrix_C2;
 run;
 proc iml;
  use   Matrix_C1;
    read all var { c1 c2    } into C1;
    print C1;
  use   Matrix_C2;
    read all var { c1 c2    } into C2;
    print C2;
	C=c1+C2;
quit;

signoff task1;
signoff task2;
