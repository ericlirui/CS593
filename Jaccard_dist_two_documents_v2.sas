*-------------------------------------------------------------------------;
* Project        :  Identifying related documents e.g. emails, webpage    ;
* Developer(s)   :  Khasha Dehand                                         ;
* Comments       :  Implementing Jaccard similarity                       ;
*-------------------------------------------------------------------------;
filename doc1 "C:\Users\Eric\Downloads\RAW_DATA\Text_example1.txt"; * ods intro *;
filename doc2 "C:\Users\Eric\Downloads\RAW_DATA\Text_example2.txt"; * ods intro reordered;
filename doc3 "C:\Users\Eric\Downloads\RAW_DATA\Text_example3.txt"; * intro to DS2 **;
filename doc4 "C:\Users\Eric\Downloads\RAW_DATA\Text_example4.txt"; * ods intro without some lines;
filename doc5 "C:\Users\Eric\Downloads\RAW_DATA\MO2008.txt";
filename doc6 "C:\Users\Eric\Downloads\RAW_DATA\MT2016.txt";
filename doc7 "C:\Users\Eric\Downloads\RAW_DATA\DT2016.txt";
options mprint macrogen;




%macro shingle(docno=1);
data shingles_doc&docno.  ;
length shingle5 $5;
keep shingle5;
 
  infile doc&docno. ;
  input @;
  
  ** eliminating the stope words **;
    
    x=' '||upcase(_infile_);
   
    x=transtrn(x,' THIS ','');
    x=transtrn(x,' A ','');
    x=transtrn(x,' THE ','');
    x=transtrn(x,' OF ',''); 
    x=transtrn(x,' AN ','');
    x=transtrn(x,' TO ','');
    x=compbl(translate(x,'','().?),[]'));
    *x=compbl(x);
    ln=length(x);
    do i=1 to (ln-5+1);
     shingle5=substr(x,i,5);
     output;
    end;
run;
proc sort data=shingles_doc&docno. nodupkey;by shingle5;run;
%mend;
%shingle(docno=1);
%shingle(docno=2);
%shingle(docno=3);
%shingle(docno=4);
%shingle(docno=5);
%shingle(docno=6);
%shingle(docno=7);






data character_matrix;
  merge shingles_doc1(in=in1)
        shingles_doc2(in=in2)
        shingles_doc3(in=in3)
        shingles_doc4(in=in4)
        shingles_doc5(in=in5)
        shingles_doc6(in=in6)
		shingles_doc7(in=in7)
  ;
  by shingle5;
  doc1=0;doc2=0;doc3=0;doc4=0;doc5=0;doc6=0;doc7=0;
  doc1=in1;
  doc2=in2;
  doc3=in3;
  doc4=in4;
  doc5=in5;
  doc6=in6;
  doc6=in7;
run;






proc transpose data=character_matrix out=t_character_matrix;
run;

 proc distance data=t_character_matrix   method=djaccard absent=0 out=distjacc;
        var anominal(col1--col1492);  ;
      id _name_  ;
   run;
