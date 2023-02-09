void main(List<String> args) {
  print(doSomething(10, 20)()); // can be call the function immediately
}

int Function() doSomething(
  int lhs,
  int rhs,
) =>
    () => lhs + rhs;


/// Output:
// 30