void main(List<String> args) {
  String? lastName;

  void changeLastName() {
    lastName = 'Bar';
  }

  changeLastName();

  // This method is good as per Vandad
  if (lastName?.contains('Bar') ?? false) {
    print('Last name contains Bar');
  }

  // this method is working, but upper method is more logical
  if (lastName?.contains('Bar') == true) {
    print('Last name contains Bar');
  }
}
/// Output
// Last name contains Bar
// Last name contains Bar