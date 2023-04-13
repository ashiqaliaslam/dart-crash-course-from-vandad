void main(List<String> args) {
  // binary infix operators
  const age = 50;
  print(age + 20); // 70
  print(age - 20); // 30
  print(age * 20); // 1000
  print(age / 20); // 2.5
  print(age ~/ 20); // 2
  print(age % 20); // 10
  print(age == 20); // false
  print(age != 20); // true

  print(age > 20); // true
  print(age < 20); // false
  print(age >= 20); // true
  print(age <= 20); // false

  // bitwise infix operators
  // 0000 1010 first number
  // 1011 1000 second number
  // 0000 1000 bitwise output for AND
  print(age & 20); // bitwise AND   1&1=1,  0&1=0,  1&0=0,  0&0=0
  // Output => 16
  print(age | 20); // bitwise OR    1&1=1,  0&1=1,  1&0=1,  0&0=0

  // Output => 54
  print(age ^ 20); // bitwise XOR   1^1=0,  0^1=1,  1^0=1,  0^0=0

  // Output => 38
  print(age << 20); // bitwise left shift

  // Output => 52428800
  print(age >> 20); // bitwise right shift
  // Output => 0

  /// 0110 0011
  /// shift left by 1
  /// 1100 0110
}
