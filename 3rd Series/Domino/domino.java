import java.io.*;
import java.util.Scanner;
import java.io.IOException;

public class Domino {

    public static void main(String[] args) {

        try{
            int grid [][]=new int[7][8];
            int tested[][]=new int[7][8];
            int check[][]=new  int[7][8];

            Scanner scanner = new Scanner(new File("1.txt"));

            for (int i=0; i<7; i++) {
                for (int j = 0; j < 8; j++){
                    grid[i][j] = scanner.nextInt();

                }
            }
            count=0;

            Domino(0,0,tested,check,grid);
            System.out.print(""+count);

        }catch (IOException e) {
            e.printStackTrace();
        }
    }

 static int count;

 public static void Domino(int i,int j,int [][] tested,int[][] check,int[][] grid) {
     if (j == 8) {
         j = 0;
         i++;
     }
     if (i == 7) count++;
     else {
         if (tested[i][j] == 1) {
             Domino(i, j + 1, tested, check, grid);
         }
         else {

             tested[i][j] = 1;

             if (i <= 5 && tested[i + 1][j] == 0 && check[grid[i][j]][grid[i + 1][j]] == 0) {
                 SetGet(grid,check,tested,i,j,1,0,1);
                 Domino(i, j + 1, tested, check, grid);
                 SetGet(grid,check,tested,i,j,1,0,0);
             }
             if (j <= 6 && tested[i][j + 1] == 0 && check[grid[i][j]][grid[i][j + 1]] == 0) {

                 SetGet(grid,check,tested,i,j,0,1,1);
                 Domino(i, j + 1, tested, check, grid);
                 SetGet(grid,check,tested,i,j,0,1,0);
             }

             tested[i][j] = 0;
         }
     }
 }

    public static void SetGet(int[][] grid,int[][] check,int[][] tested,int i,int j,int m,int n,int z){
        check[grid[i][j]][grid[i+m][j + n]] = check[grid[i+m][j + n]][grid[i][j]] = z;
        tested[i+m][j + n] = z;
    }
}
