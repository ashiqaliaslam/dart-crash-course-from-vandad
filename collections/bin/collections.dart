import 'package:collection/collection.dart';

void main(List<String> args) {
  testMapMerging();
}

void testMapMerging() {
  const info1 = {'name': 'John 1', 'age': 30, 'height': 1.8};
  const info2 = {'name': 'John 2', 'age': 31, 'height': 1.8, 'weight': 80};

  // It takes the last key
  final merge = mergeMaps(info1, info2);
  print(merge);
  // {name: John 2, age: 31, height: 1.8, weight: 80}

  // It takes the first key
  final merge2 = mergeMaps(info1, info2, value: (one, two) => one);
  print(merge2);
  // {name: John 1, age: 30, height: 1.8, weight: 80}
}

/// Output
// (1, 2, 3, 10, 20, 30, 40, 50, 60)