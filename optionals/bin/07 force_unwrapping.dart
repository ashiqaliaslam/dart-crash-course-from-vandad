void main(List<String> args) {
  try {
    final String? firstName = null;
    print(firstName!);
  } catch (error) {
    print(error);
  }
}
/// Output
// Null check operator used on a null value