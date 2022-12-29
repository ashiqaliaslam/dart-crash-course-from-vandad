void main(List<String> args) {
  late final myValue = 10;
  print(myValue);

  late final yourValue = getValue();
  print('We are here');
  print(yourValue);
  print(yourValue);

// OUTPUT

// 10
// We are here
// getValue called
// 10
// 10
}

int getValue() {
  print('getValue called');
  return 10;
}
