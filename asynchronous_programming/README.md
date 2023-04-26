# Dart Course

## Asynchronous Programming in Dart

Create dart app `dart create -t console asynchronous_programming`

Run fswatch
`fswatch -o bin/ | xargs -n1 -I{} sh -c 'clear; dart bin/asynchronous_programming.dart'`

Future are pieces of functionality that will complete their work in the future

### Future

```dart
void main(List<String> args) {
  print(getUserName());
}

String getUserName() => 'John Doe';

/// Output
// John Doe
```

```dart
void main(List<String> args) {
  print(getUserName());
}

Future<String> getUserName() async => 'John Doe';

/// Output
// Instance of 'Future<String>'
```

```dart
void main(List<String> args) async {
  print(await getUserName());
}

Future<String> getUserName() async => 'John Doe';

/// Output
// John Doe
```

```dart
void main(List<String> args) async {
  print(await getUserName());
  print(await getAddress());
  print(await getPhoneNumber());
  print(await getCity());
  print(await getZipCode());
}

Future<String> getUserName() async => 'John Doe';
Future<String> getAddress() => Future.value('123 Main St');

Future<String> getPhoneNumber() => Future.delayed(
      const Duration(seconds: 1),
      () => '555-555-555',
    );

Future<String> getCity() async {
  await Future.delayed(const Duration(seconds: 1));
  return 'New York';
}

// async keyword doesn't really contribute with anything here
Future<String> getZipCode() async => Future.delayed(
      const Duration(seconds: 1),
      () => '12345',
    );

/// Output
// 123 Main St
// 555-555-555
// New York
// 12345
```

### Future Error Handling

```dart
void main(List<String> args) async {
  try {
    print(await getFullName(firstName: 'John', lastName: 'Doe'));

    print(await getFullName(firstName: '', lastName: 'Doe'));
  } on FirstOrLastNameMissingException {
    print('First or Last name is missing');
  }
}

Future<String> getFullName({
  required String firstName,
  required String lastName,
}) {
  if (firstName.isEmpty || lastName.isEmpty) {
    throw FirstOrLastNameMissingException();
  } else {
    return Future.value('$firstName $lastName');
  }
}

class FirstOrLastNameMissingException implements Exception {
  const FirstOrLastNameMissingException();
}

/// Output
// John Doe
// First or Last name is missing
```

### Future Chaining

Future chaining means Future in a Future

```dart
void main(List<String> args) async {
  // both following methods are similar
  final length = await calculateLength(await getFullName());
  print(length);

  final length1 = await getFullName().then((value) => calculateLength(value));
  print(length1);
}

Future<String> getFullName() => Future.delayed(
      const Duration(seconds: 1),
      () => 'John Doe',
    );

Future<int> calculateLength(String value) => Future.delayed(
      const Duration(seconds: 1),
      () => value.length,
    );

```

### Stream

Future => |------ 1 SEC ------- X |
Stream => |------ 1 SEC --- X ------ 1 SEC ---- XXX |

```dart
void main(List<String> args) async {
  await for (final number in getNumbers()) {
    print(number);
  }

  try {
    await for (final name in getNames()) {
      print(name);
    }
  } catch (e) {
    print(e);
  }
}

Stream<int> getNumbers() async* {
  for (var i = 0; i < 10; i++) {
    await Future.delayed(const Duration(seconds: 1));
    yield i;
  }
}

Stream<String> getNames() async* {
  await Future.delayed(const Duration(seconds: 1));
  yield 'John';
  throw Exception('Something went wrong');
  // yield 'Doe'; // Dead Code, cannot yield after throwing an exception
}

/// Output
// 0
// 1
// 2
// 3
// 4
// 5
// 6
// 7
// 8
// 9
// John
// Exception: Something went wrong
```

### Stream.asyncExpand

For every value that a stream produce, you can create another stream

```dart
void main(List<String> args) async {
  await for (final character
      in getNames().asyncExpand((name) => getCharacters(name))) {
    print(character);
  }
}

Stream<String> getCharacters(String fromString) async* {
  for (var i = 0; i < fromString.length; i++) {
    await Future.delayed(Duration(milliseconds: 300));
    yield fromString[i];
  }
}

Stream<String> getNames() async* {
  await Future.delayed(Duration(milliseconds: 200));
  yield 'John';
  await Future.delayed(Duration(milliseconds: 200));
  yield 'Doe';
}

/// Output
// J
// o
// h
// n
// D
// o
// e
```

### Stream.reduce

```dart
void main(List<String> args) async {
  int sum = 0;
  await for (final age in getAllAges()) {
    sum += age;
  }
  print(sum);
}

Stream<int> getAllAges() async* {
  yield 10;
  yield 20;
  yield 30;
  yield 40;
  yield 50;
}
/// Output
// 150
```

Using reduce function

```dart
void main(List<String> args) async {
  final sum = await getAllAges().reduce(add);
  print('Sum of all numbers is $sum');
}

int add(int a, int b) => a + b;

Stream<int> getAllAges() async* {
  yield 10;
  yield 20;
  yield 30;
  yield 40;
  yield 50;
}
/// Output
// Sum of all numbers is 150
```

### Asynchronous Generators

```dart
void main(List<String> args) async {
  await for (final value in numbers()) {
    print(value);
  }
  print('--------------------');
  await for (final value in numbers(end: 10, f: evenNumbersOnly)) {
    print(value);
  }
  print('--------------------');
  await for (final value in numbers(end: 10, f: oddNumbersOnly)) {
    print(value);
  }
}

typedef IsIncluded = bool Function(int value);

bool evenNumbersOnly(int value) => value % 2 == 0;
bool oddNumbersOnly(int value) => value % 2 != 0;

Stream<int> numbers({
  int start = 0,
  int end = 4,
  IsIncluded? f,
}) async* {
  for (var i = start; i < end; i++) {
    if (f == null || f(i)) {
      yield i;
    }
  }
}
/// Output
// 0
// 1
// 2
// 3
// --------------------
// 0
// 2
// 4
// 6
// 8
// --------------------
// 1
// 3
// 5
// 7
// 9
```

### Yielding Streams

```dart
void main(List<String> args) async {
  await for (final name in allNames()) {
    print(name);
  }
}

Stream<String> maleNames() async* {
  yield 'John';
  yield 'Peter';
  yield 'Paul';
}

Stream<String> femaleName() async* {
  yield 'Mary';
  yield 'Jane';
  yield 'Sue';
}

Stream<String> allNames() async* {
  yield* maleNames();
  yield* femaleName();
}

/// This is equivalent to allNames()
// Stream<String> allNames() async* {
//   await for (final maleName in maleNames()) {
//     yield maleName;
//   }
//   await for (final femaleName in femaleName()) {
//     yield femaleName;
//   }
// }

/// Output
// John
// Peter
// Paul
// Mary
// Jane
// Sue
```

### Stream Controllers

```dart
import 'dart:async';

void main(List<String> args) async {
  final controller = StreamController<String>();
  controller.sink.add('Hello');
  controller.sink.add('World');

  await for (final value in controller.stream) {
    print(value);
  }
  controller.close();
}

/// Output
// Hello
// World
```

### Stream Transformers

Stream Transformer is a class that takes a stream and changes it to another stream

```dart
void main(List<String> args) async {
  await for (final name in names) {
    print(name.toUpperCase());
  }
}

Stream<String> names = Stream.fromIterable(['Seth', 'Kathy', 'Lars']);

/// Output
// SETH
// KATHY
// LARS
```

Another method

```dart
void main(List<String> args) async {
  await for (final name in names.map((name) => name.toUpperCase())) {
    print(name);
  }
}

Stream<String> names = Stream.fromIterable(['Seth', 'Kathy', 'Lars']);

/// Output
// SETH
// KATHY
// LARS
```

```dart
import 'dart:async';

void main(List<String> args) async {
  await for (final capitalizedName in names.capitalized) {
    print(capitalizedName);
  }
  print("-------------------");
  await for (final capitalizedName in names.capitalizedUsingMap) {
    print(capitalizedName);
  }
}

Stream<String> names = Stream.fromIterable(['Seth', 'Kathy', 'Lars']);

extension on Stream<String> {
  Stream<String> get capitalized => transform(ToUpperCase());

  Stream<String> get capitalizedUsingMap => map((name) => name.toUpperCase());
}

class ToUpperCase extends StreamTransformerBase<String, String> {
  @override
  Stream<String> bind(Stream<String> stream) {
    return stream.map((name) => name.toUpperCase());
  }
}

/// Output
// SETH
// KATHY
// LARS
// -------------------
// SETH
// KATHY
// LARS
```

### Stream.toList

```dart
void main(List<String> args) async {
  final allNames = await getNames().toList();
  for (final name in allNames) {
    print(name);
  }
}

Stream<String> getNames() async* {
  yield 'John';
  yield 'Jane';
  yield 'Jack';
}

/// Output
// John
// Jane
// Jack
```

### Absorbing Stream Errors

```dart
import 'dart:async';

void main(List<String> args) async {
  await for (final name in getNames().absorbErrorsUsingHandleError()) {
    print(name);
  }
  // John
  // Jane

  await for (final name in getNames().absorbErrorsUsingHandlers()) {
    print(name);
  }
  // John
  // Jane

  await for (final name in getNames().absorbErrorsUsingTransformer()) {
    print(name);
  }
  // John
  // Jane
}

extension AbsorbErrors<T> on Stream<T> {
  Stream<T> absorbErrorsUsingHandleError() => handleError(
        (_, __) {},
      );

  Stream<T> absorbErrorsUsingHandlers() =>
      transform(StreamTransformer.fromHandlers(
        handleError: (error, stackTrace, sink) => sink.close(),
      ));

  Stream<T> absorbErrorsUsingTransformer() => transform(StreamErrorAbsorber());
}

Stream<String> getNames() async* {
  yield 'John';
  yield 'Jane';
  throw 'All out of names';
}

class StreamErrorAbsorber<T> extends StreamTransformerBase<T, T> {
  @override
  Stream<T> bind(Stream<T> stream) {
    final controller = StreamController<T>();

    stream.listen(
      controller.sink.add,
      onError: (_) {},
      onDone: controller.close,
    );
    return controller.stream;
  }
}
```

### Stream.asyncMap and Fold

```dart
void main(List<String> args) async {
  final result = await getNames()
      .asyncMap(
    (name) => extractCharacters(name),
  )
      .fold('', (previous, element) {
    final elements = element.join(' ');
    return '$previous $elements ';
  });
  print(result);
}

Stream<String> getNames() async* {
  yield 'John';
  yield 'Jane';
  yield 'Jill';
}

Future<List<String>> extractCharacters(String from) async {
  final characters = <String>[];
  for (final character in from.split('')) {
    await Future.delayed(Duration(milliseconds: 100));
    characters.add(character);
  }
  return characters;
}

/// Output
//  J o h n  J a n e  J i l l 
```

### Another Example of Stream.asynExpand

```dart
void main(List<String> args) async {
  final names3Times = getNames().asyncExpand((name) => times3(name));
  await for (final name in names3Times) {
    print(name);
  }
}

Stream<String> getNames() async* {
  yield 'Bob';
  yield 'Alice';
  yield 'Joe';
}

Stream<String> times3(String value) => Stream.fromIterable(
      Iterable.generate(
        3,
        (_) => value,
      ),
    );

/// Output
// Bob
// Bob
// Bob
// Alice
// Alice
// Alice
// Joe
// Joe
// Joe
```

### Broadcast Streams

A stream is an object than can be listened to from one listener at a time
__Broadcast Stream__: Multiple listeners can listen and consume at the
same time
__Non Broadcast Stream__: Only one listner can listen at a time

```dart
import 'dart:async';

void main(List<String> args) async {
  await nonBroadcastStreamExample();
}

Future<void> nonBroadcastStreamExample() async {
  final controller = StreamController<String>();
  controller.sink.add('Bob');
  controller.sink.add('Alice');
  controller.sink.add('Joe');

  try {
    await for (final name in controller.stream) {
      print(name);
      // this for loop is to re-listen the stream, which it will not
      await for (final name in controller.stream) {
        print(name);
      }
    }
  } catch (e) {
    print(e);
  }
}

/// Output
// Bob
// Bad state: Stream has already been listened to.
```

```dart
import 'dart:async';

void main(List<String> args) async {
  await nonBroadcastStreamExample();
  // Bob
  // Bad state: Stream has already been listened to.
  await broadcastStreamExample();
  // sub1: Bob
  // sub2: Bob
  // sub1: Alice
  // sub2: Alice
  // sub1: Joe
  // sub2: Joe
  // onCancel
}

Future<void> nonBroadcastStreamExample() async {
  final controller = StreamController<String>();
  controller.sink.add('Bob');
  controller.sink.add('Alice');
  controller.sink.add('Joe');

  try {
    await for (final name in controller.stream) {
      print(name);
      await for (final name in controller.stream) {
        print(name);
      }
    }
  } catch (e) {
    print(e);
  }
}

Future<void> broadcastStreamExample() async {
  late final StreamController<String> controller;

  controller = StreamController<String>.broadcast();

  final sub1 = controller.stream.listen((name) {
    print('sub1: $name');
  });

  final sub2 = controller.stream.listen((name) {
    print('sub2: $name');
  });

  controller.sink.add('Bob');
  controller.sink.add('Alice');
  controller.sink.add('Joe');
  controller.close();

  controller.onCancel = () {
    print('onCancel');
    sub1.cancel();
    sub2.cancel();
  };
}
```

### Stream Timeout Example

```dart
import 'dart:async';

void main(List<String> args) async {
  try {
    await for (final name in getNames().withTimeoutBetweenEvents(
      const Duration(seconds: 3),
    )) {
      print(name);
    }
  } on TimeoutBetweenEventsException catch (e, stackTrace) {
    print('TimeoutBetweenEventsException: $e');
    print('Stack trace: $stackTrace');
  }
}

Stream<String> getNames() async* {
  yield 'John';
  await Future.delayed(const Duration(seconds: 1));
  yield 'Jane';
  await Future.delayed(const Duration(seconds: 10));
  yield 'Doe';
}

extension WithTimeoutBetweenEvents<T> on Stream<T> {
  Stream<T> withTimeoutBetweenEvents(Duration duration) => transform(
        TimeoutBetweenEvents(duration: duration),
      );
}

class TimeoutBetweenEvents<E> extends StreamTransformerBase<E, E> {
  final Duration duration;

  const TimeoutBetweenEvents({
    required this.duration,
  });

  @override
  Stream<E> bind(Stream<E> stream) {
    StreamController<E>? controller;
    StreamSubscription<E>? subscription;
    Timer? timer;

    controller = StreamController(
      onListen: () {
        subscription = stream.listen(
          (data) {
            timer?.cancel();
            timer = Timer.periodic(
              duration,
              (timer) {
                controller?.addError(
                  TimeoutBetweenEventsException('Timeout'),
                );
              },
            );
            controller?.add(data);
          },
          onError: controller?.addError,
          onDone: controller?.close,
        );
      },
      onCancel: () {
        subscription?.cancel();
        timer?.cancel();
      },
    );

    return controller.stream;
  }
}

class TimeoutBetweenEventsException implements Exception {
  final String message;
  TimeoutBetweenEventsException(this.message);
}

/// Output
// John
// Jane
// TimeoutBetweenEventsException: Instance of 'TimeoutBetweenEventsException'
// Stack trace: 
```
