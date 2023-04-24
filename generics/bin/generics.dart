void main(List<String> args) {
  print(Person(age: 10).ageRounded); // 10
  print(Person(age: 10.2).ageRounded); // 10
}

class Person<T extends num> {
  final T age;

  const Person({required this.age});

  int get ageRounded => age.round();
}
