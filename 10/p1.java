import java.util.Scanner;
import java.util.Arrays;

public class Main {
  
  private static int fixIndex(int[] numbers, int index) {
    return index % numbers.length;
  }
  
  public static int[] reverseSingle(int[] numbers, int a, int b) {
    if (a < b) {
      int fa = fixIndex(numbers, a);
      int fb = fixIndex(numbers, b);
      int t = numbers[fa];
      numbers[fa] = numbers[fb];
      numbers[fb] = t;
      return reverseSingle(numbers, a + 1, b - 1);
    }
    return numbers;
  }
  
  public static int[] reverseRange(int[] numbers, int start, int length) {
    return reverseSingle(numbers, start, start + length - 1);
  }
  
  public static int[] iterate(int[] numbers, int[] input, int start, int skip) {
    if (skip < input.length) {
      return iterate(reverseRange(numbers, start, input[skip]), input, (start + input[skip] + skip) % 256, skip + 1);
    } else {
      return numbers;
    }
  }
  
  public static int[] fill(int[] array, int index) {
    if (index < array.length) {
      array[index] = index;
      return fill(array, index + 1);
    } else {
      return array;
    }
  }
  
  public static void main(String[] args) {
    int[] input = Arrays.stream(new Scanner(System.in).nextLine().split(",")).mapToInt(Integer::parseInt).toArray();
    int[] numbers = iterate(fill(new int[256], 0), input, 0, 0);
    
    System.out.println(numbers[0] * numbers[1]);
  }
}
