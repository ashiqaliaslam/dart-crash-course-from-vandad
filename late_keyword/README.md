# Dart Course

## `late` keyword

### Lazy Initialisation and Error

```dart
late String name;

void main(List<String> args) {
  print(name);
}
// Output: 
// Failed 'name' has not been initialized.

void main(List<String> args) {
  try {
    print(name);
  } catch (e) {
    print(e);
  }
}
/// Output:
// LateInitializationError: Field 'name' has not been initialized.

void main(List<String> args) {
  try {
    print(name);
  } catch (e) {
    print(e);
  }
  name = 'Foo Bar';
  print(name);
}

/// Output: 
// LateInitializationError: Field 'name' has not been initialized.
// Foo Bar
```

### Lazy Initialisation to a Function

```dart
void main(List<String> args) {
  print('Before');
  late String name = provideName();
  print('After');
}

/// Output:

// Before
// After 

void main(List<String> args) {
  print('Before');
  String name = provideName();
  print('After');
}

/// Output:

// Before
// Function is called
// After

void main(List<String> args) {
  print('Before');
  String name = provideName();
  print('After');
  print(name);
}

///  Output:

// Before
// Function is called
// After
// Foo Bar

String provideName() {
  print('Function is called');
  return 'Foo Bar';
}

```

### `late` Variabls in Classes

```dart
import 'dart:async';

void main(List<String> args) {
  final person = Person();
  print(person.age);
}

/// Output:

// Construction is called
// 18

void main(List<String> args) {
  final person = Person();
  print(person.age);
  print(person.description);
}

/// Output:

// Construction is called
// 18
// Function "heavyCalculationOfDescription" is called
// Foo Bar

class Person {
  late String description = heavyCalculationOfDescription();
  final int age;

  Person({this.age = 18}) {
    print('Construction is called');
  }

  String heavyCalculationOfDescription() {
    print('Function "heavyCalculationOfDescription" is called');
    return 'Foo Bar';
  }
}

```

### `late` Variable Dependency

```dart
void main(List<String> args) {
  final person = Person();
  print(person.fullName);
}

class Person {
  String fullName = _getFullName();
  String _getFullName() {
    print('_getFullName() is called');
    return 'Foo Bar';
  }
}

/// Output:

// Error: Can't access 'this' in a field initializer to read '_getFullName'.
```

```dart
void main(List<String> args) {
  final person = Person();
  print(person.fullName);

}

class Person {
  late String fullName = _getFullName();
  String _getFullName() {
    print('_getFullName() is called');
    return 'Foo Bar';
  }
}

/// Output:

// _getFullName() is called
// Foo Bar
```

```dart
void main(List<String> args) {
  final person = Person();
  print(person.fullName);
  print(person.fullName);
  print(person.fullName);
}

class Person {
  late String fullName = _getFullName();
  String _getFullName() {
    print('_getFullName() is called');
    return 'Foo Bar';
  }
}

/// Output:

// _getFullName() is called
// Foo Bar
// Foo Bar
// Foo Bar
```

```dart
void main(List<String> args) {
  final person = Person();
  print(person.fullName);
  print(person.firstName);
  print(person.lastName);
}

class Person {
  late String fullName = _getFullName();
  late String firstName = fullName.split(' ').first;
  late String lastName = fullName.split(' ').last;
  String _getFullName() {
    print('_getFullName() is called');
    return 'Foo Bar';
  }
}

/// Output:

// _getFullName() is called
// Foo Bar
// Foo
// Bar

```

### Multiple Assignments of `late` Variables

```dart
void main(List<String> args) {
  final person = Person();
  person.description = 'Description 1';
  print(person.description);
}

class Person {
  late String description;
}

class Dog {
  late final String description;
}

/// Output:

// Desctiption 1
```

```dart
void main(List<String> args) {
  final person = Person();
  person.description = 'Description 1';
  print(person.description);
  person.description = 'Description 2';
  print(person.description);
}

class Person {
  late String description;
}

class Dog {
  late final String description;
}

/// Output:

// Description 1
// Description 2
```

```dart
void main(List<String> args) {
  final person = Person();
  person.description = 'Person 1';
  print(person.description);
  person.description = 'Person 2';
  print(person.description);

  final woof = Dog();
  woof.description = 'Woof 1';
  print(woof.description);

  try {
    woof.description = 'Woof 2';
    print(woof.description);
  } catch (e) {
    print(e);
  }
}

class Person {
  late String description;
}

class Dog {
  late final String description;
}

/// Output:

// Person 1
// Person 2
// Woof 1
// LateInitializationError: Field 'description' has already been initialized.
```

### Avoiding a Common Pitfall with `late` Variables

```dart
void main(List<String> args) {
  final person = Person();

  try {
    print(person.fullName);
  } catch (e) {
    print(e);
  }
}

class Person {
  late final String firstName;
  late final String lastName;
  late String fullName = '$firstName $lastName';
}

/// Output:
// LateInitializationError: Field 'firstName' has not been initialized.
```

```dart
void main(List<String> args) {
  final person = Person();

  try {
    // avoid doing this in real code since it's against
    // the recommendations. instead use nullable values
    print(person.fullName);
  } catch (e) {
    print(e);
  }

  person.firstName = 'Foo';
  person.lastName = 'Bar';
  print(person.fullName);
}

class Person {
  late final String firstName;
  late final String lastName;
  late String fullName = '$firstName $lastName';
}


/// Output:
// LateInitializationError: Field 'firstName' has not been initialized.
// Foo Bar
```

### Initializing `late final` Variables

```dart
void main(List<String> args) {
  late final bool isTeenager;
  const age = 12;
  if (age >= 13 && age <= 19) {
    isTeenager = true;
  } else if (age < 13) {
    isTeenager = false;
  }

  // Try maximum to avoid try and catch with late variables
  try {
    isTeenager = false;
    print('isTeenager = $isTeenager');
  } catch (e) {
    print(e);
  }
}

/// Output:
// LateInitializationError: Local 'isTeenager' has already been initialized.
```

### Assigning `late` Variables to Non late Variables

```dart
void main(List<String> args) {
  print('late fullName is being initialized');
  late final fullName = getFullName();
  print('after');
  print(fullName);
}

String getFullName() {
  print('getFullName() is called');
  return 'John Doe';
}

/// Output:

// late fullName is being initialized
// after
// getFullName() is called
// John Doe
```

```dart
void main(List<String> args) {
  print('late fullName is being initialized');
  late final fullName = getFullName();
  late final resolvedFullName = fullName;
  print('resolvedFullName = $resolvedFullName');
}

String getFullName() {
  print('getFullName() is called');
  return 'John Doe';
}

/// Output:

// late fullName is being initialized
// getFullName() is called
// resolvedFullName = John Doe
```

```dart
void main(List<String> args) {
  print('late fullName is being initialized');
  late final fullName = getFullName();
  final resolvedFullName = fullName;
  print('resolvedFullName = $resolvedFullName');
}

String getFullName() {
  print('getFullName() is called');
  return 'John Doe';
}

/// Output:

// late fullName is being initialized
// getFullName() is called
// resolvedFullName = John Doe
```

### Avoiding Constructor Initializing of `late` Variables

```dart
void main(List<String> args) {
  final johnDoe = Person(name: 'John Doe');
  final janeDoe = Person(name: 'Jane Doe');
  final doeFamily = WrongImplementationOfFamily(
    members: [janeDoe, janeDoe],
  );
}

class Person {
  final String name;

  Person({required this.name});
}

class WrongImplementationOfFamily {
  final Iterable<Person> members;
  late int membersCount;

  WrongImplementationOfFamily({required this.members}) {
    membersCount = getMembersCount();
  }

  int getMembersCount() {
    print('Getting members count');
    return members.length;
  }
}

/// Output:

// Getting members count
```

```dart
void main(List<String> args) {
  final johnDoe = Person(name: 'John Doe');
  final janeDoe = Person(name: 'Jane Doe');
  final doeFamily = WrongImplementationOfFamily(
    members: [janeDoe, janeDoe],
  );
  print(doeFamily);
  print(doeFamily.membersCount);

  final johnSmith = Person(name: 'John Smith');
  final janeSmith = Person(name: 'Jane Smith');
  final smithFamily = RightImplementationOfFamily(
    members: [johnSmith, janeSmith],
  );
  print(smithFamily);
  print(smithFamily.membersCount);
}

class Person {
  final String name;

  Person({required this.name});
}

class WrongImplementationOfFamily {
  final Iterable<Person> members;
  late int membersCount;

  WrongImplementationOfFamily({required this.members}) {
    membersCount = getMembersCount();
  }

  int getMembersCount() {
    print('Getting members count');
    return members.length;
  }
}

class RightImplementationOfFamily {
  final Iterable<Person> members;
  late int membersCount = getMembersCount();

  RightImplementationOfFamily({required this.members});

  int getMembersCount() {
    print('Getting members count');
    return members.length;
  }
}

/// Output:

// Getting members count
// Instance of 'WrongImplementationOfFamily'
// 2
// Instance of 'RightImplementationOfFamily'
// Getting members count
// 2
```
