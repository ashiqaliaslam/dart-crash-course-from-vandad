void main(List<String> args) {
  // binary infix operators
  const age = 50;
  print(age + 20);
  print(age - 20);
  print(age * 20);
  print(age / 20);
  print(age ~/ 20);
  print(age % 20);
  print(age == 20);
  print(age != 20);

  print(age > 20);
  print(age < 20);
  print(age >= 20);
  print(age <= 20);

  // bitwise infix operators
  // 0000 1010 first number
  // 1011 1000 second number
  // 0000 1000 bitwise output for AND
  print(age & 20); // bitwise AND   1&1=1,  0&1=0,  1&0=0,  0&0=0
  print(age | 20); // bitwise OR    1&1=1,  0&1=1,  1&0=1,  0&0=0
  print(age ^ 20); // bitwise XOR   1^1=0,  0^1=1,  1^0=1,  0^0=0

  print(age << 20); // bitwise left shift
  print(age >> 20); // bitwise right shift
  /// 0110 0011
  /// shift left by 1
  /// 1100 0110
}
