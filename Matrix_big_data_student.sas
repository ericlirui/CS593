*-------------------------------------------------------------------------;
* Project        :   Big data                                      ;
* Developer(s)   :  Khasha Dehand                                         ;
* Comments       :  Matrix Multiplication in big data studnet version   ;
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
