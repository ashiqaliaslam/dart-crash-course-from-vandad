# Dart Course

## Control Flow in Dart

Create dart app `dart create -t controlflow`

### If and Else

```dart
void main(List<String> args) {
  const yourName = 'Foo';
  const myName = 'Bar';

  if (yourName == myName) {
    print('We have the same name!');
  } else if (yourName == 'Foo') {
    print('Hello, Foo!');
  } else if (yourName == 'Foo' && myName == 'Bar') {
    print('I am Foo and you are Bar');
  } else {
    print('Something else');
  }
}

/// Output:
// Hello, Foo!
```

### Classic For Loops

```dart
void main(List<String> args) {
  const names = ['Foo', 'Bar', 'Baz', 'Qux'];
  for (var i = 0; i < names.length; i++) {
    print(names[i]);
  }

/// Output:
// Foo
// Bar
// Baz
// Qux

  for (var i = names.length - 1; i >= 0; i--) {
    print(names[i]);
  }

/// Output:
// Qux
// Baz
// Bar
// Foo

  for (var i = 0; i < names.length; i += 2) {
    print(names[i]);
  }
}

/// Output:
// Foo
// Baz
```

### Modern For Loops

```dart
void main(List<String> args) {
  const names = ['Foo', 'Bar', 'Baz', 'Qux'];

  for (final name in names) {
    print(name);
  }

/// Output:
// Foo
// Bar
// Baz
// Qux

  for (final name in names) {
    if (name.startsWith('B')) {
    } else {
      print(name);
    }
  }

/// Output:
// Foo
// Qux

  for (final name in names) {
    if (!name.startsWith('B')) {
      print(name);
    }
  }

/// Output:
// Foo
// Qux

  for (final name in names) {
    if (name.startsWith('B')) {
      continue;
    }
    print(name);
  }

/// Output:
// Foo
// Qux

  for (final name in names) {
    if (name == 'Baz') {
      break;
    }
    print(name);
  }

/// Output:
// Foo
// Bar

  for (final name in names) {
    if (name == 'Qux') {
      continue; // it even now breaks the loop because it is last item
    }
    print(name);
  }

/// Output:
// Foo
// Bar
// Baz

  for (final name in names.reversed) {
    print(name);
  }

/// Output:
// Qux
// Baz
// Bar
// Foo

  for (int value in Iterable.generate(5)) {
    print(value);
  }

/// Output:
//   0
// 1
// 2
// 3
// 4
}
```

### While Loops

Most recommended method

```dart
void main(List<String> args) {
  const names = ['John', 'Paul', 'George', 'Ringo'];
  var counter = 0;
  while (counter < names.length) {
    print(names[counter]);
    counter++;
  }
}

/// Output:
// John
// Paul
// George
// Ringo
```

```dart
void main(List<String> args) {
  const names = ['John', 'Paul', 'George', 'Ringo'];
  var counter = 0;
  while (counter < names.length) {
    print(names[counter++]);
  }
}

/// Output:
// John
// Paul
// George
// Ringo
```

```dart
void main(List<String> args) {
  const names = ['John', 'Paul', 'George', 'Ringo'];
  var counter = -1;
  while (++counter < names.length) {
    print(names[counter]);
  }
}

/// Output:
// John
// Paul
// George
// Ringo
```

Reverse order

```dart
void main(List<String> args) {
  const names = ['John', 'Paul', 'George', 'Ringo'];
  var counter = names.length;
  while (--counter >= 0) {
    print(names[counter]);
  }
}

/// Output:
// Ringo
// George
// Paul
// John
```

```dart
void main(List<String> args) {
  const names = ['John', 'Paul', 'George', 'Ringo'];
  var counter = 0;
  do {
    print(names[counter++]);
  } while (counter < names.length);
}

/// Output:
// John
// Paul
// George
// Ringo
```

```dart
void main(List<String> args) {
  const names = ['John', 'Paul', 'George', 'Ringo'];
  var counter = 0;
  do {
    print(names[counter++]);
    if (counter == 2) {
      break;
    }
  } while (counter < names.length);
}

/// Output:
// John
// Paul
```

```dart
void main(List<String> args) {
  const names = ['John', 'Paul', 'George', 'Ringo'];
  var counter = 0;
  do {
    final name = names[counter++];
    if (name == 'George') {
      continue;
    }
    print(name);
  } while (counter < names.length);
}

/// Output:
// John
// Paul
// Ringo
```

### Switch Statement

Switch statement must should cover all possible cases.

```dart
void main(List<String> args) {
  describe(1);
  describe(1.1);
  describe('Hello');
  describe(true);
  describe({'key': 'value'});
  describe([1, 2, 3, 4]);
}

void describe<T>(T value) {
  switch (T) {
    case int:
      print('This is an integer');
      break;
    case double:
      print('This is a double');
      break;
    case String:
      print('This is a string');
      break;
    case bool:
      print('This is a boolean');
      break;
    case Map<String, String>:
      print('This is a map');
      break;
    default:
      print('This is something else');
      break;
  }
}

/// Output:
// This is an integer
// This is a double
// This is a string
// This is a boolean
// This is a map
// This is something else
```

### For Loop over Map

```dart
void main(List<String> args) {
  const info = {
    'name': 'John',
    'age': 30,
    'height': 1.8,
    'isMarried': false,
    'address': {
      'street': 'Main Street',
      'city': 'New York',
      'country': 'USA',
    },
  };

// access `entries` in map to loop over
  for (final entry in info.entries) {
    print('${entry.key}: ${entry.value}');
  }
}

/// Output:
// name: John
// age: 30
// height: 1.8
// isMarried: false
// address: {street: Main Street, city: New York, country: USA}
```

### Switching Over Integer Values

```dart
import 'dart:io';

void main(List<String> args) {
  do {
    stdout.write('Enter your age or type "exit": ');
    final input = stdin.readLineSync();
    if (input == 'exit') {
      break;
    } else if ((input?.length ?? 0) == 0 || input == null) {
      stdout.writeln('Invalid age. Try again!');
      continue;
    }

    final age = int.tryParse(input);

    if (age == null) {
      stdout.writeln('Invalid age. Try again!');
      continue;
    }

    switch (age) {
      case 10:
        stdout.writeln('You are 10 years old. Great!');
        break;
      case 20:
        stdout.writeln('You are 20 years old. Still very young!');
        break;
      case 30:
        stdout.writeln('You are 30 years old. You are an adult!');
        break;
      default:
        stdout.writeln('You are $age years old');
        break;
    }
  } while (true);
}
```

### Switching Over String Values

```dart
import 'dart:io';

void main(List<String> args) {
  do {
    stdout.write('Enter your name or type "exit": ');
    final input = stdin.readLineSync();
    if (input == 'exit') {
      break;
    } else if ((input?.length ?? 0) == 0 || input == null) {
      stdout.writeln('Invalid name. Try again!');
      continue;
    }

    switch (input.toLowerCase()) {
      case 'john':
      case 'jane':
        stdout.writeln('Hello $input. You have a great name!');
        break;
      default:
        stdout.writeln('Hello $input');
        break;
    }
  } while (true);
}
```
