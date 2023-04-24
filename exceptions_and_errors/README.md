# Dart Course

## Exceptions and Errors in Dart

Create dart app `dart create -t console exceptions_and_errors`

Run fswatch
`fswatch -o bin/ | xargs -n1 -I{} sh -c 'clear; dart bin/exceptions_and_errors.dart'`

__Exceptions__: Exceptions are menat to be caught, so an exception is something
that you cannot plan

__Errors__: Errors are not meant to be caught

### Throwing in Class Constructors

```dart
void main(List<String> args) {
  tryCreatingPerson(age: 20);
  // 20

  tryCreatingPerson(age: -1);
  // _Exception
  // Exception: Age must be positive

  tryCreatingPerson(age: 141);
  // String
  // Age must be less than 140
}

void tryCreatingPerson({int age = 0}) {
  try {
    print(Person(age: age).age);
  } catch (e) {
    print(e.runtimeType);
    print(e);
  }
}

class Person {
  final int age;

  Person({required this.age}) {
    if (age < 0) {
      throw Exception('Age must be positive');
    } else if (age > 140) {
      throw 'Age must be less than 140';
    }
  }
}
```

### Custom Exception Class

```dart
void main(List<String> args) {
  tryCreatingPerson(age: 20);
  // 20

  tryCreatingPerson(age: -1);
  // InvalidAgeException, Age cannot be negative, -1
  // #0      new Person (file:///Users/ali/001%20Flutter/dart-cras...
  // #1      tryCreatingPerson (file:///Users/ali/001%20Fl...
  // #2      main (file:///Users/ali/001%20Flutter/dart-cr...
  // #3      _delayEntrypointInvocation.<anonymous closure> ...
  // #4      _RawReceivePortI

  tryCreatingPerson(age: 141);
  // InvalidAgeException, Age cannot be greater than 140, 141
  // #0      new Person (file:///Users/ali/001%20Flutter/dart-cra...
  // #1      tryCreatingPerson (file:///Users/ali/001%20Flutter/d...
  // #2      main (file:///Users/ali/001%20Flutter/dart-crash-cou...
  // #3      _delayEntrypointInvocation.<anonymous closure> (dart...
  // #4      _RawReceivePortImpl._handleMessage (dart:isolate-...
}

void tryCreatingPerson({int age = 0}) {
  try {
    print(Person(age: age).age);
    // strakTrack is like unwinding of the stack right before the exception
    // happened, so you can actuallyhave a look at the function that caused this
  } on InvalidAgeException catch (exception, strackTrace) {
    print(exception);
    print(strackTrace);
  }
}

class InvalidAgeException implements Exception {
  final int age;
  final String message;

  InvalidAgeException(this.age, this.message);

  @override
  String toString() => 'InvalidAgeException, $message, $age';
}

class Person {
  final int age;

  Person({required this.age}) {
    if (age < 0) {
      throw InvalidAgeException(age, 'Age cannot be negative');
    } else if (age > 140) {
      throw InvalidAgeException(age, 'Age cannot be greater than 140');
    }
  }
}
```

### Rethrow

```dart
void main(List<String> args) {
  try {
    tryCreatingPerson(age: 20);
    tryCreatingPerson(age: -1);
    tryCreatingPerson(age: 141);
  } catch (error, stackTrack) {
    print(error);
    print(stackTrack);
  }
}

void tryCreatingPerson({int age = 0}) {
  try {
    print(Person(age: age).age);
  } on InvalidAgeException {
    rethrow;
  }
}

class InvalidAgeException implements Exception {
  final int age;
  final String message;

  InvalidAgeException(this.age, this.message);

  @override
  String toString() => 'InvalidAgeException, $message, $age';
}

class Person {
  final int age;

  Person({required this.age}) {
    if (age < 0) {
      throw InvalidAgeException(age, 'Age cannot be negative');
    } else if (age > 140) {
      throw InvalidAgeException(age, 'Age cannot be greater than 140');
    }
  }
}

/// Output
// 20
// InvalidAgeException, Age cannot be negative, -1
// #0      new Person (file:///Users/ali/001%20Flutter/dart-crash-...
// #1      tryCreatingPerson (file:///Users/ali/001%20Flutter/...
// #2      main (file:///Users/ali/001%20Flutter/dart-crash-...
// #3      _delayEntrypointInvocation.<anonymous closure> (...
// #4      _RawReceivePortImpl._handleMessage (dart:isolate-...
```

### Finally

```dart
void main(List<String> args) async {
  final db = Database();
  try {
    // await db.open();
    await db.getData();
  } on DatabaseNotOpenException {
    print('We forgot to open the database');
  } finally {
    await db.close();
  }
}

class Database {
  bool _isDbOpen = false;

  Future<void> open() {
    return Future.delayed(Duration(seconds: 1), () {
      _isDbOpen = true;
      print('Database opened');
    });
  }

  Future<String> getData() {
    if (!_isDbOpen) {
      throw DatabaseNotOpenException();
    }
    return Future.delayed(Duration(seconds: 1), () => 'Data');
  }

  Future<void> close() {
    return Future.delayed(Duration(seconds: 1), () {
      _isDbOpen = false;
      print('Database closed');
    });
  }
}

class DatabaseNotOpenException implements Exception {
  @override
  String toString() => 'DatabaseNotOpenException';
}

/// Output
// We forgot to open the database
// Database closed
```

### Custom Throws Annotation

```dart
void main(List<String> args) {
  try {
    print('Dog aged 11 is going to run...');
    Dog(age: 11, isTired: false).run();
  } catch (e) {
    print(e);
  }
  try {
    print('A tired dog is going to run...');
    Dog(age: 2, isTired: true).run();
  } catch (e) {
    print(e);
  }
}

class Throws<T> {
  final List<T> exceptions;

  const Throws(this.exceptions);
}

class DogIsTooOldException implements Exception {
  const DogIsTooOldException();
}

class DogIsTiredException implements Exception {
  const DogIsTiredException();
}

class Animal {
  final int age;

  const Animal({required this.age});

  @Throws([UnimplementedError])
  void run() => throw UnimplementedError();
}

class Dog extends Animal {
  final bool isTired;

  const Dog({required super.age, required this.isTired});

  @Throws([DogIsTooOldException, DogIsTiredException])

  /// This function throws the following exceptions:
  /// - [DogIsTooOldException] if the dog is older than 10 years old,
  /// - [DogIsTiredException] if the dog is tired.
  @override
  void run() {
    if (age > 10) {
      throw const DogIsTooOldException();
    } else if (isTired) {
      throw const DogIsTiredException();
    } else {
      print('Dog is running');
    }
  }
}

/// Output
// Dog aged 11 is going to run...
// Instance of 'DogIsTooOldException'
// A tired dog is going to run...
// Instance of 'DogIsTiredException'
```

### Throwing Errors

```dart
void main(List<String> args) {
  final person = Person(age: 10);
  print(person);
  person.age = 0;
  print(person);

  try {
    /// errors are not created to be caught, so if you get an error
    /// make sure that you change your program in order to avoid that error
    /// exceptions however are meant to be caught
    person.age = -1;
    print(person);
  } catch (e) {
    print(e);
  } finally {
    print(person);
  }
}

class Person {
  int _age;

  Person({required int age}) : _age = age;

  int get age => _age;

  set age(int value) {
    if (value < 0) {
      throw ArgumentError('Age cannot be negative.');
    }
    _age = value;
  }

  @override
  String toString() => 'Person(age: $age)';
}

/// Output
// Person(age: 10)
// Person(age: 0)
// Invalid argument(s): Age cannot be negative.
// Person(age: 0)
```

### Capturing Stack Trace

```dart
void main(List<String> args) {
  Dog(isTired: false).run();
  try {
    Dog(isTired: true).run();
  } catch (e, stackTrace) {
    print(e);
    print(stackTrace);
  }
}

class DogIsTiredException implements Exception {
  final String message;

  DogIsTiredException([this.message = 'Poor doggy is tired']);
}

class Dog {
  final bool isTired;

  const Dog({required this.isTired});

  void run() {
    if (isTired) {
      throw DogIsTiredException('Poor doggo is tired');
    } else {
      print('Doggo is running');
    }
  }
}

/// Output
// Doggo is running
// Instance of 'DogIsTiredException'
// #0      Dog.run (file:///Users/ali/001%20Flutter/dart-crash-cour...
// #1      main (file:///Users/ali/001%20Flutter/dart-crash-course-f...
// #2      _delayEntrypointInvocation.<anonymous closure> (dart:iso...
// #3      _RawReceivePortImpl._handleMessage (dart:isolate-patch/is...
```
