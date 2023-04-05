# Dart Course

## Colletions in Dart

Create dart app `dart create -t console controlflow`

Run fswatch `fswatch -o bin/ | xargs -n1 -I{} sh -c 'clear; dart bin/collections.dart'`

### Lists

```dart
void main(List<String> args) {
  const names = ['Foo', 'Bar', 'Baz', "Qux"];

  for (final name in names) {
    print(name);
  }

/// Output:
// Foo
// Bar
// Baz
// Qux

  for (final name in names.reversed) {
    print(name);
  }

/// Output:
// Qux
// Baz
// Bar
// Foo

  if (names.contains('Bar')) {
    print('Bar is in the list');
  }

  /// Output:
  // Bar is in the list

  for (final name in names.where((String name) => name.startsWith('B'))) {
    print(name);
  }

  /// Output:
  // Bar
  // Baz

  print(names[0]);
  print(names[1]);
  print(names[2]);
  print(names[3]);

  /// Output:
  // Foo
  // Bar
  // Baz
  // Qux

  try {
    print(names[4]);
  } catch (e) {
    print(e);
  }

  /// Output:
  // RangeError (index): Invalid value: Not in inclusive range 0..3: 4

  names.sublist(0).forEach(print);

  /// Output:
  // Foo
  // Bar
  // Baz
  // Qux

  names.sublist(1, 3).forEach(print);

  /// Output
  // Bar
  // Baz

  names.sublist(2, 3).forEach(print);

  /// Output
  // Baz

  final ages = [20, 30, 40];
  ages.add(50);
  ages.add(60);
  print(ages);

  /// Output
  // [20, 30, 40, 50, 60]

  const names1 = ['Foo', 'Bar', 'Baz', 'Qux'];
  const names2 = ['Foo', 'Bar', 'Baz', 'Qux'];
  if (names1 == names2) {
    print('names1 and names2 are equal');
  } else {
    print('names1 and names2 are not equal');
  }

  /// Output
  // names1 and names2 are equal

  ['Foo', 'Bar', 'Baz'].map((str) => str.toUpperCase()).forEach(print);

  /// Output
  // FOO
  // BAR
  // BAZ

  names.map((str) => str.length).forEach(print);

  /// Output
  // 3
  // 3
  // 3
  // 3

  final numbers = [1, 2, 3];

  var sum = 0;
  for (final number in numbers) {
    sum += number;
  }
  print(sum);

  /// Output
  // 6

  final sum = numbers.fold(
      0, (int previousValue, int thisValue) => previousValue + thisValue);
  print(sum);

  /// Output
  // 6

  // Get the total length of all strings in a list
  final totalLength =
      names.fold(0, (totalLength, str) => totalLength + str.length);
  print(totalLength);

  /// Output
  // 12

  final result =
      names.fold('', (result, str) => '$result ${str.toUpperCase()}');
  print(result);

  /// Output
  // FOO BAR BAZ QUX
}
```

### Sets

* Add dependency `dart pub add collection`
* Confirm dependency from `pubspec.yaml`

```dart
void main(List<String> args) {
  final names = {'Foo', 'Bar', 'Baz', 'Qux'};
  names.add('Foo');
  print(names);
}

/// Output
// {Foo, Bar, Baz, Qux}
```

```dart
void main(List<String> args) {
  final names2 = ['Foo', 'Bar', 'Baz', 'Foo'];
  final uniqueNames = {names2};
  print(uniqueNames);
}

/// Output
// {[Foo, Bar, Baz, Foo]}

void main(List<String> args) {
  final names2 = ['Foo', 'Bar', 'Baz', 'Foo'];
  final uniqueNames = {names2, names2};
  print(uniqueNames);
}

/// Output
// {[Foo, Bar, Baz, Foo]}
```

```dart
void main(List<String> args) {
  final names2 = ['Foo', 'Bar', 'Baz', 'Foo'];
  final uniqueNames = {...names2};
  print(uniqueNames);
}

/// Output
// {Foo, Bar, Baz}
```

```dart
void main(List<String> args) {
  final foo1 = 'Foo';
  var foo2 = 'Foo';

  print(foo1.hashCode);
  print(foo2.hashCode);
}

/// Output
// 721511413
// 721511413
```

```dart
void main(List<String> args) {
  final foo1 = 'Foo';
  var foo2 = 'foo';

  print(foo1.hashCode);
  print(foo2.hashCode);
}

/// Output
// 721511413
// 596015325
```

```dart
void main(List<String> args) {
  final names = {'Foo', 'Bar', 'Baz', 'Qux'};
  if (names.contains('Foo')) {
    print('Found Foo');
  } else {
    print('Did not find Foo');
  }
}
/// Output
// Found Foo
```

Sets can't be compared

```dart
void main(List<String> args) {
  final ages1 = {20, 30, 40};
  final ages2 = {20, 30, 40};

  if (ages1 == ages2) {
    print('Ages are equal');
  } else {
    print('Ages are not equal');
  }
}
/// Output
// Ages are not equal
```

To compare two sets use `collection`

```dart
import 'package:collection/collection.dart';

void main(List<String> args) {
  final ages1 = {20, 30, 40};
  final ages2 = {20, 30, 40};

  if (SetEquality().equals(ages1, ages2)) {
    print('Ages are equal');
  } else {
    print('Ages are not equal');
  }
}
/// Output
// Ages are equal
```

even when index id different it still compares

```dart
import 'package:collection/collection.dart';

void main(List<String> args) {
  final ages1 = {30, 20, 40};
  final ages2 = {20, 30, 40};

  if (SetEquality().equals(ages1, ages2)) {
    print('Ages are equal');
  } else {
    print('Ages are not equal');
  }
}
/// Output
// Ages are equal
```

### Hash Code and Equality

```dart
void main(List<String> args) {
  final person1 = Person(name: 'Foo', age: 10);
  final person2 = Person(name: 'Foo', age: 10);

  final persons = {person1, person2}; // set reads both same
  print(persons);
  // {Person: Foo, 10, Person: Foo, 10}

  print(person1.hashCode);
  print(person2.hashCode);
}

class Person {
  final String name;
  final int age;

  Person({
    required this.name,
    required this.age,
  });

  @override
  String toString() => 'Person: $name, $age';
}
/// Output
// {Person: Foo, 10, Person: Foo, 10}
// 96144219
// 617291087
```

Now both hash codes will be the same

```dart
import 'package:collection/collection.dart';

void main(List<String> args) {
  final person1 = Person(name: 'Foo', age: 10);
  final person2 = Person(name: 'Foo', age: 10);

  final persons = {person1, person2}; // set reads both same
  print(persons);
  // {Person: Foo, 10, Person: Foo, 10}

  print(person1.hashCode);
  print(person2.hashCode);
}

class Person {
  final String name;
  final int age;

  Person({
    required this.name,
    required this.age,
  });

  @override
  String toString() => 'Person: $name, $age';

  @override
  int get hashCode => Object.hash(name, age);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Person && name == other.name && age == other.age;
}
/// Output
// {Person: Foo, 10}
// 504772031
// 504772031
```

```dart
import 'package:collection/collection.dart';

void main(List<String> args) {
  final person = Person(name: 'Foo', age: 10);
  final dog = Dog(name: 'Foo', age: 10);

  // set prints as different
  final beings = {person, dog};
  print(beings); // {Person: Foo, 10, Dog: Foo, 10}

  // hascodes are same unless name and ages are same
  print(person.hashCode);
  print(dog.hashCode);
}

class Person {
  final String name;
  final int age;

  Person({
    required this.name,
    required this.age,
  });

  @override
  String toString() => 'Person: $name, $age';

  @override
  int get hashCode => Object.hash(name, age);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Person && name == other.name && age == other.age;
}

class Dog {
  final String name;
  final int age;

  Dog({
    required this.name,
    required this.age,
  });

  @override
  String toString() => 'Dog: $name, $age';

  @override
  int get hashCode => Object.hash(name, age);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Dog && name == other.name && age == other.age;
}
/// Output
// {Person: Foo, 10, Dog: Foo, 10}
// 245089659
// 245089659
```

### Maps

```dart
void main(List<String> args) {
  final info = {
    'name': 'Foo',
    'age': 10,
  };
  print(info);
  print(info['name']);
  print(info['age']);
}

/// Output
// {name: Foo, age: 10}
// Foo
// 10
```

```dart
void main(List<String> args) {
  final info = {
    'name': 'Foo',
    'age': 10,
  };
  print(info);
  // {name: Foo, age: 10}

  print(info['name']);
  // Foo

  print(info['age']);
  // 10

  print(info.keys);
  // (name, age)

  print(info.values);
  // (Foo, 10)

  info.putIfAbsent('height', () => 180);
  print(info);
  // {name: Foo, age: 10, height: 180}

  info.putIfAbsent('height', () => 190);
  print(info);
  // {name: Foo, age: 10, height: 180}

  info['height'] = 190;
  print(info);
  // {name: Foo, age: 10, height: 190}

  for (final entry in info.entries) {
    print(entry.key);
    print(entry.value);
  }
  // name
  // Foo
  // age
  // 10
  // height
  // 190

  if (info.containsKey('height')) {
    print('Height is ${info['height']}');
  } else {
    print('Height is not found');
  }
  // Height is 190

  print(info['weight']);
  // null
}
```

Map can also be built with other than string keys and values

```dart
void main(List<String> args) {
  final mapWithIntKeys = {
    10: 20,
    30: 40,
  };
  print(mapWithIntKeys);
}

/// Output
// {10: 20, 30: 40}
```

### Iterables

Iterables are lazy while lists are not

```dart
void main(List<String> args) {
  final iterable = Iterable.generate(20, (i) => getName(i));

  print(iterable);
}

String getName(int i) {
  print('Get name got called');
  return 'John #$i';
}

/// Output
// Get name got called
// Get name got called
// Get name got called
// Get name got called
// Get name got called
// Get name got called
// Get name got called
// Get name got called
// Get name got called
// Get name got called
// Get name got called
// Get name got called
// Get name got called
// Get name got called
// Get name got called
// Get name got called
// Get name got called
// Get name got called
// Get name got called
// Get name got called
// (John #0, John #1, John #2, John #3, John #4, John #5, ..., 
// John #18, John #19)
```

```dart
void main(List<String> args) {
  final iterable = Iterable.generate(20, (i) => getName(i));

  for (final name in iterable.take(2)) {
    print(name);
  }
}

String getName(int i) {
  print('Get name got called');
  return 'John #$i';
}
/// Output

// Get name got called
// John #0
// Get name got called
// John #1
```

### Mapping Lists to Iterables

```dart
void main(List<String> args) {
  const names = ['John', 'Jane', 'Jack', 'Jill'];
  final upperCaseNames = names.map((name) {
    print('Map got caled');
    return name.toUpperCase();
  });

  for (final name in upperCaseNames.take(3)) {
    print(name);
  }
}

/// Output
// Map got caled
// JOHN
// Map got caled
// JANE
// Map got caled
// JACK
```

### Unmodifiable List Views

```dart
import 'package:collection/collection.dart';

void main(List<String> args) {
  final names = ['John', 'Jane'];
  names.add('Jack');
  try {
    final readOnlyList = UnmodifiableListView(names);
    readOnlyList.add('Jill');
  } catch (e) {
    print(e);
  }
}

/// Output
// Unsupported operation: Cannot add to an unmodifiable list
```

### Unmodifiable Map Views

```dart
import 'package:collection/collection.dart';

void main(List<String> args) {
  final info = {
    'name': 'John',
    'age': 30,
    'address': {
      'street': 'Main Street',
      'city': 'New York',
    },
  };

  final info2 = UnmodifiableMapView(info);

  info.addAll(
    {
      'phone': '123-456-7890',
    },
  );
  print(info);
}

/// Output
// {name: John, age: 30, address: {street: Main Street, city: New York}, 
// phone: 123-456-7890}
```

```dart
import 'package:collection/collection.dart';

void main(List<String> args) {
  final info = {
    'name': 'John',
    'age': 30,
    'address': {
      'street': 'Main Street',
      'city': 'New York',
    },
  };

  final info2 = UnmodifiableMapView(info);

  try {
    info2.addAll(
      {
        'phone': '123-456-7890',
      },
    );
  } catch (e) {
    print(e);
  }
}

/// Output
// Unsupported operation: Cannot modify unmodifiable map
```

### Encapsulation with Unmodifiable Collections

```dart
import 'package:collection/collection.dart';

void main(List<String> args) {
  final foo = Person(
    name: 'Foo',
    siblings: [
      Person(name: 'Bar'),
    ],
  );

  try {
    foo.siblings?.add(
      Person(name: 'Baz'),
    );
  } catch (e) {
    print(e);
  }
}

class Person {
  final String name;
  final List<Person>? _siblings;

  UnmodifiableListView<Person>? get siblings =>
      _siblings == null ? null : UnmodifiableListView(_siblings!);

  const Person({
    required this.name,
    List<Person>? siblings,
  }) : _siblings = siblings;
}

/// Output
// Unsupported operation: Cannot add to an unmodifiable list
```

### Extending ListBase to Create a Safer List

Unhandled exception

```dart
void main(List<String> args) {
  final List<String> names = [];
  print(names.first);
}

/// Output
// Unhandled exception:
// Bad state: No element
```

```dart
void main(List<String> args) {
  final List<String> names = [];
  print(names.last);
}

/// Output
// Unhandled exception:
// Bad state: No element
```

```dart
void main(List<String> args) {
  final List<String> names = [];
  print(names[1]);
}

/// Output
// Unhandled exception:
// RangeError (index): Invalid value: Valid value range is empty: 1
```

Safe list example

```dart
import 'dart:collection';

void main(List<String> args) {
  const notFound = 'NOT_FOUND';
  const defaultString = 'DEFAULT_VALUE';

  final myList = SafeList(
    defaultValue: defaultString,
    absentValue: notFound,
    values: ['Bar', 'Baz'],
  );

  print(myList[0]); // Bar
  print(myList[1]); // Bar
  print(myList[2]); // NOT_FOUND

  myList.length = 4;
  print(myList[3]); // DEFAULT_VALUE
  print(myList); // [Bar, Baz, DEFAULT_VALUE, DEFAULT_VALUE]

  myList.length = 0;
  print(myList); // []
  print(myList.first); // NOT_FOUND
  print(myList.last); // NOT_FOUND
}

class SafeList<T> extends ListBase<T> {
  final List<T> _list;
  final T absentValue;
  final T defaultValue;

  SafeList({
    required this.defaultValue,
    required this.absentValue,
    List<T>? values,
  }) : _list = values ?? [];

  @override
  T operator [](int index) => index < _list.length ? _list[index] : absentValue;

  @override
  void operator []=(int index, T value) => _list[index] = value;

  @override
  int get length => _list.length;

  @override
  set length(int newLength) {
    if (newLength <= _list.length) {
      _list.length = newLength;
    } else {
      _list.addAll(List.filled(newLength - _list.length, defaultValue));
    }
  }

  @override
  T get first => _list.isNotEmpty ? _list.first : absentValue;

  @override
  T get last => _list.isNotEmpty ? _list.last : absentValue;
}
```

### Synchronous Generators

```dart
void main(List<String> args) {
  for (final name in getNames()) {
    print(name);
  }
}

Iterable<String> getNames() sync* {
  print('Producitn Bob');
  yield 'Bob';
  print('Producing Alice');
  yield 'Alice';
  print('Producing Joe');
  yield 'Joe';
  print('Producing template names');
  yield* templateNames();
}

Iterable<String> templateNames() sync* {
  print('Producint "Bob"');
  yield 'Foo';
  print('Producing "Alice"');
  yield 'Bar';
  print('Producing "Joe"');
  yield 'Baz';
}

/// Output
// Producitn Bob
// Bob
// Producing Alice
// Alice
// Producing Joe
// Joe
// Producing template names
// Producint "Bob"
// Foo
// Producing "Alice"
// Bar
// Producing "Joe"
// Baz
```

Without print statements, just focus on results

```dart
void main(List<String> args) {
  for (final name in getNames()) {
    print(name);
  }
}

Iterable<String> getNames() sync* {
  yield 'Bob';
  yield 'Alice';
  yield 'Joe';
  yield* templateNames();
}

Iterable<String> templateNames() sync* {
  yield 'Foo';
  yield 'Bar';
  yield 'Baz';
}

/// Output
// Bob
// Alice
// Joe
// Foo
// Bar
// Baz
```

### Spread Operator with Collections

Wrong way of adding lists

```dart
void main(List<String> args) {
  addToArrayWrong();
}

void addToArrayWrong() {
  final names1 = ['Foo 1', 'Bar 1', 'Baz 1'];
  final names2 = ['Foo 2', 'Bar 2', 'Baz 2'];
  final allNamesWrong = names1;
  allNamesWrong.addAll(names2);
  print(names1);
  print(names2);
  print(allNamesWrong);
}

/// Output
// [Foo 1, Bar 1, Baz 1, Foo 2, Bar 2, Baz 2]
// [Foo 2, Bar 2, Baz 2]
// [Foo 1, Bar 1, Baz 1, Foo 2, Bar 2, Baz 2]
```

Right way of adding lists

```dart
void main(List<String> args) {
  addToArrayRight();
}

void addToArrayRight() {
  final names1 = ['Foo 1', 'Bar 1', 'Baz 1'];
  final names2 = ['Foo 2', 'Bar 2', 'Baz 2'];
  final allNamesRight = [...names1, ...names2];
  print(names1);
  print(names2);
  print(allNamesRight);
  final anotherWay = {...names1}..addAll(names2);
  print(anotherWay);
}

/// Output
// [Foo 1, Bar 1, Baz 1]
// [Foo 2, Bar 2, Baz 2]
// [Foo 1, Bar 1, Baz 1, Foo 2, Bar 2, Baz 2]
// {Foo 1, Bar 1, Baz 1, Foo 2, Bar 2, Baz 2}
```

Wrong Way of adding dictionary

```dart
void main(List<String> args) {
  addToDictionaryWrong();
}

void addToDictionaryWrong() {
  /// adding to const will crash
  const info = {
    'name': 'Foo',
    'age': 20,
    'height': 1.8,
  };

  try {
    final result = info;
    result.addAll({'weight': 80});
  } catch (e) {
    print(e);
  }
}
/// Output
// Unsupported operation: Cannot modify unmodifiable map
```

Right way of adding dictionary

```dart
void main(List<String> args) {
  addToDictionaryRight();
}

void addToDictionaryRight() {
  /// adding to const will crash
  const info = {
    'name': 'Foo',
    'age': 20,
    'height': 1.8,
  };
  final result = {...info}..addAll({'weight': 80});
  print(result);
}
/// Output
// {name: Foo, age: 20, height: 1.8, weight: 80}
```

### Collection Comprehensions

Extract characters except a, b, c from a string

```dart
void main(List<String> args) {
  final string = 'abracadabra';
  var result = '';
  for (final char in string.split('')) {
    if (char == 'a' || char == 'b' || char == 'c') {
    } else {
      result += char;
    }
  }
  print(result);
}

/// Output
// rdr
```

another way (set comprehension)

```dart
void main(List<String> args) {
  final string = 'abracadabra';
  var allExceptAbc = {
    for (final char in string.split('')) 'abc'.contains(char) ? null : char
  }
    ..removeAll([null])
    ..cast<String>();
  print(allExceptAbc);
}

/// Output
// {r, d}
```

List Comprehensions

```dart
void main(List<String> args) {
  final allNumbers = Iterable.generate(100);

  // List<dynamic> evenNumbers
  final evenNumbers = [
    for (final number in allNumbers)
      if (number % 2 == 0) number
  ];

  // Iterable<dynamic> evenNumbersFunctional
  final evenNumbersFunctional = allNumbers.where((number) => number % 2 == 0);

  // List<dynamic> oddNumbers
  final oddNumbers = [
    for (final number in allNumbers)
      if (number % 2 != 0) number
  ];

  // Iterable<dynamic> oddNumbersFunctional
  final oddNumbersFunctional = allNumbers.where((number) => number % 2 != 0);

  print(allNumbers);
  // (0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17,
  // 18, ..., 98, 99)
  print(evenNumbers);
  // [0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34,
  // 36, 38, 40, 42, 44, 46, 48, 50, 52, 54, 56, 58, 60, 62, 64, 66, 68,
  // 70, 72, 74, 76, 78, 80, 82, 84, 86, 88, 90, 92, 94, 96, 98]
  print(evenNumbersFunctional); // lazaly evaluated functionally
  // (0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32,
  // 34, ..., 96, 98)
  print(oddNumbers);
  // [1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31, 33, 35,
  // 37, 39, 41, 43, 45, 47, 49, 51, 53, 55, 57, 59, 61, 63, 65, 67, 69,
  // 71, 73, 75, 77, 79, 81, 83, 85, 87, 89, 91, 93, 95, 97, 99]
  print(oddNumbersFunctional); // lazaly evaluated functionally
  // (1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31, 33,
  // 35, ..., 97, 99)
}
```

Turn a list into a map using map comprehensions

```dart
void main(List<String> args) {
  final names = [
    'John Doe',
    'James Smith',
    'Alice Jones',
  ];

  final namesAndLengths = {
    for (final name in names) name: name.length,
  };
  print(namesAndLengths);
}

/// Output
// {John Doe: 8, James Smith: 11, Alice Jones: 11}
```

### The Collection Package

If working with large amount of booleans then use `boolList` because it
uses only one bit per boolean, not bite per boolean.

```dart
import 'package:collection/collection.dart';

void main(List<String> args) {
  testBoolList();
}

void testBoolList() {
  final boolList = BoolList(
    10,
    growable: true,
  );
  print(boolList);
}

/// Output
// [false, false, false, false, false, false, false, false, false, false]
```

```dart
import 'package:collection/collection.dart';

void main(List<String> args) {
  testBoolList();
}

void testBoolList() {
  final boolList = BoolList(
    10,
    growable: true,
  );
  print(boolList);
  // [false, false, false, false, false, false, false, false, false, false]

  boolList[3] = true;
  if (boolList[3]) {
    print('The boolean value at index 3 is true');
  } else {
    print('The boolean value at index 3 is false');
  }
  // The boolean value at index 3 is true

  print(boolList);
  // [false, false, false, true, false, false, false, false, false, false]

  boolList.length *= 2;
  print(boolList);
  // [false, false, false, true, false, false, false, false, false, false,
  // false, false, false, false, false, false, false, false, false, false]
}
```

Make keys unique by their length

```dart
import 'package:collection/collection.dart';

void main(List<String> args) {
  testCanonicalizedMap();
}

void testCanonicalizedMap() {
  final info = {
    'name': 'John',
    'age': 30,
    'sex': 'male',
    'address': 'New York',
  };

  final canonMap = CanonicalizedMap.from(info, (key) {
    return key.length;
  });
  print(canonMap);
}

// 'sex' overritten the 'age' here
/// Output
// {name: John, sex: male, address: New York}
```

```dart
import 'package:collection/collection.dart';

void main(List<String> args) {
  testCanonicalizedMap();
}

void testCanonicalizedMap() {
  final info = {
    'name': 'John',
    'age': 30,
    'sex': 'male',
    'address': 'New York',
  };

  final canonMap = CanonicalizedMap.from(info, (key) {
    return key.split('').first;
  });
  print(canonMap);
}

// 'address' overritten the 'age' here by its first character
/// Output
// {name: John, address: New York, sex: male}
```

CombinedIterableView

```dart
import 'package:collection/collection.dart';

void main(List<String> args) {
  testCombinedIterableView();
}

void testCombinedIterableView() {
  final one = [1, 2, 3];
  final two = [10, 20, 30];
  final three = [40, 50, 60];
  var combined = CombinedIterableView([one, two, three]);
  print(combined);
}

/// Output
// (1, 2, 3, 10, 20, 30, 40, 50, 60)
```

CombinedIterableView

```dart
import 'package:collection/collection.dart';

void main(List<String> args) {
  testCombinedIterableView();
}

void testCombinedIterableView() {
  final List<int> one = [1, 2, 3];
  final List<int> two = [10, 20, 30];
  final List<int> three = [40, 50, 60];
  var combined = CombinedIterableView([one, two, three]);
  print(combined);
  // (1, 2, 3, 10, 20, 30, 40, 50, 60)

  two.add(40);
  print(combined);
  // (1, 2, 3, 10, 20, 30, 40, 40, 50, 60)

  print(combined.length);
  // 10

  print(combined.isEmpty);
  // false

  print(combined.contains(5));
  // false

  print(combined.contains(10));
  // true
}
```

CombinedListView

```dart
import 'package:collection/collection.dart';

void main(List<String> args) {
  testCombinedListView();
}

void testCombinedListView() {
  // CombinedListView is a view of a list of lists, and is unmodifiable
  final swedishNames = ['Sven', 'Karl', 'Gustav'];
  final norwegianNames = ['Sven', 'Karl', 'Ole'];
  final frenchNames = ['Sven', 'Karl', 'Pierre'];

  final names = CombinedListView([swedishNames, norwegianNames, frenchNames]);
  print(names);
  // [Sven, Karl, Gustav, Sven, Karl, Ole, Sven, Karl, Pierre]

  if (names.contains('Sven')) {
    print('Sven is in the list');
  }
  // Sven is in the list

  try {
    names.removeAt(0);
  } catch (e) {
    print(e);
  }
  // Unsupported operation: Cannot modify an unmodifiable List

  swedishNames.removeAt(0);
  print(names);
  // [Karl, Gustav, Sven, Karl, Ole, Sven, Karl, Pierre]
}
```

CombinedMapView

```dart
import 'package:collection/collection.dart';

void main(List<String> args) {
  testCombinedMapView();
}

void testCombinedMapView() {
  var map1 = {'a': 1, 'b': 2, 'c': 3};
  var map2 = {'b': 4, 'c': 5, 'd': 6};
  var map3 = {'c': 7, 'd': 8, 'e': 9};

  var combinedMap = CombinedMapView([map1, map2, map3]);

  print(combinedMap);
  // {a: 1, b: 2, c: 3, d: 6, e: 9}

  print(combinedMap['a']);
  // 1

  print(combinedMap['b']);
  // 2

  print(combinedMap['c']);
  // 3

  print(combinedMap['d']);
  // 6

  print(combinedMap['e']);
  // 9

  print(combinedMap['f']);
  // null

  try {
    combinedMap['a'] = 10;
  } catch (e) {
    print(e);
  }
  // Unsupported operation: Cannot modify unmodifiable map

  map1['foo'] = 20;
  print(map1);
  // {a: 1, b: 2, c: 3, foo: 20}
}
```
