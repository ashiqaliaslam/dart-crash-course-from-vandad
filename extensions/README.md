# Dart Course

## Extensions in Dart

Create dart app `dart create -t console extensions`

Run fswatch
`fswatch -o bin/ | xargs -n1 -I{} sh -c 'clear; dart bin/extensions.dart'`

### Extending String

```dart
void main(List<String> args) {
  final value = 20;
  final timesFour = value.timesFour;
  print(timesFour); // 80
  print(30.timesFour); // 120
}

extension on int {
  // `this` keyword inside the extension returns an instance of that value
  // that your operating on "in this case `this` is 20"
  int get timesFour => this * 4;
}
```

```dart
void main(List<String> args) {
  print('Hello, World!'.reversed);
}

extension on String {
  String get reversed => split('').reversed.join();
}

/// Output
// !dlroW ,olleH
```

### Sum of Iterable

```dart
void main(List<String> args) {
  final sumOfIntegers = [1, 2, 3].sum;
  final sumOfDoubles = [2.2, 3.3, 4.4].sum;

  print(sumOfIntegers); // 6
  print(sumOfDoubles); // 9.6
}

extension SumOfIterable<T extends num> on Iterable<T> {
  T get sum => reduce((a, b) => a + b as T);
}
```

### Range on `int`

```dart
void main(List<String> args) {
  print(1.to(10));
  // [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

  print(1.to(10, inclusive: false));
  // [1, 2, 3, 4, 5, 6, 7, 8, 9]

  print(10.to(1));
  // [10, 9, 8, 7, 6, 5, 4, 3, 2, 1]

  print(10.to(1, inclusive: false));
  // [10, 9, 8, 7, 6, 5, 4, 3, 2]

  print(10.to(10));
  // [10]

  print(10.to(10, inclusive: false));
  // []
}

extension on int {
  Iterable<int> to(int end, {bool inclusive = true}) => end > this
      ? [for (var i = this; i < end; i++) i, if (inclusive) end]
      : [for (var i = this; i > end; i--) i, if (inclusive) end];
}
```

### Finding Duplicate Values in Iterables

```dart
void main(List<String> args) {
  print([1, 2, 3].containsDuplicateValues); // false
  print([1, 2, 3, 1].containsDuplicateValues); // true
  print(['Foo', 'Bar'].containsDuplicateValues); // false
  print(['Foo', 'Bar', 'foo'].containsDuplicateValues); // false
}

extension on Iterable {
  bool get containsDuplicateValues => toSet().length != length;
}
```

### Finding and Mapping Keys and Values on Map

```dart
const json = {
  'name': 'Foo Bar',
  'age': 20,
};
void main(List<String> args) {
  final String? ageAsString =
      json.find<int>('age', (int age) => age.toString());
  print(ageAsString);
  // 20

  final String helloName = json.find('name', (String name) => 'Hello, $name!')!;
  print(helloName);
  // Hello, Foo Bar!

  final String? address =
      json.find('address', (String address) => 'You live at $address');
  print('address = $address');
  // address = null
}

extension Find<K, V, R> on Map<K, V> {
  R? find<T>(K key, R? Function(T value) cast) {
    final value = this[key];
    if (value != null && value is T) {
      return cast(value as T);
    } else {
      return null;
    }
  }
}
```

### Extending Enums

```dart
void main(List<String> args) {
  print(AnimalType.cat.nameContainsUpperCaseLetters); // false
  print(AnimalType.dog.nameContainsUpperCaseLetters); // false
  print(AnimalType.goldFish.nameContainsUpperCaseLetters); // true
}

enum AnimalType { cat, dog, goldFish }

extension on Enum {
  bool get nameContainsUpperCaseLetters => name.contains(
      // `r` for raw string
      RegExp(r'[A-Z]'));
}
```

### Extending Functions

```dart
import 'dart:math' show Random;

void main(List<String> args) {
  print(add.callWithRandomValues());
  // Random values = 73, 75
  // 148

  print(subtract.callWithRandomValues());
  // Random values = 60, 37
  // 23
}

int add(int a, int b) => a + b;
int subtract(int a, int b) => a - b;

typedef IntFunction = int Function(int, int);

extension on IntFunction {
  int callWithRandomValues() {
    final rnd1 = Random().nextInt(100);
    final rnd2 = Random().nextInt(100);
    print('Random values = $rnd1, $rnd2');
    return call(rnd1, rnd2);
  }
}
```

### Extension Overrides

Why do we need names of extensions

```dart
void main(List<String> args) {
  const jack = Person(name: 'Jack', age: 20);

  // print(jack.description); Wrong way gives error
  print(ShortDescription(jack).description);
  // Jack (20)

  print(LongDescription(jack).description);
  // Jack is 20 years old
}

class Person {
  final String name;
  final int age;

  const Person({required this.name, required this.age});
}

// short description of a person
extension ShortDescription on Person {
  String get description => '$name ($age)';
}

// long description of a person
extension LongDescription on Person {
  String get description => '$name is $age years old';
}
```
