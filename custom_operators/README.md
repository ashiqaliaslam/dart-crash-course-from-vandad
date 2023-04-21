# Dart Course

## Custom Operators in Dart

Create dart app `dart create -t console custom_operators`

Run fswatch
`fswatch -o bin/ | xargs -n1 -I{} sh -c 'clear; dart bin/custom_operators.dart'`

Custom operators is the ability for you to add functionality to Dart so that
an existing operator can work in the way that you want.

### Family Member Operators

```dart
void main(List<String> args) {
  final dad = FamilyMember(name: 'Dad');
  final mom = FamilyMember(name: 'Mom');
  final family = dad + mom;
  print(family);
}

class FamilyMember {
  final String name;

  const FamilyMember({required this.name});

  @override
  String toString() => 'One member\'s name is $name';
}

class Family {
  final List<FamilyMember> members;

  const Family({required this.members});

  @override
  String toString() => 'Family members are $members';
}

extension ToFamily on FamilyMember {
  Family operator +(FamilyMember other) => Family(members: [this, other]);
}

/// Output
// Family members are [One member's name is Dad, One member's name is Mom]
```

### Multiplying an Iterable

```dart
void main(List<String> args) {
  const names = ['Seth', 'Kathy', 'Ethan', 'Megan'];
  print(names * 2);
}

/// Output
// Error: The operator '*' isn't defined for the class 'List<String>'.
//  - 'List' is from 'dart:core'.
// Try correcting the operator to an existing operator, or 
// defining a '*' operator.
```

```dart
void main(List<String> args) {
  const names = ['Seth', 'Kathy', 'Ethan', 'Megan'];
  final result = names * 2;
  print(result);
}

extension Times<T> on Iterable<T> {
  Iterable<T> operator *(int times) sync* {
    for (var i = 0; i < times; i++) {
      yield* this;
    }
  }
}

/// Output
// (Seth, Kathy, Ethan, Megan, Seth, Kathy, Ethan, Megan)
```

### Addition of Two Optional Integers

```dart
void main(List<String> args) {
  print(add());
  // 0
  print(add(10, null));
  // 10
  print(add(null, 20));
  // 20
  print(add(10, 20));
  /// Error
  // Unhandled exception:
  // Stack Overflow
  // .
  // .
  // .
}

int add([int? a, int? b]) {
  return a + b;
}

extension NullableAdd<T extends num> on T? {
  T operator +(T? other) {
    // if this != null && other == null, return this
    if (this != null && other == null) {
      return this as T;
    }
    // if this == null && other != null, return other
    else if (this == null && other != null) {
      return other;
    }
    // if this != null && other != null, return this + other
    else if (this != null && other != null) {
      return this + other as T;
    }
    // if this == null && other == null, return 0
    else {
      return 0 as T;
    }
  }
}
```

Without error (with shadow variable)

```dart
void main(List<String> args) {
  print(add());
  // 0
  print(add(10, null));
  // 10
  print(add(null, 20));
  // 20
  print(add(10, 20));
  // 30
}

int add([int? a, int? b]) {
  return a + b;
}

// Given a number of type integer or double it will return integer or double
extension NullableAdd<T extends num> on T? {
  T operator +(T? other) {
    // if `this` is null, then it shouldn't be null inside the if statement
    // however type promotion inside extensions specifically using keyword
    // doesn't work.
    // In Dart, unfortunately even if you check that `this` is not null inside
    // this block Dart doesn't understand.
    // So you have to first create a shadow variable.
    final thisShadow = this;
    // if this != null && other == null, return this
    if (this != null && other == null) {
      return this as T;
    }
    // if this == null && other != null, return other
    else if (this == null && other != null) {
      return other;
    }
    // if this != null && other != null, return this + other
    else if (thisShadow != null && other != null) {
      return thisShadow + other as T;
    }
    // if this == null && other == null, return 0
    else {
      return 0 as T;
    }
  }
}
```

### Subtracting a String from Another String

```dart
void main(List<String> args) {
  print('Foo Bar' - 'Foo');
  print('Bar' - 'Bar');
  print('Foo Bar' - 'Baz');
}

extension Remove on String {
  String operator -(String other) => replaceAll(other, '');
}

/// Output
//  Bar

// Foo Bar
```

### Subtracting an Iterable from Another Iterable

```dart
void main(List<String> args) {
  print([1, 2, 3] - [1, 2]);
  print([1, 2, 3] - [1, 2, 3]);
  print([1, 2, 3] - [3, 2, 1]);
  print(['Foo', 'Bar', 'Baz'] - ['Baz', 'Bar']);
  print(['Foo', 'Bar', 'Baz'] - ['Baz']);
}

extension Remove<T> on Iterable<T> {
  Iterable<T> operator -(Iterable<T> other) =>
      where((element) => !other.contains(element));
}

/// Output
// (3)
// ()
// ()
// (Foo)
// (Foo, Bar)
```

### Custom Operators on Map

```dart
void main(List<String> args) {
  print({'name': 'John', 'age': 42} + {'address': '123 Main St'});
  // {name: John, age: 42, address: 123 Main St}

  print({'name': 'John', 'age': 42} - {'age': 42});
  // {name: John}

  print({'name': 'John', 'age': 42} * 2);
  // ({name: John, age: 42}, {name: John, age: 42})
}

// K == Key
// V == Value
extension MapOperations<K, V> on Map<K, V> {
  Map<K, V> operator +(Map<K, V> other) => {...this, ...other};

  Map<K, V> operator -(Map<K, V> other) {
    return {...this}..removeWhere((key, value) {
        return other.containsKey(key) && other[key] == value;
      });
  }

  Iterable<Map<K, V>> operator *(int times) sync* {
    for (var i = 0; i < times; i++) {
      yield this;
    }
  }
}
```

### Cross Data Type Operators

```dart
void main(List<String> args) {
  final mom = Person(name: 'Jane');
  final dad = Person(name: 'John');
  final son = Person(name: 'Jack');
  final daughter = Person(name: 'Jill');

  final whiskers = Pet(name: 'Whiskers');

  final family = mom + dad;
  print('Mom + Dad = $family');
  // Mom + Dad = Family (members = [Person is Jane, Person is John], pets = [])

  final withWhiskers = family & whiskers;
  print('Mom + Dad + Whiskers = $withWhiskers');
  // Mom + Dad + Whiskers = Family (members = [Person is Jane, Person is John],
  // pets = [Pet is Whiskers])

  final withSon = withWhiskers + son;
  print('Mom + Dad + Whiskers + Son = $withSon');
  // Mom + Dad + Whiskers + Son = Family (members = [Person is Jane,
  // Person is John, Person is Jack], pets = [Pet is Whiskers])

  final withDaughter = withSon + daughter;
  print('Mom + Dad + Whiskers + Son + Daughter = $withDaughter');
  // Mom + Dad + Whiskers + Son + Daughter = Family (members = [Person is Jane,
  // Person is John, Person is Jack, Person is Jill], pets = [Pet is Whiskers])

  final sonWithWhiskers = son & whiskers;
  print('Son + Whiskers = $sonWithWhiskers');
  // Son + Whiskers = Family (members = [Person is Jack],
  // pets = [Pet is Whiskers])

  final withSonAndWhiskers = withDaughter ^ sonWithWhiskers;
  print(
      'Mom + Dad + Whiskers + Son + Daughter ^ Son + Whiskers = $withSonAndWhiskers');
  // Mom + Dad + Whiskers + Son + Daughter ^ Son + Whiskers =
  // Family (members = [Person is Jane, Person is John, Person is Jack,
  // Person is Jill, Person is Jack], pets = [Pet is Whiskers, Pet is Whiskers])
}

class Person {
  final String name;

  const Person({required this.name});

  @override
  String toString() => 'Person is $name';
}

class Pet {
  final String name;
  const Pet({required this.name});

  @override
  String toString() => 'Pet is $name';
}

class Family {
  final List<Person> members;
  final List<Pet> pets;

  const Family({required this.members, required this.pets});

  @override
  String toString() => 'Family (members = $members, pets = $pets)';
}

extension on Person {
  Family operator +(Person other) => Family(
        members: [this, other],
        pets: [],
      );

  Family operator &(Pet other) => Family(
        members: [this],
        pets: [other],
      );
}

extension on Family {
  Family operator &(Pet other) => Family(
        members: members,
        pets: [...pets, other],
      );

  Family operator +(Person other) => Family(
        members: [...members, other],
        pets: pets,
      );

  Family operator ^(Family other) => Family(
        members: [...members, ...other.members],
        pets: [...pets, ...other.pets],
      );
}
```

### Operators on Class Definitions

```dart
void main(List<String> args) {
  final meThisYear = Person(age: 30);
  print('Me this year is = $meThisYear');
  final meNextYear = meThisYear + 1;
  print('Me next year is = $meNextYear');
}

class Person {
  final int age;

  Person({required this.age});

  Person operator +(int age) => Person(
        age: this.age + age,
      );

  @override
  String toString() => 'Person (age = $age)';
}

/// Output
// Me this year is = Person (age = 30)
// Me next year is = Person (age = 31)
```
