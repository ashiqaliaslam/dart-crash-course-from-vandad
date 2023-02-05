# Dart Course

## Functions in Dart

### Anatomy of a Function

```dart
void main(List<String> args) {
  printWow();
}

void printWow() {
  print('Wow');
}

/// Output:

// Wow
```

### Omitting Return Types

```dart
void main(List<String> args) {
  printWow();
}

printWow() {
  print('Wow');
}

/// Output:

// Wow
```

Go to analysis_options.yaml and uncomment the followint linter rule
It is recommended to enable `always_declare_return_types`

```yml
linter:
  rules:
    - camel_case_types

# change this to 
linter:
  rules:
    - always_declare_return_types
```

```dart
void main(List<String> args) {
  printWow();
}

printWow() {
  print('Wow');
}

/// Output
// Wow

// Problem: 

// The function 'printWow' should have a return type but doesn't.
// Try adding a return type to the function.
```

```dart
void main(List<String> args) {
  printWow();
}
// Add `void` as function return type
void printWow() {
  print('Wow');
}

/// Output
// Wow
```

### Dynamic Return Types

```dart
void main(List<String> args) {
  print(doNothing());
}

void doNothing() {}

/// Output:

// Error: This expression has type 'void' and can't be used.
// print(doNothing());
```

```dart
void main(List<String> args) {
  print(doNothing());
}

doNothing() {}

/// Output:

// null
```

```dart
void main(List<String> args) {
  print(doNothing());
}

dynamic doNothing() {}

/// Output:

// null
```

### No Return Types

```dart
void main(List<String> args) {
  greet();
}

void greet() {
  print('Greetings!');
}

/// Output:
// Greetings!
```

```dart
void main(List<String> args) {
  greet();

  // you would never invoke the function and assign
  // the result to a variable
  final void value = greet(); // This should not be done
}

void greet() {
  print('Greetings!');
}
/// Output:
// Greetings!
// Greetings!
```

### Named Parameters

```dart
void main(List<String> args) {
  sayHelloTo();
}

void sayHelloTo(String name) {
  print('Hello, $name');
}

/// Output:
// Error: Too few positional arguments: 1 required, 0 given.
//   sayHelloTo();
//             ^
```

When positional arguments are given

```dart
void main(List<String> args) {
  sayHelloTo('Bob');
}

void sayHelloTo(String name) {
  print('Hello, $name');
}

/// Output:
// Hello, Bob
```

```dart
void main(List<String> args) {
  sayHelloTo();
}

void sayHelloTo({String name}) {
  print('Hello, $name');
}

/// Output:
// Error: The parameter 'name' can't have a value of 'null' because of its type 'String', but the implicit default value is 'null'.
// Try adding either an explicit non-'null' default value or the 'required' modifier.
// void sayHelloTo({String name}) {
//                         ^^^^
```

Either provide optional parameters `{String? name}` or
default parameters `{String name = 'Foo'}`
(NOTE: default values can't pass null)

```dart
void main(List<String> args) {
  sayHelloTo();
  sayHelloTo(name: null);
  sayHelloTo(name: 'Foo');
}

void sayHelloTo({String? name}) {
  print('Hello, $name');
}

/// Output:
// Hello, null
// Hello, null
// Hello, Foo
```

### Default Value for Named Parameters

```dart
void main(List<String> args) {
  describe();
  describe(something: null);
  describe(something: 'Hello, Dart!');
}

void describe({
  String? something = 'Hello, world!',
}) {
  print(something);
}

/// Output:
// Hello, world!
// null
// Hello, Dart!
```

```dart
void main(List<String> args) {
  describe();
  describe(something: null);
  describe(something: 'Hello, Dart!');
}

void describe({
  String something = 'Hello, world!',
}) {
  print(something);
}

/// Output:
// Error: The value 'null' can't be assigned to the parameter type 'String' 
// because 'String' is not nullable.
//   describe(something: null);
//                       ^
```

### Non-Optional Named Parameters with Default Values

```dart
void main(List<String> args) {
  doSomethingWith();
  doSomethingWith(name: 'Foo');
}

void doSomethingWith({
  String name = 'Bar',
}) {
  print('Hello, $name!');
}

/// Output:
// Hello, Bar!
// Hello, Foo!
```

### Required Named Parameters

```dart
void main(List<String> args) {
  // doSomethingWith();   // invalid code
  doSomethingWith(name: 'Foo');
  // doSomethingWith(name: null);   // invalid code
}

void doSomethingWith({required String name}) {
  print('Hello, $name!');
}

/// Output:
// Hello, Foo!
```

### Optionality of Required Named Parameters

```dart
void main(List<String> args) {
  // doSomethingWithAge();  // invalide code
  doSomethingWithAge(age: 42);
  doSomethingWithAge(age: null);
}

void doSomethingWithAge({required int? age}) {
  if (age != null) {
    final in2Years = age + 2;
    print('In 2 years, you will be $in2Years years old.');
  } else {
    print('You did not tell me your age.');
  }
}

/// Output:
// In 2 years, you will be 44 years old.
// You did not tell me your age.
```

### Ordering of Named Parameters

```dart
void main(List<String> args) {
  describePerson();
  describePerson(age: 20);
  describePerson(name: 'Foo');
  describePerson(name: 'Foo', age: 20);
  describePerson(age: 20, name: 'Foo');
}

void describePerson({String? name, int? age}) {
  print('Hello $name, you are $age yours old.');
}

/// Output:
// Hello null, you are null yours old.
// Hello null, you are 20 yours old.
// Hello Foo, you are null yours old.
// Hello Foo, you are 20 yours old.
// Hello Foo, you are 20 yours old.
```

### Positional Parameters

These are always required and can't have default values

```dart
void main(List<String> args) {
  // sayGoodbyeTo();  // invalid code
  // sayGoodbyeTo('Foo');   // invalid code
  sayGoodbyeTo('Foo', 'Bar');
}

void sayGoodbyeTo(String person, String andOtherPerson) {
  print('Goodbye, $person and $andOtherPerson!');
}

/// Output:
// Goodbye, Foo and Bar!
```

```dart
void main(List<String> args) {
  // sayGoodbyeTo(null); // invalid code
  sayGoodbyeTo(null, null);
  sayGoodbyeTo('Foo', 'Bar');
}

void sayGoodbyeTo(String? person, String? andOtherPerson) {
  print('Goodbye, $person and $andOtherPerson!');
}

/// Output:
// Goodbye, null and null!
// Goodbye, Foo and Bar!
```

### Optinoal Positional Parameters

```dart
void main(List<String> args) {
  makeUpperCase();
  makeUpperCase(null);
  makeUpperCase('Foo');
  makeUpperCase('Foo', 'Bar');
  // makeUpperCase('Foo', null);
  makeUpperCase(null, 'Bar');
}

void makeUpperCase([String? name, String lastName = 'Bar']) {
  print(name?.toUpperCase());
  print(lastName.toUpperCase());
}

/// Output:
// null
// BAR
// null
// BAR
// FOO
// BAR
// FOO
// BAR
// null
// BAR
```

### Mixing Various Parameter Styles

```dart
void main(List<String> args) {
  describeFully(); // Not valid code
}

void describeFully(String firstName, {String? lastName = 'Bar'}) {
  print('Hello $firstName $lastName');
}

/// Output:
//   describeFully();
//                ^
// bin/eg.dart:5:6: Context: Found this candidate, but the arguments don't match.
// void describeFully(String firstName, {String? lastName = 'Bar'}) {
//      ^^^^^^^^^^^^^
```

```dart
void main(List<String> args) {
  describeFully('Foo');
  describeFully('Foo', lastName: null);
  describeFully('Foo', lastName: 'Baz');
}

void describeFully(String firstName, {String? lastName = 'Bar'}) {
  print('Hello $firstName $lastName');
}

/// Output:
// Hello Foo Bar
// Hello Foo null
// Hello Foo Baz
```

### The Return Keyword

```dart
void main(List<String> args) {
  print(add());
  print(add(1, 5));
  print(add(3));
  print(add(3, 8));
}

int add([int a = 1, int b = 2]) {
  return a + b;
}

/// Output:
// 3
// 6
// 5
// 11
```

### Functions as First Class Citizens

```dart
void main(List<String> args) {
  print(minus());
}

int minus([lhs = 10, int rhs = 5]) {
  return lhs - rhs;
}

/// Output:
// 5
```

```dart
void main(List<String> args) {
  print(minus());
}

int minus([lhs = 10, int rhs = 5]) => lhs - rhs;

/// Output:
// 5
```

```dart
void main(List<String> args) {
  print(minus());
  print(minus(30, 20));
  print(minus(20, 30));
}

int minus([lhs = 10, int rhs = 5]) => lhs - rhs;
int add([lhs = 10, int rhs = 5]) => lhs + rhs;

/// Output:
// 5
// 10
// -10
```

```dart
void main(List<String> args) {
  print(minus());
  print(minus(30, 20));
  print(minus(20, 30));

  // how to call the function
  print(performOperation(10, 20, (a, b) => a + b));
  print(performOperation(10, 20, (a, b) => a - b));
}

int performOperation(int a, int b, int Function(int, int) operation) =>
    operation(a, b);

int minus([lhs = 10, int rhs = 5]) => lhs - rhs;
int add([lhs = 10, int rhs = 5]) => lhs + rhs;

/// Output:
// 5
// 10
// -10
// 30
// -10
```

```dart
void main(List<String> args) {
  print(minus());
  print(minus(30, 20));
  print(minus(20, 30));

  // because the add() and the minus() are the exact same functions
  print(performOperation(10, 20, add));
  print(performOperation(10, 20, minus));
}

int performOperation(int a, int b, int Function(int, int) operation) =>
    operation(a, b);

int minus([lhs = 10, int rhs = 5]) => lhs - rhs;
int add([lhs = 10, int rhs = 5]) => lhs + rhs;

/// Output:
// 5
// 10
// -10
// 30
// -10
```

### Returning Functions from Functions

```dart
void main(List<String> args) {}

int doSomething(
  int lhs,
  int rhs,
) =>
    lhs + rhs;
```

```dart
void main(List<String> args) {}

int Function() doSomething(
  int lhs,
  int rhs,
) =>
    () => lhs + rhs;
```

```dart
void main(List<String> args) {
  final foo = doSomething(10, 20);
  print(foo()); // treat foo as a function
}

int Function() doSomething(
  int lhs,
  int rhs,
) =>
    () => lhs + rhs;


/// Output:
// 30
```

```dart
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
```

