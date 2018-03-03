open IntInf;

fun deksamenes textname=
let 
val input= textname	

fun int_from_stream stream =
  Option.valOf (TextIO.scanStream (IntInf.scan StringCvt.DEC) stream)

val fstream = TextIO.openIn input
val number_of_tanks = int_from_stream fstream	

fun read_weights(file,n) = 
    if n<=0 then []
    else (int_from_stream file)::read_weights(file,n-1)

fun read_elements(file,n) = 
    if n<=0 then []
    else read_weights(fstream,4)::read_elements(file,n-1)
val Weights = read_elements(fstream, number_of_tanks)
val Volume=int_from_stream fstream

fun MakeSingleLists ([] ,n) =[]
   | MakeSingleLists((h::t),n) =List.nth(h,n)::MakeSingleLists(t,n);

val B_array=Array.fromList(MakeSingleLists(Weights,0))
val H_array=Array.fromList(MakeSingleLists(Weights,1))
val W_array=Array.fromList(MakeSingleLists(Weights,2))
val L_array=Array.fromList(MakeSingleLists(Weights,3))
val length=fromInt(Array.length H_array)-1

fun SumVolume(l,acc)=if l>=0 then SumVolume(l-1,acc+Array.sub(H_array,toInt(l))*Array.sub(W_array,toInt(l))*Array.sub(L_array,toInt(l)))
	                                             else acc

fun MaxHeight(l,acc)=if l>=0 then (if Array.sub(H_array,toInt(l))+Array.sub(B_array,toInt(l))>acc then MaxHeight(l-1,Array.sub(H_array,toInt(l))+Array.sub(B_array,toInt(l)))
                                                     else MaxHeight(l-1,acc))
	                                   else acc
fun SumVolume2(a,i)=if  i<=length then 
	                    (if fromInt(round(Real.*(a,1000.0)))>(Array.sub(B_array,toInt(i))*1000) then 
	                    	(if fromInt(round(Real.*(a,1000.0)))>(Array.sub(B_array,toInt(i))*1000)+(Array.sub(H_array,toInt(i))*1000) then
                                 (Array.sub(H_array,toInt(i))*1000)*Array.sub(W_array,toInt(i))*Array.sub(L_array,toInt(i))+SumVolume2(a,i+1)
                             else (fromInt(round(Real.*(a,1000.0)))-(Array.sub(B_array,toInt(i))*1000) )*Array.sub(W_array,toInt(i))*Array.sub(L_array,toInt(i))+SumVolume2(a,i+1) )
	                     else SumVolume2(a,i+1))		
	                else 0

fun final_result x= Real./(real(round(Real.*(x,100.0))),100.0)

fun Binary_Search(Lbound,Ubound)=if Real.>(Real.abs(Real.-(Lbound,Ubound)),0.001) then
	                                   (if SumVolume2(Real./((Real.+(Lbound,Ubound)),2.0),0)>= (Volume*1000) then Binary_Search(Lbound,Real./(Real.+(Ubound,Lbound),2.0))
	                                    else Binary_Search(Real./(Real.+(Ubound,Lbound),2.0),Ubound) )
	                              else final_result (Real./((Real.+(Ubound,Lbound)),2.0)  ) 	

fun final(a,b)= if a<b then (~1.0)
	            else Binary_Search(0.0,real(toInt(MaxHeight(length,0))))
in 
final(SumVolume(length,0),Volume)
end;	