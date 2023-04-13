# Dart Course

## Optionals in Dart

Create dart app `dart create -t console optionals`

Run fswatch `fswatch -o bin/ | xargs -n1 -I{} sh -c 'clear; dart bin/optionals.dart'`

### Optionality

```dart
void main(List<String> args) {
  const String? name = null;
  print(name);
  print(null);
}
/// Output
// null
// null
```

### Untyped Null Values

```dart
void main(List<String> args) {
  const someValue = null;
  print(someValue);
}
/// Output
// null
```

### Comparing Optionals

```dart
void main(List<String> args) {
  int? age = 20;
  age = null;
  print(age);
  if (age == null) {
    print('Age is null');
  } else {
    print('Age is not null');
  }
}
/// Output
// null
// Age is null
```

### Nullable default Values

```dart
void main(List<String> args) {
  String? lastName;
  lastName ??= 'Bar';
  print(lastName);
}
/// Output
// Bar
```

### Null Aware Operators

```dart
void main(List<String> args) {
  String? lastName;
  print(lastName?.length);

  String? nullName;

  print(lastName ?? 'Foo');
  print(lastName ?? nullName);
  print(lastName ?? nullName ?? 'Bar');
}
/// Output
// null
// Foo
// null
// Bar
```

### Nullable Collections

```dart
void main(List<String> args) {
  List<String?>? names;
  names?.add('Foo');
  names?.add(null);
  print(names);

  final String? first = names?.first;
  print(first ?? 'No first name found');

  names = [];
  names.add('Baz');
  names.add(null);
  print(names);
}
/// Output
// null
// No first name found
// [Baz, null]
```

### Force Unwrapping

```dart
void main(List<String> args) {
  try {
    final String? firstName = null;
    print(firstName!);
  } catch (error) {
    print(error);
  }
}
/// Output
// Null check operator used on a null value
```

### Nullable Type Promotion

```dart
void main(List<String> args) {
  final String? firstName = null;
  if (firstName == null) {
    print('firstNmae value is null');
  } else {
    final int length = firstName.length;
    print(length);
  }
}
/// Output
// firstNmae value is null
```

### Combining Null Aware Operators

```dart
void main(List<String> args) {
  String? lastName;

  void changeLastName() {
    lastName = 'Bar';
  }

  changeLastName();

  // This method is good as per Vandad
  if (lastName?.contains('Bar') ?? false) {
    print('Last name contains Bar');
  }

  // this method is working, but upper method is more logical
  if (lastName?.contains('Bar') == true) {
    print('Last name contains Bar');
  }
}
/// Output
// Last name contains Bar
// Last name contains Bar
```

### Extending Optinoal Types

```dart
void main(List<String> args) {
  String? getFullNameOptional() {
    return 'Foo Bar Optional';
    // return null;
  }

  String getFullName() {
    return 'Foo Bar';
  }

  final String fullName = getFullNameOptional() ?? getFullName();
  print(fullName);

  final someName = getFullNameOptional();
  someName.describe();
}

extension Describe on Object? {
  void describe() {
    if (this == null) {
      print('This object is null');
    } else {
      print('$runtimeType: $this');
    }
  }
}
/// Output
// Foo Bar Optional
// String: Foo Bar Optional
```

### Unwrapping Multiple Optionals

```dart
void main(List<String> args) {
  print(getFullName(null, null));
  print(getFullName('John', null));
  print(getFullName(null, 'Doe'));
  print(getFullName('John', 'Doe'));
}

String getFullName(
  String? firstName,
  String? lastName,
) =>
    withAll(
      [firstName, lastName],
      (names) => names.join(' '),
    ) ??
    'Empty';

T? withAll<T>(
  List<T?> optionals,
  T Function(List<T>) callback,
) =>
    optionals.any((e) => e == null) ? null : callback(optionals.cast<T>());
/// Output
// Empty
// Empty
// Empty
// John Doe
```

### Optional flatMap

```dart
void main(List<String> args) {
  String? firstName = 'John';
  String? lastName = 'Doe';

  final fullName = firstName.flatMap(
        (f) => lastName.flatMap(
          (l) => '$f $l',
        ),
      ) ??
      'Either first or last name or both are null';
  print(fullName);
}

extension FlatMap<T> on T? {
  R? flatMap<R>(
    R? Function(T) callback,
  ) {
    final shadow = this;
    if (shadow == null) {
      return null;
    } else {
      return callback(shadow);
    }
  }
}
/// Output
// John Doe
```

### Default Values for Optionals

```dart
void main(List<String> args) {
  print(fullName(null, null));
  print(fullName('John', null));
  print(fullName(null, 'Doe'));
  print(fullName('John', 'Doe'));
}

String fullName(
  String? firstName,
  String? lastName,
) =>
    '${firstName.orDefault} ${lastName.orDefault}';

extension Defaultvalues<T> on T? {
  T get orDefault {
    final shadow = this;
    if (shadow != null) {
      return shadow;
    }
    switch (T) {
      case int:
        return 0 as T;
      case double:
        return 0.0 as T;
      case String:
        return '' as T;
      case bool:
        return false as T;
      default:
        throw Exception('No default value for type $T');
    }
  }
}
/// Output
// 
// John 
//  Doe
// John Doe
```
