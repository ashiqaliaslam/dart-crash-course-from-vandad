# Dart Course

## Mixins in Dart

Create dart app `dart create -t console mixins`

Run fswatch `fswatch -o bin/ | xargs -n1 -I{} sh -c 'clear; dart bin/mixins.dart'`

### Simple Mixins

Mixins are datatypes
Mixins are separate entities that can bring functionality to existing classes
and enumerations

```dart
void main(List<String> args) {
  final person = Person();
  person.jump(speed: 10.0);
  person.walk(speed: 5.0);
}

mixin HasSpeed {
  // abstract property in a mixin means that whichever`enum` or a
  // `class` that implements this has to have this property

  // Therefore any other mixin that is implemented on top of this mixin
  // can have access to this property
  abstract double speed;
}

mixin CanJump on HasSpeed {
  void jump({required double speed}) {
    print('$runtimeType is jumping at the speed of $speed');
    this.speed = speed;
  }
}

mixin CanWalk on HasSpeed {
  void walk({required double speed}) {
    print('$runtimeType is walking at the speed of $speed');
    this.speed = speed;
  }
}

// Using mixin
class Person with HasSpeed, CanWalk, CanJump {
  @override
  double speed;
  Person() : speed = 0.0;
}

/// Output
// Person is jumping at the speed of 10.0
// Person is walking at the speed of 5.0
```

### Mixins and Function Parameters

```dart
void main(List<String> args) {
  final johnDoe = Person(firstName: 'John', lastName: 'Doe');
  print(johnDoe.fullName);
  print(getFullName(johnDoe));
}

String getFullName(HasFullName obj) => obj.fullName;

mixin HasFirstName {
  String get firstName;
}

mixin HasLastName {
  String get lastName;
}

mixin HasFullName on HasFirstName, HasLastName {
  String get fullName => '$firstName $lastName';
}

class Person with HasFirstName, HasLastName, HasFullName {
  @override
  final String firstName;

  @override
  final String lastName;

  Person({required this.firstName, required this.lastName});
}

/// Output
// John Doe
// John Doe
```

### Mixins with Logic

```dart
void main(List<String> args) {
  final whiskers = Cat(age: 2);
  print(whiskers.age);
  whiskers.incrementAge();
  print(whiskers.age);
}

mixin HasAge {
  abstract int age;
  void incrementAge() => age++;
}

class Cat with HasAge {
  @override
  int age = 0;
  Cat({required this.age});
}

/// Output
// 2
// 3
```

### Limiting Mixins to Data Types

Mixin on class

```dart
void main(List<String> args) {
  Human().run();
}

class Has2Feet {
  const Has2Feet();
}

class Human extends Has2Feet with CanRun {
  const Human();
}

mixin CanRun on Has2Feet {
  void run() {
    print('$runtimeType is running');
  }
}

class HasNoFeet {
  const HasNoFeet();
}

class Fish extends HasNoFeet {
  const Fish();
}

/// Output
// Human is running
```

### Mixins with hashCode Implementation

```dart
void main(List<String> args) {
  final cats = <Cat>{
    Cat(age: 2, name: 'Kitty 1'),
    Cat(age: 3, name: 'Kitty 2'),
    Cat(age: 2, name: 'Kitty 1'),
  };
  cats.forEach(print);
}

enum PetType { cat, dog }

mixin Pet {
  String get name;
  int get age;
  PetType get type;

  @override
  String toString() => 'Pet ($type), name = $name, age = $age';

  @override
  int get hashCode => Object.hash(name, age, type);

  @override
  bool operator ==(Object other) => other.hashCode == hashCode;
}

class Cat with Pet {
  @override
  final int age;

  @override
  final String name;

  @override
  final PetType type;

  Cat({required this.age, required this.name}) : type = PetType.cat;
}

/// Output
// Pet (PetType.cat), name = Kitty 1, age = 2
// Pet (PetType.cat), name = Kitty 2, age = 3
```

### Mixins and Reflection

These are usually not used in flutter

```dart
import 'dart:mirrors';

void main(List<String> args) {
  final person = Person(name: 'John', age: 30);
  print(person);
  final house = House(address: '123 Main St', rooms: 6);
  print(house);
}

mixin HasDescription {
  @override
  String toString() {
    final reflection = reflect(this);
    final thisType = MirrorSystem.getName(reflection.type.simpleName);
    final variables =
        reflection.type.declarations.values.whereType<VariableMirror>();

    final properties = <String, dynamic>{
      for (final field in variables)
        field.asKey: reflection.getField(field.simpleName).reflectee,
    }.toString();
    return '$thisType = $properties';
  }
}

extension AsKeyo on VariableMirror {
  String get asKey {
    final fieldName = MirrorSystem.getName(simpleName);
    final fieldType = MirrorSystem.getName(type.simpleName);
    return '$fieldName ($fieldType)';
  }
}

class Person with HasDescription {
  final String name;
  final int age;

  const Person({required this.name, required this.age});
}

class House with HasDescription {
  final String address;
  final int rooms;

  const House({required this.address, required this.rooms});
}

/// Output
// Person = {name (String): John, age (int): 30}
// House = {address (String): 123 Main St, rooms (int): 6}
```

### Mixins with Equality Implementation

Add the `uuid` package: `dart pub add uuid`

```dart
import 'package:uuid/uuid.dart';

void main(List<String> args) {
  final uuid1 = const Uuid().v4();
  final uuid2 = const Uuid().v4();

  final person1 = Person(id: uuid1, name: 'John', age: 30);
  final person1Again = Person(id: uuid1, name: 'john', age: 30);
  final person2 = Person(id: uuid2, name: 'John', age: 30);

  if (person1 == person2) {
    print('person1 and person2 are equal');
  } else {
    print('person1 and person2 are NOT equal');
  }

  if (person1 == person1Again) {
    print('person1 and person1Again are equal');
  } else {
    print('person1 and person1Again are NOT equal');
  }

  if (person1Again == person2) {
    print('person1Again and person2 are equal');
  } else {
    print('person1Again and person2 are NOT equal');
  }
}

mixin HasIdentifier {
  String get id;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HasIdentifier &&
          runtimeType == other.runtimeType &&
          id == other.id;
}

class Person with HasIdentifier {
  @override
  final String id;

  final String name;
  final int age;

  Person({required this.id, required this.name, required this.age});
}

/// Output
// person1 and person2 are NOT equal
// person1 and person1Again are equal
// person1Again and person2 are NOT equal
```
