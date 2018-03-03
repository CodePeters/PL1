open IntInf;
fun fairpower (l1,l2,n,w,k) = if w>0 andalso (k<=n-1) then (
                                 if  (w mod 3)=1 then fairpower (l1,(k+1)::l2,n,((w-1) div 3),(k+1))                                  
                                 else if ( w mod 3)=2 then fairpower ((k+1)::l1,l2,n,((w+1) div 3),(k+1))  
                                 else fairpower (l1,l2,n,(w div 3),(k+1))
                              )
                              else (List.rev(l1),List.rev(l2));

fun balance n w = if (w > ((pow( 3, n)-1) div 2)) then ([],[])
                 else
                   let 
                        val l1=[]
                        val l2=[]
                   in   
                        fairpower (l1,l2,fromInt n, w, 0)
                   end;