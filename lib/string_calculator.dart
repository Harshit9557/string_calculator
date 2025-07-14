// lib/string_calculator.dart
class StringCalculator {
  int add(String input) {
    if (input.isEmpty) return 0;

    String numbers = input;
    List<String> delimiters = [','];

    // Custom delimiter syntax
    if (input.startsWith('//')) {
      final delimiterSectionEnd = input.indexOf('\n');
      final delimiterSection = input.substring(2, delimiterSectionEnd);
      numbers = input.substring(delimiterSectionEnd + 1);

      // Handle multiple delimiters or variable length delimiters
      final delimiterPattern = RegExp(r'\[(.*?)\]');
      final matches = delimiterPattern.allMatches(delimiterSection);

      if (matches.isNotEmpty) {
        delimiters = matches.map((m) => RegExp.escape(m.group(1)!)).toList();
      } else {
        delimiters = [RegExp.escape(delimiterSection)];
      }
    }

    // Replace newlines with comma for standard processing
    delimiters.add('\n');
    final pattern = RegExp(delimiters.join('|'));
    final tokens = numbers.split(pattern);

    final negatives = <int>[];
    final sum = tokens.fold<int>(0, (total, token) {
      final number = int.tryParse(token.trim()) ?? 0;
      if (number < 0) negatives.add(number);
      if (number <= 1000) return total + number;
      return total;
    });

    if (negatives.isNotEmpty) {
      throw Exception('negative numbers not allowed ${negatives.join(',')}');
    }

    return sum;
  }
}
