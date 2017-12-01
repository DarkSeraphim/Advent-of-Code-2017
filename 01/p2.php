function test($input, $expected) {
  echo "$input should be $expected, is " . process($input) . "\n";
}

function process($input) {
  $sum = 0;
  $len = strlen($input) / 2;
  for ($i = 0; $i < $len; $i++) {
    if ($input[$i] == $input[$i + $len]) {
      $sum += 2 * intval($input[$i]);
    }
  }
  return $sum;
}

// Validate known test cases
test('1212', '6');
test('1221', '0');
test('123425', '4');
test('123123', '12');
test('12131415', '4');

$input = trim(fgets(STDIN));
echo 'Your output was ' . process($input) . "\n";
