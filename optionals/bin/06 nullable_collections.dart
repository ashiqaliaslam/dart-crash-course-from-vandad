void main(List<String> args) {
  List<String?>? names;
  print(names);
  names?.add('Foo');
  print(names);

  final String? first = names?.first;
  print(first ?? 'No first name found');

  names = [];
  names.add('Baz');
  names.add(null);
  print(names);
}
