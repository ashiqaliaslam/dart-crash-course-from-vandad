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