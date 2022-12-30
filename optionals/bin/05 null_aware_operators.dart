void main(List<String> args) {
  String? lastName;
  // print(lastName.length);
  print(lastName?.length);

  String? nullName;
  print(nullName ?? 'Foo');
  print(lastName ?? nullName);
  final bla = lastName ?? nullName ?? 'Foo';
}
