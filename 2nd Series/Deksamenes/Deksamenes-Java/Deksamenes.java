import java.io.*;
import java.util.Scanner;
import java.io.IOException;

public class Deksamenes {
    public static void main(String[] args) {

        try{
            Scanner scanner = new Scanner(new File(args[0]));
            int N =scanner.nextInt() ;
            int i,height,x,y,z;
            int SumVolume=0;
            rectangular[]  a ;
            a =new rectangular[N];

            int max=0;
            for (i=0; i<N; i++){

                height=scanner.nextInt();
                z=scanner.nextInt();
                if ((height+z)>max) max=height+z;
                y=scanner.nextInt();
                x=scanner.nextInt();
                rectangular var=new rectangular(height,z,y,x);
                a[i]=var;
                SumVolume = SumVolume + x*y*z;
            }

            double goal =scanner.nextInt();

            if (SumVolume < goal) System.out.print("Overflow");
            else {
                double count = ((double )max )/ 2;
                double SumVolume2=0,L_bound=0;
                double  U_bound=(double)max;
                while(Math.abs(L_bound - U_bound )> 0.001) {
                    SumVolume2 = 0;
                    for (i = 0; i < N; i++) {
                        if (count > a[i].GiveHeight()) {
                            if (count > (a[i].GiveHeight() + a[i].GiveZ()))
                                SumVolume2 = SumVolume2 + a[i].GiveZ() * a[i].GiveY() * a[i].GiveX();
                            else SumVolume2 = SumVolume2 + (count - a[i].GiveHeight()) * a[i].GiveY() * a[i].GiveX();
                        }
                        if (SumVolume2 > goal) break;
                    }
                    if (SumVolume2 >= goal) {
                        U_bound = count;
                        count = (L_bound + U_bound) / 2;
                    } else {
                        L_bound = count;
                        count = (L_bound + U_bound) / 2;
                    }
                }
                System.out.format("%.2f" , count);
            }
        }catch (IOException e) {
            e.printStackTrace();
        }
    }
}

