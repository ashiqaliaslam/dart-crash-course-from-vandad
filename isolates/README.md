# Dart Course

## Isolates in Dart

Create dart app `dart create -t console isolates`

Run fswatch
`fswatch -o bin/ | xargs -n1 -I{} sh -c 'clear; dart bin/isolates.dart'`

### Simple Isolate

```dart
import 'dart:isolate';

void main(List<String> args) async {
  await for (final msg in getMessages().take(10)) {
    print(msg);
  }
}

Stream<String> getMessages() {
  final rp = ReceivePort();
  return Isolate.spawn(_getMessages, rp.sendPort)
      .asStream()
      .asyncExpand((_) => rp)
      .takeWhile((element) => element is String)
      .cast();
}

void _getMessages(SendPort sp) async {
  await for (final now in Stream.periodic(
    const Duration(milliseconds: 200),
    (_) => DateTime.now().toIso8601String(),
  )) {
    sp.send(now);
  }
}

/// Output
// 2023-04-26T07:19:35.847354
// 2023-04-26T07:19:36.044938
// 2023-04-26T07:19:36.245092
// 2023-04-26T07:19:36.444651
// 2023-04-26T07:19:36.644938
// 2023-04-26T07:19:36.845572
// 2023-04-26T07:19:37.044787
// 2023-04-26T07:19:37.244587
// 2023-04-26T07:19:37.444980
// 2023-04-26T07:19:37.644062
```

### Isolate Communication

```dart
import 'dart:isolate';
import 'dart:io';
import 'dart:convert';

void main(List<String> args) async {
  do {
    stdout.write('Say something: ');
    final line = stdin.readLineSync(encoding: utf8);
    switch (line?.trim().toLowerCase()) {
      case null:
        continue;
      case 'exit':
        exit(0);
      default:
        final msg = await getMessage(line!);
        print(msg);
    }
  } while (true);
}

Future<String> getMessage(String forGreeting) async {
  final rp = ReceivePort();
  Isolate.spawn(_communicator, rp.sendPort);

  final broadcastRp = rp.asBroadcastStream();
  final SendPort communicatorSendPort = await broadcastRp.first;
  communicatorSendPort.send(forGreeting);

  return broadcastRp
      .takeWhile((element) => element is String)
      .cast<String>()
      .take(1)
      .first;
}

void _communicator(SendPort sp) async {
  final rp = ReceivePort();
  sp.send(rp.sendPort);

  final messages = rp.takeWhile((element) => element is String).cast<String>();

  await for (final message in messages) {
    for (final entry in messagesAndResponses.entries) {
      if (entry.key.trim().toLowerCase() == message.trim().toLowerCase()) {
        sp.send(entry.value);
        continue;
      }
    }
    sp.send('I have no response to that!');
  }
}

const messagesAndResponses = {
  '': 'Ask me a question like "How are you?"',
  'Hello': 'Hi',
  'How are you?': 'Fine',
  'What are you doing?': 'Learning about Isolates in Dart!',
  'Are you having fun?': 'Yeah sure!',
};
```

### Keeping an Isolate Alive

```dart
import 'dart:isolate';
import 'dart:io';
import 'dart:convert';

void main(List<String> args) async {
  final responder = await Responder.create();

  do {
    stdout.write('Say something (or type exit): ');
    final line = stdin.readLineSync(encoding: utf8);
    switch (line?.trim().toLowerCase()) {
      case null:
        continue;
      case 'exit':
        exit(0);
      default:
        final msg = await responder.getMessage(line!);
        print(msg);
    }
  } while (true);
}

class Responder {
  final ReceivePort rp;
  final Stream<dynamic> broadcastRp;
  final SendPort communicatorSendPort;

  Responder({
    required this.rp,
    required this.broadcastRp,
    required this.communicatorSendPort,
  });

  static Future<Responder> create() async {
    final rp = ReceivePort();
    Isolate.spawn(
      _communicator,
      rp.sendPort,
    );

    final broadcastRp = rp.asBroadcastStream();
    final SendPort communicatorSendPort = await broadcastRp.first;

    return Responder(
      rp: rp,
      broadcastRp: broadcastRp,
      communicatorSendPort: communicatorSendPort,
    );
  }

  Future<String> getMessage(String forGreeting) async {
    communicatorSendPort.send(forGreeting);

    return broadcastRp
        .takeWhile((element) => element is String)
        .cast<String>()
        .take(1)
        .first;
  }
}

void _communicator(SendPort sp) async {
  final rp = ReceivePort();
  sp.send(rp.sendPort);

  final messages = rp.takeWhile((element) => element is String).cast<String>();

  await for (final message in messages) {
    for (final entry in messagesAndResponses.entries) {
      if (entry.key.trim().toLowerCase() == message.trim().toLowerCase()) {
        sp.send(entry.value);
        continue;
      }
    }
  }
}

const messagesAndResponses = {
  '': 'Ask me a question like "How are you?"',
  'Hello': 'Hi',
  'How are you?': 'Fine',
  'What are you doing?': 'Learning about Isolates in Dart!',
  'Are you having fun?': 'Yeah sure!',
};
```

### JSON Downloading and Parsing with Isolates

```dart
import 'dart:io';
import 'dart:isolate';
import 'dart:convert';

void main(List<String> args) async {
  final rp = ReceivePort();
  Isolate.spawn(
    _parseJsonIsolateEntry,
    rp.sendPort,
  );

  final todos = rp
      .takeWhile((element) => element is Iterable<Todo>)
      .cast<Iterable<Todo>>()
      .take(1);

  await for (final todos in todos) {
    print(todos);
  }
}

void _parseJsonIsolateEntry(SendPort sp) async {
  final client = HttpClient();
  final uri = Uri.parse('https://jsonplaceholder.typicode.com/todos/');

  final todos = await client
      .getUrl(uri)
      .then((req) => req.close())
      .then((response) => response.transform(utf8.decoder).join())
      .then((value) => jsonDecode(value) as List<dynamic>)
      .then((json) => json.map((map) => Todo.fromJson(map)));
  sp.send(todos);
}

class Todo {
  final int userId;
  final int id;
  final String title;
  final bool isCompleted;

  @override
  String toString() =>
      'Todo (userId: $userId, id: $id, title: $title, isCompleted: $isCompleted)';

  Todo({
    required this.userId,
    required this.id,
    required this.title,
    required this.isCompleted,
  });

  Todo.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        id = json['id'],
        title = json['title'],
        isCompleted = json['completed'];
}

/// Output
// (Todo (userId: 1, id: 1, title: delectus aut autem, isCompleted: false), ...)
```

### Spawning Isolates Using a URI

`lib/isolates.dart`

```dart
import 'dart:isolate';

void main(
  List<String> args,
  SendPort message,
) {
  message.send('Hello world');
}
```

`bin/isolates.dart`

```dart
import 'dart:isolate';

void main(List<String> args) async {
  final uri = Uri.parse('package:isolates/isolates.dart');
  final rp = ReceivePort();
  Isolate.spawnUri(
    uri,
    [],
    rp.sendPort,
  );
  final firstMessage = await rp.first;
  print(firstMessage);
}
```
