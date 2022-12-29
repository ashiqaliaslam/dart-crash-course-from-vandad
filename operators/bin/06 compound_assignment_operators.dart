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
