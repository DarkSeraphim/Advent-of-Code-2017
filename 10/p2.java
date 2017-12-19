import java.util.Scanner;
import java.util.Arrays;
import java.util.List;
import java.util.stream.IntStream;
import java.util.stream.Collectors;

public class Main {

  private static final String SLS = "\u0011\u001f\u0049\u002f\u0017";
  
  private static int fixIndex(int[] numbers, int index) {
    return index % numbers.length;
  }
  
  private static int[] swap(int[] array, int a, int b) {
    int t = array[a];
    array[a] = array[b];
    array[b] = t;
    return array;
  }
  
  public static int[] reverseSingle(int[] numbers, int a, int b) {
    if (a >= b) {
      return numbers;
    }
    return reverseSingle(swap(numbers, a % numbers.length, b % numbers.length), a + 1, b - 1);
  }
  
  public static int[] reverseRange(int[] numbers, int start, int length) {
    return reverseSingle(numbers, start, start + length - 1);
  }
  
  public static int[] round(int[] numbers, int[] input, int start, int skip, int i) {
    if (i >= input.length) {
      return numbers;
    }
    return round(reverseRange(numbers, start, input[i]), input, (start + input[i] + skip) % 256, skip + 1, i + 1);
  }
  
  public static int nextStart(int[] input, int start, int skip) {
    return (start + IntStream.of(input).sum() + IntStream.range(skip, skip + input.length).sum()) % 256;
  }
  
  public static int[] iterate(int[] numbers, int[] input, int start, int skip) {
    return iterate0(numbers, input, start, skip, 0);
  }


  public static int[] iterate0(int[] numbers, int[] input, int start, int skip, int round) {
    if (round >= 64) {
      return numbers;
    }
    return iterate0(round(numbers, input, start, skip, 0), input, nextStart(input, start, skip), skip + input.length, round + 1);
  }
  
  public static int[] fill(int[] array, int index) {
    if (index < array.length) {
      array[index] = index;
      return fill(array, index + 1);
    } else {
      return array;
    }
  }
  
  private static String compressHash(int[] sparseHash, int blockSize) {
    // Blame Java for lacking Arrays.stream(int...args)
    // Although I could technically use copyOfArray, at a cost, or write my own wrapper
    // Haven't done this, to stick to fast n functional
    List<Integer> boxed = IntStream.of(sparseHash).boxed().collect(Collectors.toList());
    return IntStream.range(0, (int) Math.ceil((double) sparseHash.length / blockSize))
      .mapToObj(i -> boxed.subList(i * blockSize, Math.min((i + 1) * blockSize, sparseHash.length)))
      .map(list -> list.stream().reduce(0, (a, b) -> a ^ b))
      .map(num -> String.format("%02x", num))
      .collect(Collectors.joining(""));
  }
  
  private static int[] grabInput() {
    return (new Scanner(System.in).nextLine() + SLS).chars().toArray();
  }
  
  public static void main(String[] args) {
    int[] sparseHash = iterate(fill(new int[256], 0), grabInput(), 0, 0);
    String denseHash = compressHash(sparseHash, 16);
    System.out.println(denseHash);
  }
}
