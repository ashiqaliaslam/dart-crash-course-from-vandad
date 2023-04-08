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