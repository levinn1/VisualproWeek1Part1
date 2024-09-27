import 'dart:io';
import 'dart:math';

List<int> generateRandomNumbers(int n) {
  var random = Random();
  return List<int>.generate(n, (_) => random.nextInt(1000));
}

List<int> bubbleSort(List<int> numbers) {
  return _bubbleSortRecursive(numbers, numbers.length);
}

List<int> _bubbleSortRecursive(List<int> numbers, int length) {
  if (length <= 1) return numbers;
  
  switch (length) {
    case 1:
      return numbers;
    default:
      numbers.asMap().forEach((i, value) {
        switch (i < length - 1 && numbers[i] > numbers[i + 1]) {
          case true:
            var temp = numbers[i];
            numbers[i] = numbers[i + 1];
            numbers[i + 1] = temp;
            break;
          default:
            break;
        }
      });
      return _bubbleSortRecursive(numbers, length - 1);
  }
}

int countInversions(List<int> numbers) {
  return _countInversionsRecursive(numbers, 0, 0);
}

int _countInversionsRecursive(List<int> numbers, int i, int count) {
  switch (i >= numbers.length - 1) {
    case true:
      return count;
    default:
      count += numbers.sublist(i + 1).where((num) => numbers[i] > num).length;
      return _countInversionsRecursive(numbers, i + 1, count);
  }
}

List<int> shuffleArray(List<int> numbers) {
  var random = Random();
  return _shuffleRecursive(numbers, numbers.length - 1, random);
}

List<int> _shuffleRecursive(List<int> numbers, int i, Random random) {
  switch (i <= 0) {
    case true:
      return numbers;
    default:
      int j = random.nextInt(i + 1);
      var temp = numbers[i];
      numbers[i] = numbers[j];
      numbers[j] = temp;
      return _shuffleRecursive(numbers, i - 1, random);
  }
}

void main() {
  print("Masukkan jumlah angka yang ingin di-generate: ");
  int? n = int.tryParse(stdin.readLineSync()!);

  n ??= 10;

  var numbers = generateRandomNumbers(n);

  print("Angka random yang di-generate: $numbers");

  print("Pilih algoritma, 1. bubble sort, 2. inversi atau, 3. shuffle (1/2/3): ");
  String? choice = stdin.readLineSync();

  Stopwatch stopwatch = Stopwatch();

  Map<String, Function> actions = {
    '1': () {
      stopwatch.start();
      print("Hasil Bubble Sort: ${bubbleSort([...numbers])}");
      stopwatch.stop();
    },
    '2': () {
      stopwatch.start();
      print("Jumlah Inversi: ${countInversions([...numbers])}");
      stopwatch.stop();
    },
    '3': () {
      stopwatch.start();
      print("Hasil Shuffle: ${shuffleArray([...numbers])}");
      stopwatch.stop();
    },
  };

  (actions[choice ?? 'shuffle'])?.call();

  print("Waktu eksekusi: ${stopwatch.elapsedMilliseconds} ms");
}
