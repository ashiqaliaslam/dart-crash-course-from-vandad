# Dart Course

## Classes in Dart

Create dart app `dart create -t console classes`

Run fswatch `fswatch -o bin/ | xargs -n1 -I{} sh -c 'clear; dart bin/classes.dart'`

### Simple Classes

Classes are blueprints

```dart
void main(List<String> arguments) {
  const person1 = Person(
    name: 'Foo',
    age: 20,
  );

  print(person1.name);
  print(person1.age);
}

class Person {
  final String name;
  final int age;

  const Person({
    required this.name,
    required this.age,
  });
}

/// Output
// Foo
// 20
```

### Constructors

```dart
void main(List<String> arguments) {
  const me = Person('Bob', 20);
  print(me.name);
  print(me.age);
}

class Person {
  final String name;
  final int age;

  const Person(
    this.name,
    this.age,
  );
}

/// Output
// Bob
// 20
```

```dart
void main(List<String> arguments) {
  const me = Person('Bob', 20);
  print(me.name);
  print(me.age);
  // Bob
  // 20

  const foo = Person.foo();
  print(foo.name);
  print(foo.age);
  // Foo
  // 20

  const bar = Person.bar(30);
  print(bar.name);
  print(bar.age);
  // Bar
  // 30

  const baz = Person.other();
  print(baz.name);
  print(baz.age);
  // Baz
  // 30

  const john = Person.other(name: 'John');
  print(john.name);
  print(john.age);
  // John
  // 30

  const jill = Person.other(name: 'Jill', age: 40);
  print(jill.name);
  print(jill.age);
  // Jill
  // 40
}

class Person {
  final String name;
  final int age;

  const Person(
    this.name,
    this.age,
  );

  // create a fixed constructor "Person.foo()"
  const Person.foo()
      : name = 'Foo',
        age = 20;

  // constructor accepts one parameter and one default
  const Person.bar(this.age) : name = 'Bar';

  // constructor with optional arguments
  const Person.other({
    String? name,
    int? age,
  })  : name = name ?? 'Baz', // name is name if available otherwise 'Baz'
        age = age ?? 30; // age is age if available otherwise '30'
}
```

### Subclassing

```dart
void main(List<String> args) {
  final v = Vehicle(4);
  print(v); // print function uses toString for print
  print(v.toString());
}

class Vehicle {
  final int wheelCount;
  const Vehicle(this.wheelCount);
}

/// Output
// Instance of 'Vehicle'
// Instance of 'Vehicle'
```

```dart
void main(List<String> args) {
  final v = Vehicle(4);
  print(v);
  print(v.toString());
}

class Vehicle {
  final int wheelCount;
  const Vehicle(this.wheelCount);

  // PROBLEMS: Annotate overridden members.
  String toString() {
    return 'Bla';
  }
}

/// Output
// Bla
// Bla
```

```dart
void main(List<String> args) {
  final v = Vehicle(4);
  print(v);
  print(v.toString());
}

class Vehicle {
  final int wheelCount;
  const Vehicle(this.wheelCount);

  @override // Problem finished
  String toString() {
    return 'Bla';
  }
}

/// Output
// Bla
// Bla
```

How to override a function  that comes from a super class

```dart
void main(List<String> args) {
  final v = Vehicle(4);
  print(v);
  print(v.toString());
}

class Vehicle {
  final int wheelCount;
  const Vehicle(this.wheelCount);

  // This is how to override a function  that comes from a super class
  @override
  String toString() {
    return '$runtimeType with $wheelCount wheels';
  }
}

/// Output
// Vehicle with 4 wheels
// Vehicle with 4 wheels
```

Creating a subclass

```dart
void main(List<String> args) {
  final v = Vehicle(4);
  print(v);
  print(v.toString());
}

class Vehicle {
  final int wheelCount;
  const Vehicle(this.wheelCount);

  @override
  String toString() {
    return '$runtimeType with $wheelCount wheels';
  }
}

// Creating a subclass
class Car extends Vehicle {
  const Car();
}

/// Output

// PROBLEM:
// The implicitly invoked unnamed constructor from 'Vehicle' has 
// required parameters.
// Try adding an explicit super parameter with the required arguments.
```

Because Car() is calling Vehicle() under the hood but wheelCount is not present
so manually pass it super() constructor  with a manual value

```dart
// Passing super class constructor arguments to a subclass
void main(List<String> args) {
  final v = Vehicle(4);
  print(v);
  print(v.toString());
}

class Vehicle {
  final int wheelCount;
  const Vehicle(this.wheelCount);

  @override
  String toString() {
    return '$runtimeType with $wheelCount wheels';
  }
}

// Creating a subclass
class Car extends Vehicle {
  const Car() : super(4);
}

/// Output
// Vehicle with 4 wheels
// Vehicle with 4 wheels
```

Alternate method but here wheelCount is equal to super class

```dart
void main(List<String> args) {
  final v = Vehicle(4);
  print(v);
  print(v.toString());
}

class Vehicle {
  final int wheelCount;
  const Vehicle(this.wheelCount);

  @override
  String toString() {
    return '$runtimeType with $wheelCount wheels';
  }
}

class Car extends Vehicle {
  const Car(super.wheelCount);
}

/// Output
// Vehicle with 4 wheels
// Vehicle with 4 wheels
```

```dart
void main(List<String> args) {
  final v = Vehicle(4);
  print(v);
  print(v.toString());

  print(Car());
  print(Bicycle());
}

class Vehicle {
  final int wheelCount;
  const Vehicle(this.wheelCount);

  @override
  String toString() {
    return '$runtimeType with $wheelCount wheels';
  }
}

class Car extends Vehicle {
  const Car() : super(4);
}

class Bicycle extends Vehicle {
  const Bicycle() : super(2);
}

/// Output
// Vehicle with 4 wheels
// Vehicle with 4 wheels
// Car with 4 wheels
// Bicycle with 2 wheels
```

lets do something funny

```dart
void main(List<String> args) {
  final v = Vehicle(4);
  print(v);
  print(v.toString());

  print(Car());
  print(Bicycle());
}

class Vehicle {
  final int wheelCount;
  const Vehicle(this.wheelCount);

  @override
  String toString() {
    if (runtimeType == Vehicle) {
      return '$runtimeType with $wheelCount wheels';
    } else {
      // you can access super class by using super keyword
      return super.toString();
    }
  }
}

class Car extends Vehicle {
  const Car() : super(4);
}

class Bicycle extends Vehicle {
  const Bicycle() : super(2);
}

/// Output
// Vehicle with 4 wheels
// Vehicle with 4 wheels
// Instance of 'Car'
// Instance of 'Bicycle'
```

### Getters in Classes

Example before getter

```dart
void main(List<String> args) {
  const foo = Person(firstName: 'Foo', lastNamel: 'Bar', fullName: 'Foo Bar');
  print(foo.fullName);
}

class Person {
  final String firstName;
  final String lastNamel;

  final String fullName;

  const Person({
    required this.firstName,
    required this.lastNamel,
    required this.fullName,
  });
}

/// Output
// Foo Bar
```

One way of doing this by Constructor with an initializer that is sending
the full name to the value of first and last

```dart
void main(List<String> args) {
  const foo = Person(firstName: 'Foo', lastNamel: 'Bar');
  print(foo.fullName);
}

class Person {
  final String firstName;
  final String lastNamel;
  final String fullName;

  const Person({
    required this.firstName,
    required this.lastNamel,
  }) : fullName = '$firstName $lastNamel';
}

/// Output
// Foo Bar
```

Other way is using getter which calculates each time when `fullName` is called

Note: If there is heavy calculation the may be putting in initializerlist
is more good way.

```dart
void main(List<String> args) {
  const foo = Person(firstName: 'Foo', lastName: 'Bar');
  print(foo.fullName);
}

class Person {
  final String firstName;
  final String lastName;
  String get fullName => '$firstName $lastName';

  const Person({
    required this.firstName,
    required this.lastName,
  });
}

/// Output
// Foo Bar
```

### Methods

```dart
void main(List<String> args) {
  final car = Car();
  car.drive(speed: 20);
  print('Speed is ${car.speed}');
  car.drive(speed: 40);
  car.stop();
}

class Car {
  int speed = 0;

  void drive({required int speed}) {
    this.speed = speed;
    print('Accelerating to $speed km/h');
  }

  void stop() {
    speed = 0;
    print('Stopping...');
    print('Stopped');
  }
}

/// Output
// Accelerating to 20 km/h
// Speed is 20
// Accelerating to 40 km/h
// Stopping...
// Stopped
```

### Setters in Classes

```dart
void main(List<String> args) {
  final car = Car();
  try {
    car.drive(speed: 10);
    car.drive(speed: -1);
  } catch (e) {
    print(e);
  }
}

class Car {
  int _speed = 0; // private property

  int get speed => _speed;

  set speed(int newSpeed) {
    if (newSpeed < 0) {
      throw Exception('Speed cannot be negative');
    } else {
      _speed = newSpeed;
    }
  }

  void drive({required int speed}) {
    this.speed = speed;
    print('Accelerating to $speed km/h');
  }

  void stop() {
    speed = 0;
    print('Stopping...');
    print('Stopped');
  }
}

/// Output
// Accelerating to 10 km/h
// Exception: Speed cannot be negative
```

### Static Properties and Static Methods

Here copies of class does not affected

```dart
void main(List<String> args) {
  final foo = Person();
  foo.name = 'Foo';
  final bar = Person();
  bar.name = 'Bar';
  print(foo.name);
  print(bar.name);
}

class Person {
  String name = '';
}

/// Output
// Foo
// Bar
```

In static property, anyone who changes it, it will be affected in all copies
of that class

```dart
void main(List<String> args) {
  final foo = Person();
  foo.name = 'Foo';
  final bar = Person();
  bar.name = 'Bar';
  print(foo.name);
  print(bar.name);
}

class Person {
  static String name = '';
}

/// Output
// Error: The getter 'name' isn't defined for the class 'Person'.
//  - 'Person' is from 'bin/classes.dart'.
// Try correcting the name to the name of an existing getter, or defining 
// a getter or field named 'name'.
```

Right way

```dart
void main(List<String> args) {
  Person.name = 'Foo';
  print(Person.name);
  Person.name = 'Baz';
  print(Person.name);
}

class Person {
  static String name = '';
}

/// Output
// Foo
// Baz
```

Just example that shouldn't do, it is only to show how `static` works

```dart
void main(List<String> args) {
  print(Car.carsInstantiated);
  Car(name: 'My Car');
  print(Car.carsInstantiated);
  Car(name: 'Your Car');
  print(Car.carsInstantiated);
}

class Car {
  static int _carInstantiated = 0;
  static int get carsInstantiated => _carInstantiated;
  static void _incrementCarsInstantiated() => _carInstantiated++;

  final String name;
  Car({required this.name}) {
    _incrementCarsInstantiated();
  }
}

/// Output
// 0
// 1
// 2
```

### Factory Constructors

* __Normal Constructor__ of a class can only create an instance of that class
  in question
* __Factory Constructor__ can create an instance of subclasses which is
  its main power

```dart
void main(List<String> args) {
  final myCar = Car();
  print(myCar);

  print(Vehicle.car());
  print(Vehicle.truck());
}

class Vehicle {
  const Vehicle();

  // factory constructor can create instance of subclasses
  factory Vehicle.car() => Car();
  factory Vehicle.truck() => Truck();

  @override
  String toString() => 'Vehicle of type $runtimeType';
}

class Car extends Vehicle {
  const Car();
}

class Truck extends Vehicle {
  const Truck();
}

/// Output
// Vehicle of type Car
// Vehicle of type Car
// Vehicle of type Truck
```

### Inheriting Constructors

```dart
void main(List<String> args) {
  final mom = Mom();
  print(mom.role);
  final dad = Dad();
  print(dad.role);
}

enum Role { mom, dad, son, daughter, grandpa, grandma }

class Person {
  final Role role;

  const Person({required this.role});
}

class Mom extends Person {
  const Mom() : super(role: Role.mom);
}

class Dad extends Person {
  const Dad() : super(role: Role.dad);
}

/// Output
// Role.mom
// Role.dad
```

### Abstract Classes

Abstract classes are blueprint of blueprint

There are two ways are using abstract classes

1. Extending
2. Implementing

__Extending__: Extending an abstract class means to copy all of its abstract
methods and properties.

__Implement__: Implementing an abstract class means to re-implement all of its
abstract methods and properties.

```dart
void main(List<String> args) {
  const car = Car();
  print(car);
  print(car.kind);
  car.accelerate();
  car.decelerate();

  const motorcycle = Motorcycle();
  print(motorcycle);
  print(motorcycle.kind);
  motorcycle.accelerate();
  motorcycle.decelerate();
}

abstract class Vehicle {
  final VehicleKind kind;

  const Vehicle({required this.kind});

  void accelerate() => print('$kind is accelerating');
  void decelerate() => print('$kind is decelerating');
}

class Car extends Vehicle {
  const Car() : super(kind: VehicleKind.car);
}

class Motorcycle implements Vehicle {
  const Motorcycle();
  @override
  void accelerate() => print('Motorcycle is accelerating');
  @override
  void decelerate() => print('Motorcycle is decelerating');
  @override
  VehicleKind get kind => VehicleKind.motorcycle;
}

enum VehicleKind { car, truck, motorcycle, bicycle }
```
