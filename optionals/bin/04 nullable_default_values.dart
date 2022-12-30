void main(List<String> args) {
  String? lastName;
  lastName = 'Baz';
  lastName ??= 'Bar'; // assign the value 'Bar' to lastName only if it is null
  print(lastName);
}
