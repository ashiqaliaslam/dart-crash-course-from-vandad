void main(List<String> args) {
  /// 4 types of operators
  /// unary prefix, unary postfix, binary infix, compound assignment

  // unary prefix
  int age = 30;

  print(--age); // 29
  print(++age); // 30

  print(-age); // -30

  print(!true); // false

  /// unary bitwise completement prefix operator
  print(1); // 1
  print(~1); // -2

  /// (0000 0000) (0000 0000) (0000 0000) (0000 0001)
  /// (1111 1111) (1111 1111) (1111 1111) (1111 1110)
}
