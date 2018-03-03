#include <stdio.h>
#include <stdlib.h>

void revArray(char *a,int i){ 
  int j,k;
  for(j=0;j<=i/2;j++){
      k=a[j];
      a[j]=a[i-j];
      a[i-j]=k;
  }
}  

void PassValues(char *a,char *b,int i){
   int j;
   for(j=0;j<=i;j++){
      b[j]=a[j];
  }
}

void fileopen (char *a,int *i,char **argv){  
  FILE *f;
  f=fopen(argv[1],"rt");
  if(f==NULL) exit(1);
  a[(*i)]=fgetc(f);
  while(a[(*i)]!= '\n' ){
 	   a[(*i)]=a[(*i)]-48;
 	   (*i)++;
	   a[(*i)]=fgetc(f);
  }
  fclose(f);
  (*i)--;
  revArray (a,*i);
}

void printer(int x,char* a,int i){
	if(x==0) printf("%d",0);
	else{
    int l;
	  for (l=0;l<=i;l++){
	    	a[l]=a[l]+48;
    }
	  a[++i]='\0';
    printf("%s",a);
	}
}

void finder(char* a,int i,int j,int next, int prev,int *result){
	 
   if(j==i-j){
     if(next==1) a[j]--;
     if(a[j]%2!=0) { (*result) =0; return ;}
     if (prev==1) { a[j]=(10+a[j])/2; }
     else a[j]=a[j]/2;	 
   }
   else if (j==i+1-j){
   	  if (next==1) {a[i-j]--;}
   	  if (prev ==0){
	    	  if(a[j]!=a[i-j]) { (*result) =0; return ;}
			    else if (a[j]==0) {a[j]=0; a[i-j]=0;}
          else {
			      a[j]=a[j]-1;
		        a[i-j]=1;
		      }
		  }
		  else{
		  	a[j]--;
		  	if(a[j]!=a[i-j]) { (*result) =0; return ;}
			else {
			    a[j]=1+a[j];
			    a[i-j]=9;
		  	}
	   }		  
   }
   else if (j>i+1-j){
   	      if(a[i-j]==9 && a[j]==0){
              a[j]=8;
		      a[i-j]=1;
		      prev=1;
		      next=0;
		      finder(a,i,j-1,next,prev,result);
		      return;
	      }   
	      else if(a[i-j]==0 && a[j]==9){
              a[j]=8;
		      a[i-j]=1;
		      next=1;
		      prev=0;
		      finder(a,i,j-1,next,prev,result);
		     return;
	      } 
   	       
    	  if(next==1){
    	  	a[i-j]--;
		  }
		  int prev1=0;
		  if(a[j]!=a[i-j] && a[j]!=a[i-j]+1) { (*result) =0; return ; }
          else if((a[j]-a[i-j])==1){
            a[j]--;
            prev1=1;
          }
		  if (prev==0){
            if (a[j]==0){ a[j]=0; a[i-j]=0;}
            else {a[j]=a[j]-1;  a[i-j]=1; }        
		    next=0; 
	      }
		  else if(prev==1){      
           a[j]=9; 
           a[i-j]=a[i-j]+1;
		   next=1;
		  }
    	  finder(a,i,j-1,next,prev1,result);    	

	}
  else { (*result) =0; return ;}

}


int main(int argc,char* argv[]){
 int length=0;
 char a[100010],b[100010];
 fileopen(a,&length,argv);         //opens the file and reads the number
 PassValues(a,b,length);
 int result=1;
 finder (a,length,length,0,0,&result);    //finds if the number n exists and returns it
 if (result==1){
     printer(1,a,length);              //prints the number n if it exists else print "0"
 }
 else if(b[length]==1){
     length--;
     result=1;
     finder (b,length,length,0,1,&result);
     printer(result,b,length); 
 }
 else printer(0,a,length);
 return 0;		
}