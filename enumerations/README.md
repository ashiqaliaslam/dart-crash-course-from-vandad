# Dart Course

## Enumerations in Dart

### Enumerations

Create dart app `dart create -t console enumerations`

Run fswatch `fswatch -o bin/ | xargs -n1 -I{} sh -c 'clear; dart bin/enumerations.dart'`

Enumerations allow you to create similar objects in one structure.

```dart
void main(List<String> args) {
  final woof = Animal(
    name: 'Woof',
    type: AnimalType.dog,
  );

  // enumeration for comparison
  if (woof.type == AnimalType.cat) {
    print('Woof is a cat');
  } else {
    print('Woof is not a cat');
  }

  // most preferable way to compare enums
  switch (woof.type) {
    case AnimalType.rabbit:
      print('This is a rabbit');
      break;
    case AnimalType.dog:
      print('This is a dog');
      break;
    case AnimalType.cat:
      print('This is a cat');
      break;
  }
}

enum AnimalType {
  rabbit,
  dog,
  cat,
}

class Animal {
  final String name;
  final AnimalType type;

  const Animal({
    required this.name,
    required this.type,
  });
}

/// Output
// Woof is not a cat
// This is a dog
```

### Enhanced Enumerations

```dart
void main(List<String> args) {
  final foo = Person(
    name: 'Foo',
    car: Car.teslaModelX,
  );

  switch (foo.car) {
    case Car.teslaModelX:
      print('Foo has a Tesla Model X = ${foo.car}');
      break;
    case Car.teslaModelY:
      print('Foo has a Tesla Model Y = ${foo.car}');
      break;
  }
}

class Person {
  final String name;
  final Car car;

  const Person({
    required this.name,
    required this.car,
  });
}

enum Car {
  teslaModelX(
    manufacturer: 'Tesla',
    model: 'Model X',
    year: 2023,
  ),
  teslaModelY(
    manufacturer: 'Tesla',
    model: 'Model Y',
    year: 2022,
  );

  final String manufacturer;
  final String model;
  final int year;

  const Car({
    required this.manufacturer,
    required this.model,
    required this.year,
  });

  @override
  String toString() => 'Car: $manufacturer $model $year';
}

/// Output
// Foo has a Tesla Model X = Car: Tesla Model X 2023
```

### Switch Enumerations

```dart
void main(List<String> args) {
  final whiskers = AnimalType.cat;

  switch (whiskers) {
    case AnimalType.cat:
      print('This is a cat');
      break;
    default:
      print('This is not a cat');
  }
}

enum AnimalType {
  rabbit,
  dog,
  cat,
}

/// Output:
// This is a cat
```

### Converting Strings to Enumerations

```dart
void main(List<String> args) {
  describe(animalType(fromStr: 'rabbit'));
  describe(animalType(fromStr: 'dog'));
  describe(animalType(fromStr: 'cat'));
  describe(animalType(fromStr: 'horse'));
}

void describe(AnimalType? animalType) {
  switch (animalType) {
    case AnimalType.rabbit:
      print('This is a rabbit');
      break;
    case AnimalType.dog:
      print('This is a dog');
      break;
    case AnimalType.cat:
      print('This is a cat');
      break;
    default:
      print('Unknown animal');
  }
}

AnimalType? animalType({
  required String fromStr,
}) {
  try {
    return AnimalType.values.firstWhere((element) => element.name == fromStr);
  } catch (e) {
    return null;
  }
}

enum AnimalType {
  rabbit,
  dog,
  cat,
}
```

### Falling Through on Enumeration Cases

```dart
void main(List<String> args) {
  final vehicle = VehicleType.car;

  switch (vehicle) {
    case VehicleType.motorcycle:
      print('Most common personal vehicles');
      break;
    case VehicleType.bicycle:
      print('Most common personal vehicles');
      break;
    case VehicleType.car:
      print('Most common personal vehicles');
      break;
    case VehicleType.truck:
      print('Usually used for work');
      break;
  }
}

enum VehicleType {
  car,
  truck,
  motorcycle,
  bicycle,
}

/// Output
// Most common personal vehicles
```

When some cases have same output, you can code like this

```dart
void main(List<String> args) {
  final vehicle = VehicleType.car;

  switch (vehicle) {
    // all three cases have same output
    case VehicleType.motorcycle:
    case VehicleType.bicycle:
    case VehicleType.car:
      print('Most common personal vehicles');
      break;
    case VehicleType.truck:
      print('Usually used for work');
      break;
  }
}

enum VehicleType {
  car,
  truck,
  motorcycle,
  bicycle,
}

/// Output
// Most common personal vehicles
```

### Enumerations with Mixins

```dart
void main(List<String> args) {
  AnimalType.dog.jump();
  AnimalType.cat.jump();
  try {
    AnimalType.fish.jump();
  } catch (e) {
    print('Fish cannot jump');
  }
}

mixin CanJump {
  int get feetCount;

  void jump() {
    if (feetCount < 1) {
      throw Exception('Cannot jump');
    } else {
      print('Jumped!');
    }
  }
}

enum AnimalType with CanJump {
  cat(feetCount: 4),
  dog(feetCount: 4),
  fish(feetCount: 0);

  @override
  final int feetCount;
  const AnimalType({
    required this.feetCount,
  });
}

/// Output
// Jumped!
// Jumped!
// Fish cannot jump
```

### Extending Enumerations

```dart
void main(List<String> args) {
  AnimalType.cat
    ..jump()
    ..run();
  AnimalType.dog
    ..jump()
    ..run();
  AnimalType.rabbit
    ..jump()
    ..run();
}

enum AnimalType {
  cat,
  dog,
  rabbit;

  void run() {
    print('Running...');
  }
}

extension Jump on AnimalType {
  void jump() {
    print('$this is jumping');
  }
}

/// Output
// AnimalType.cat is jumping
// Running...
// AnimalType.dog is jumping
// Running...
// AnimalType.rabbit is jumping
// Running...
```

### Implementing Comparable on Enumerations

```dart
void main(List<String> args) {
  print('Unsorted');
  print(TeslaCars.values);
  print('-----');
  print('Sorted');
  print([...TeslaCars.values]..sort());
}

enum TeslaCars implements Comparable<TeslaCars> {
  modelY(weightInKg: 2.2),
  modelS(weightInKg: 2.1),
  model3(weightInKg: 1.8),
  modelX(weightInKg: 2.4);

  final double weightInKg;

  const TeslaCars({
    required this.weightInKg,
  });

  @override
  int compareTo(TeslaCars other) => weightInKg.compareTo(
        other.weightInKg,
      );
}

/// Output
// Unsorted
// [TeslaCars.modelY, TeslaCars.modelS, TeslaCars.model3, TeslaCars.modelX]
// -----
// Sorted
// [TeslaCars.model3, TeslaCars.modelS, TeslaCars.modelY, TeslaCars.modelX]
```
