<?php
$data = trim(fgets(STDIN));
function process($input) {
  $sum = 0;
  $len = strlen($input);
  for ($i = 0; $i < $len; $i++) {
    $a = $input[$i];
    $b = $input[($i + 1) % $len];
    if ($a === $b) {
      $sum += intval($a);
    }
  }
  return $sum;
}

echo '1122 should be 3: ' . process('1122') . "\n";
echo '1111 should be 4: ' . process('1111') . "\n";
echo '1234 should be 0: ' . process('1234') . "\n";
echo '91212129 should be 9: ' . process('91212129') . "\n";
echo 'Your output: ' . process($data) . "\n";
?>
