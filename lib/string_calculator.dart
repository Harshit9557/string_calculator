// File: string_calculator.dart
class StringCalculator {
  int add(String numbers) {
    if (numbers.isEmpty) return 0;

    String delimiter = ',';
    String input = numbers;

    if (numbers.startsWith('//')) {
      final parts = numbers.split('\n');
      delimiter = parts[0].substring(2);
      input = parts.sublist(1).join('\n');
    }

    input = input.replaceAll('\n', delimiter);
    final numberList = input.split(delimiter).map(int.parse).toList();

    final negatives = numberList.where((n) => n < 0).toList();
    if (negatives.isNotEmpty) {
      throw Exception('negative numbers not allowed ${negatives.join(',')}');
    }

    return numberList.reduce((a, b) => a + b);
  }
}
