# Dart Course

## Generics in Dart

Create dart app `dart create -t console generics`

Run fswatch
`fswatch -o bin/ | xargs -n1 -I{} sh -c 'clear; dart bin/generics.dart'`

Generics can constrain the type of an object

### Generic Integer or Double

Basic method returning different data types

```dart
void main(List<String> args) {
  final double doubleValue = eitherIntOrDouble(WhatToReturn.double) as double;
  print(doubleValue); // 1.0

  final int intValue = eitherIntOrDouble(WhatToReturn.int) as int;
  print(intValue); // 1
}

enum WhatToReturn { int, double }

num eitherIntOrDouble(WhatToReturn whatToReturn) {
  switch (whatToReturn) {
    case WhatToReturn.int:
      return 1;
    case WhatToReturn.double:
      return 1.0;
    default:
      throw Exception('Unknown type');
  }
}
```

```dart
void main(List<String> args) {
  final double doubleValue = eitherIntOrDouble();
  print(doubleValue); // 1.1

  final int intValue = eitherIntOrDouble();
  print(intValue); // 1
}

enum WhatToReturn { int, double }

SOMETHING eitherIntOrDouble<SOMETHING extends num>() {
  switch (SOMETHING) {
    case int:
      return 1 as SOMETHING;
    case double:
      return 1.1 as SOMETHING;
    default:
      throw Exception('Not supported');
  }
}
```

```dart
void main(List<String> args) {
  final double doubleValue = eitherIntOrDouble();
  print(doubleValue); // 1.1

  final int intValue = eitherIntOrDouble();
  print(intValue); // 1
}

enum WhatToReturn { int, double }

// Generic types are usually just one letter such as "T"
// Usually these generic types are called T or E
// T is for generic type
// E is for generic element
T eitherIntOrDouble<T extends num>() {
  switch (T) {
    case int:
      return 1 as T;
    case double:
      return 1.1 as T;
    default:
      throw Exception('Not supported');
  }
}
```

### Type Matching

```dart
void main(List<String> args) {
  print(doTypesMatch(1, 2)); // true
  print(doTypesMatch(1, 2.2)); // false
  print(doTypesMatch(1, 'Foo')); // false
  print(doTypesMatch('Foo', 'Bar')); // true
}

bool doTypesMatch(Object a, Object b) {
  return a.runtimeType == b.runtimeType;
}
```

```dart
void main(List<String> args) {
  print(doTypesMatch(1, 2)); // true
  print(doTypesMatch(1, 2.2)); // false
  print(doTypesMatch(1, 'Foo')); // false
  print(doTypesMatch('Foo', 'Bar')); // true
}

bool doTypesMatch<TYPE1, TYPE2>(TYPE1 a, TYPE2 b) => TYPE1 == TYPE2;
```

```dart
void main(List<String> args) {
  print(doTypesMatch(1, 2)); // true
  print(doTypesMatch(1, 2.2)); // false
  print(doTypesMatch(1, 'Foo')); // false
  print(doTypesMatch('Foo', 'Bar')); // true
}
// K for Left, R for Right
bool doTypesMatch<L, R>(L a, R b) => L == R;
```

### Constrained Generic Type Definitions

```dart
void main(List<String> args) {
  const momAndDad = {
    'mom': Person(),
    'dad': Person(),
  };
  const brotherAndSisterAndFish = {
    'Brother': Person(),
    'Sister': Person(),
    'Fishy': Fish(),
  };

  final allValues = [momAndDad, brotherAndSisterAndFish];

  describe(allValues);
}

// This can also be used, this is without generics.
// typedef BreathingThings = Map<String, CanBreath>;

typedef BreathingThings<T extends CanBreath> = Map<String, T>;

void describe(Iterable<BreathingThings> values) {
  for (final map in values) {
    for (final keyAndValue in map.entries) {
      print('Will call breath() on ${keyAndValue.key}');
      keyAndValue.value.breath();
    }
  }
}

mixin CanBreath {
  void breath();
}

class Person with CanBreath {
  const Person();

  @override
  void breath() {
    print('Person is breathing...');
  }
}

class Fish with CanBreath {
  const Fish();

  @override
  void breath() {
    print('Fish is breathing...');
  }
}

/// Output
// Will call breath() on mom
// Person is breathing...
// Will call breath() on dad
// Person is breathing...
// Will call breath() on Brother
// Person is breathing...
// Will call breath() on Sister
// Person is breathing...
// Will call breath() on Fishy
// Fish is breathing...
```

### Unconstrained Generic Type Definitions

```dart
void main(List<String> args) {
  const one = KeyValue(1, 2); // MapEntry<int, int>
  print(one); // MapEntry(1: 2)

  const two = KeyValue(1, 2.2); // MapEntry<int, double>
  print(two); // MapEntry(1: 2.2)

  const KeyValue three = KeyValue(1, 'Foo'); // MapEntry<dynamic, dynamic>
  print(three); // MapEntry(1: Foo)

  const KeyValue four = KeyValue(1, 2); // MapEntry<dynamic, dynamic>
  print(four); // MapEntry(1: 2)
}

typedef KeyValue<int, double> = MapEntry<int, double>;
```

By creating generics dart will understand data types automatically

```dart
void main(List<String> args) {
  const one = KeyValue(1, 2); // MapEntry<int, int>
  print(one); // MapEntry(1: 2)

  // It will produce dynamic data types for a map  
  const KeyValue four = KeyValue(1, 2); // MapEntry<dynamic, dynamic>
  print(four); // MapEntry(1: 2)

  const two = KeyValue(1, 2.2); // MapEntry<int, double>
  print(two); // MapEntry(1: 2.2)

  const three = KeyValue(1, 'Foo'); // MapEntry<int, String>
  print(three); // MapEntry(1: Foo)
}

typedef KeyValue<K, V> = MapEntry<K, V>;
```

### Specializing Generic Type Definitions

for example, to foce json to have keys and values

```dart
void main(List<String> args) {
  // Map<String, Object> json
  const json = {
    'name': 'John',
    'age': 30,
  };
  print(json);
  print(json.runtimeType);
}

typedef JSON<T> = Map<String, T>;

/// Output
// {name: John, age: 30}
```

```dart
void main(List<String> args) {
  // Map<String, dynamic> json
  const JSON json = {
    'name': 'John',
    'age': 30,
  };
  print(json);
}

typedef JSON<T> = Map<String, T>;

/// Output
// {name: John, age: 30}
```

```dart
void main(List<String> args) {
  // Map<String, int> json
  const JSON<int> json = {
    'name': 'John', // Error: The element type 'String' can't be assigned
    'age': 30,
  };
  print(json);
}

typedef JSON<T> = Map<String, T>;

/// Output
```

### Generic Mixins and Specialized Mixin Type Definitions

```dart
void main(List<String> args) {
  const person = Person(height: 1.7);
  const dog = Dog(height: 1);
  print(person.height); // 1.7
  print(dog.height); // 1
}

mixin HasHeight<H extends num> {
  H get height;
}

typedef HasIntHeight = HasHeight<int>;
typedef HasDoubleHeight = HasHeight<double>;

class Person with HasDoubleHeight {
  @override
  final double height;

  const Person({required this.height});
}

class Dog with HasIntHeight {
  @override
  final int height;

  const Dog({required this.height});
}
```

### Generic Classes with Generic Extensions

```dart
void main(List<String> args) {
  const touple = Touple(1, 20); // Touple<int, int> touple
  print(touple);
  final swapped = touple.swap(); // Touple<dynamic, dynamic> swapped
  print(swapped);
}

class Touple<L, R> {
  final L left;
  final R right;

  const Touple(this.left, this.right);

  @override
  String toString() => 'Touple, left = $left, right = $right';
}

extension on Touple {
  Touple swap() => Touple(right, left);
}

/// Output
// Touple, left = 1, right = 20
// Touple, left = 20, right = 1
```

```dart
void main(List<String> args) {
  const touple = Touple(1, 20); // Touple<int, int>
  print(touple); // Touple, left = 1, right = 20

  final swapped = touple.swap(); // Touple<int, int>
  print(swapped); // Touple, left = 20, right = 1

  final intAndString = Touple(1, 'Hello'); // Touple<int, String>
  print(intAndString); // Touple, left = 1, right = Hello

  final swappedIntAndString = intAndString.swap(); // Touple<String, int>
  print(swappedIntAndString); // Touple, left = Hello, right = 1
}

class Touple<L, R> {
  final L left;
  final R right;

  const Touple(this.left, this.right);

  @override
  String toString() => 'Touple, left = $left, right = $right';
}

extension<L, R> on Touple<L, R> {
  Touple<R, L> swap() => Touple(right, left);
}
```

```dart
void main(List<String> args) {
  const touple = Touple(1, 20.2); // Touple<int, double>
  final swapped = touple.swap(); // Touple<double, int>

  print(touple.sum); // 21.2
  print(swapped.sum); // 21.2
}

class Touple<L, R> {
  final L left;
  final R right;

  const Touple(this.left, this.right);

  @override
  String toString() => 'Touple, left = $left, right = $right';
}

extension<L, R> on Touple<L, R> {
  Touple<R, L> swap() => Touple(right, left);
}

extension<L extends num, R extends num> on Touple<L, R> {
  num get sum => left + right;
}
```

### Generic Sorting with Comparible

```dart
void main(List<String> args) {
  sort(ascending: false);
  // [100, 90, 40, 20, 10]
  // [Foo, Baz, Bar]
  // [10.2, 4.2, 3.1, 1.3]

  sort(ascending: true);
  // [10, 20, 40, 90, 100]
  // [Bar, Baz, Foo]
  // [1.3, 3.1, 4.2, 10.2]
}

const ages = [100, 20, 10, 90, 40];
const names = ['Foo', 'Bar', 'Baz'];
const distances = [3.1, 10.2, 1.3, 4.2];

int isLessThan<T extends Comparable>(T a, T b) => a.compareTo(b);
int isGreaterThan<T extends Comparable>(T a, T b) => b.compareTo(a);

void sort({required bool ascending}) {
  final comparator = ascending ? isLessThan : isGreaterThan;
  print([...ages]..sort(comparator));
  print([...names]..sort(comparator));
  print([...distances]..sort(comparator));
}
```

### Handling Lack of Common Ancestors

```dart
void main(List<String> args) {
  print(1.toInt() == 1); // true
  print((2.2).toInt() == 2); // true
  print((2.0).toInt() == 2); // true
  print('3'.toInt() == 3); // true
  print(['4', '5'].toInt() == 9); // true
  print([4, 5].toInt() == 9); // true
  print(['2.4', '3.5'].toInt() == 6); // true
  print(['2', '3.5'].toInt() == 6); // true
  print({'2', 3, '4.2'}.toInt() == 9); // true
  print(['2', 3, '4.2', 5.3].toInt() == 14); // true
}

extension ToInt on Object {
  int toInt() {
    final list = [
      if (this is Iterable<Object>)
        ...this as Iterable<Object>
      else if (this is int)
        [this is int]
      else
        (double.tryParse(toString()) ?? 0.0).round()
    ];
    return list
        .map(
          (e) => (double.tryParse(e.toString()) ?? 0.0).round(),
        )
        .reduce((lhs, rhs) => lhs + rhs);
  }
}
```

### Generic Extension on Any Data Type

```dart
void main(List<String> args) {
  final personName =
      personThing.mapIfOfType((Person p) => p.name) ?? 'Unknwon person name';
  print(personName); // Foo

  final animalName =
      personThing.mapIfOfType((Animal p) => p.name) ?? 'Unknwon person name';
  print(animalName); // Unknwon person name
}

abstract class Thing {
  final String name;

  const Thing({required this.name});
}

class Person extends Thing {
  final int age;

  const Person({required String name, required this.age}) : super(name: name);
}

class Animal extends Thing {
  final String species;

  const Animal({required String name, required this.species})
      : super(name: name);
}

const Thing personThing = Person(name: 'Foo', age: 20);

const Thing animalThing = Animal(name: 'Bar', species: 'Car');

extension<T> on T {
  R? mapIfOfType<E, R>(R Function(E) f) {
    final shadow = this;
    if (shadow is E) {
      return f(shadow);
    } else {
      return null;
    }
  }
}
```

### Generic Function Pointers

```dart
void main(List<String> args) {
  const integers = [100, 5, 2];
  const doubles = [33.0, 3, 2.0];

  print(integers.reduce(divide)); // 10
  // 100 / 5 = 20 / 2 = 10
  print(doubles.reduce(divide)); // 5.5
  // 33 / 3 = 11 / 2 = 5.5
}

T divide<T extends num>(T lhs, T rhs) {
  if (lhs is int && rhs is int) {
    return lhs ~/ rhs as T;
  } else {
    return lhs / rhs as T;
  }
}
```

### Generic Class Properties

```dart
void main(List<String> args) {
  print(Person(age: 10).ageRounded); // 10
  print(Person(age: 10.2).ageRounded); // 10
}

class Person<T extends num> {
  final T age;

  const Person({required this.age});

  int get ageRounded => age.round();
}
```
