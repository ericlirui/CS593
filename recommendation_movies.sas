


data rating;
input viewer $	Movie1	Movie2	Movie3	Movie4	Movie5	Movie6	Movie7;
datalines;
A	4	0	0	5	1	0	0
B	5	5	4	0	0	0	0
C	0	0	0	2	4	5	0
D	0	3	0	0	0	0	3
;
run;

data rating2;
  set rating;
   array Movies movie1 - movie7;
   array Adj_Movies Adj_movie1 - Adj_movie7;
   * array norm_ratings   norm_rating1- norm_rating7;
  cnt=0; total=0;;
  do i=1 to  7;
      if Movies[i]>0 then do;
	    total=total+Movies[i];
		cnt=cnt+1;
		
      end;	
  end;
 
  do i=1 to 7;      
     if Movies[i]>0 then do;
     avg=total/cnt;
	 Adj_Movies[i]=Movies[i]-avg;
	end;
     else Adj_Movies[i]=0;    
  end;
 
run;

proc iml;
    use  rating2;
    read all var { Adj_movie1 Adj_movie2 Adj_movie3  Adj_movie4 Adj_movie5
	                   Adj_movie6   Adj_movie7   } into Adj_rating;
    print  Adj_rating;
    norm = sqrt( Adj_rating[ ,##]); 
	print norm;
    
	norm_adj_rating=Adj_rating/norm;
    print norm_adj_rating;
    do i = 1 to  4;     
      do j = 1 to 7;
      if  norm_adj_rating[i,j] = . then norm_adj_rating[i,j]=0;      
     end;
    end;
    print norm_adj_rating;
	 
    recommendation= norm_adj_rating*  norm_adj_rating`; 
    print  recommendation;
   
quit;
