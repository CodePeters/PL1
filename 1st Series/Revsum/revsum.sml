fun readlist (infile : string) = let
  val ins = TextIO.openIn infile
  fun loop ins =
   case TextIO.inputLine ins of
      SOME line => line :: loop ins
    | NONE      => []
in
  loop ins before TextIO.closeIn ins
end ;

fun add48 x =x+48;

fun final3 l i= (if (i+1)=List.length(l) then  implode l
                else  (  let 
                         val x=List.drop(List.rev l,1)
                       in implode (List.rev x ) 
                         end)
                 );                     
                      

fun CHARLIST l =let 
                 val x= map add48 l    
                in 
                 map chr x
                 end;                  

fun arrayToList arr = Array.foldr (op ::) [] arr;

fun final2 (arr,x,i) =if x=0 then "0"

                             else (
                             let 
                               val x= CHARLIST (arrayToList arr)
                             in 
                               final3 x (i-1)
                             end );       
     
     

fun finder arr i j next prev = (if  j=(i-j) then(
                                    
                                        if next =1 then  Array.update(arr,j,(Array.sub(arr,j)-1))                                                                               
                                        else  Array.update(arr,j,Array.sub(arr,j));                                         
                                        if (Array.sub(arr,j) mod 2) =0 then(
                                           if prev =1 then (
                                             Array.update(arr,j,((10+Array.sub(arr,j)) div 2));
                                              (arr,1,i) )                                             
                                           else (
                                             Array.update(arr,j,(Array.sub(arr,j) div 2));
                                             (arr,1,i) )                                   
                                        )else (arr,0,i)

                                )else if  j=(i+1-j) then (

                                        if next =1 then  Array.update(arr,(i-j),(Array.sub(arr,(i-j))-1))                                        
                                        else  Array.update(arr,j,Array.sub(arr,j));   
                                        if prev=0 then (
                                           if (Array.sub(arr,(i-j))-Array.sub(arr,j))=0 then(
                                              if Array.sub(arr,j)=0 then ( Array.update(arr,j,0);
                                                                      Array.update(arr,(i-j),0);
                                                                      (arr,1,i)

                                              )else ( Array.update(arr,j,(Array.sub(arr,j)-1));
                                                      Array.update(arr,(i-j),1);
                                                      (arr,1,i))
                                           )else  (arr,0,i)                                       
                                        )else(
                                            if (Array.sub(arr,j)-1)=Array.sub(arr,(i-j)) then(
                                               Array.update(arr,(i-j),9);
                                               (arr,1,i)
                                            )else (arr,0,i)
                                        )
                                )else if (j>i+1-j) then (
                                            if Array.sub(arr,j)=0 andalso Array.sub(arr,(i-j))=9 then (
                                                Array.update(arr,j,8);
                                                Array.update(arr,(i-j),1);
                                                finder arr i (j-1) 0 1
                                            )else if Array.sub(arr,j)=9 andalso Array.sub(arr,(i-j))=0 then(
                                                Array.update(arr,j,8);
                                                Array.update(arr,(i-j),1);
                                                finder arr i (j-1) 1 0
                                            )else( 
                                                if next=1  then Array.update(arr,(i-j),(Array.sub(arr,(i-j))-1))
                                                else Array.update(arr,(i-j),Array.sub(arr,(i-j)));
                                                if (Array.sub(arr,j)-Array.sub(arr,(i-j)))<>1 andalso Array.sub(arr,j)<>Array.sub(arr,(i-j)) then (arr,0,i)
                                                                                                  
                                                else if (Array.sub(arr,j)-Array.sub(arr,(i-j)))=1 then (
                                                      if prev=0 then (
                                                          if (Array.sub(arr,j)-1)=0 then(
                                                              Array.update(arr,(i-j),0);
                                                              Array.update(arr,j,0)                                                            
                                                          )else (
                                                              Array.update(arr,j,(Array.sub(arr,j)-2));
                                                              Array.update(arr,(i-j),1) 
                                                          );

                                                          finder arr i (j-1) 0 1
                                                                                                                       
                                                      )else (
                                                              Array.update(arr,(i-j),(Array.sub(arr,(i-j))+1));
                                                              Array.update(arr,j,9);
                                                              finder arr i (j-1) 1 1
                                                            )
                                                        
                                                )else(
                                                      if prev=0 then (
                                                          if (Array.sub(arr,j))=0 then(
                                                              Array.update(arr,(i-j),0);
                                                              Array.update(arr,j,0)                                                             
                                                          )else (
                                                              Array.update(arr,j,(Array.sub(arr,j)-1));
                                                              Array.update(arr,(i-j),1) 
                                                          );

                                                          finder arr i (j-1) 0 0
                                                                                                                       
                                                      )else (
                                                              Array.update(arr,(i-j),(Array.sub(arr,(i-j))+1));
                                                              Array.update(arr,j,9);
                                                              finder arr i (j-1) 1 0
                                                            ) 
                                                )
                                            )
                               )else (arr,0,i)
                              );    
 
    

fun final (arr,z,i) arr2 =if z=0 then ( 
                                        if Array.sub(arr2,((Array.length arr2)-1))=1 then 
                                          let 
                                           val (arr2,x,i)=finder arr2  ((Array.length arr2)-2)  ((Array.length arr2)-2)  0 1 
                                          in
                                           final2 (arr2,x,i)
                                          end 
                                         else "0" )                                                                              
                          else (
                             let 
                               val x= CHARLIST (arrayToList arr)
                             in 
                               final3 x i
                          end );   


fun Arr1 l = Array.fromList l;

fun f c = ord (c) -48 ;

fun numbers l = 
     let
        val x=List.drop (List.rev l,1 )
       in 
           map f x
     end;

fun a3 s = numbers (explode s);
            
fun a2 l = a3(hd l);                    

fun a1 s = a2(readlist s ) ;

fun revsum  s =
  let 
     val y=Arr1( a1 s )
     val arr2=Arr1( a1 s )
    in (
     let 
       val (arr1,z,i)=finder y  ((Array.length y)-1)  ((Array.length y)-1)  0 0 
     in
       final (arr1,z,i) arr2
     end
  )end;     