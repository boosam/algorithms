import java.util.*;
import java.io.*;

public class RandomSearch {
    public static void main(String[] args) {
        int numIterations = Integer.parseInt(args[0]);
        File inputFile = new File(args[1]);
        List<Integer> searchSpace = new ArrayList<Integer>();
        Random rn = new Random();
        int randomIndex = 0;
        int best = Integer.MIN_VALUE;
       
        try {
            Scanner input = new Scanner(inputFile);

            while (input.hasNext()) {
                searchSpace.add(input.nextInt());
            }

            input.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        for (int i = 0; i < numIterations; i++) {
            randomIndex = rn.nextInt(searchSpace.size());

            if (best < searchSpace.get(randomIndex)) {
                best = searchSpace.get(randomIndex);
            }

            System.out.println(randomIndex);
        }

        System.out.println("best result = " + best);
    }

}