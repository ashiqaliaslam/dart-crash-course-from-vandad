# Dart Course

## Operators in Dart

Create dart app `dart create -t console operators`

Run fswatch `fswatch -o bin/ | xargs -n1 -I{} sh -c 'clear; dart bin/operators.dart'`

### Simple Integer Operators

```dart
void main(List<String> args) {
  const age1 = 64;
  const age2 = 30;
  print(age1 + age2);
  print(age1 + age2 + 30);
  print(age1 - age2);
  print(age1 * age2);
  print(age1 / age2);
  print(age1 ~/ age2);
}
```

### Unary prefix Operators

```dart
void main(List<String> args) {
  /// 4 types of operators
  /// unary prefix, unary postfix, binary infix, compound assignment

  // unary prefix
  int age = 30;

  print(--age);
  print(++age);

  print(-age);

  print(!true);

  /// unary bitwise completement prefix operator
  print(1);
  print(~1);

  /// (0000 0000) (0000 0000) (0000 0000) (0000 0001)
  /// (1111 1111) (1111 1111) (1111 1111) (1111 1110)
}
```

### Unary Postfix Operators

```dart
void main(List<String> args) {
  // unary postfix operators
  var age = 40;
  print(age--);
  print(age);
  print(age++);
  print(age);
}
```

### Binary infix Operators

```dart
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
```

### Type Promotion in Operators

```dart
void main(List<String> args) {
  const int1 = 1;
  const double1 = 1.0;
  const result = double1 + int1;
  print(result);
}
```

### Compound Assignment Operators

```dart
void main(List<String> args) {
  // print('Hello' + 2);
  var myAge = 20;
  print(myAge); // 20
  print(myAge = 30); // 30
  print(myAge ~/= 2); // 15
  print(myAge *= 2); // 30
  print(myAge += 4); // 34
  print(myAge &= 2); // 2
  /// (0010 0010) 34
  /// &
  /// (0000 0010) 2
  /// (0000 0010) = 2
  print(myAge |= 4); // 6
  print(myAge ^= 10); // 12
  print(myAge -= 10); // 2
}
```
