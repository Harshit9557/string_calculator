// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

// File: string_calculator_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:calculator_add/string_calculator.dart'; // adjust import

void main() {
  late StringCalculator calculator;

  setUp(() {
    calculator = StringCalculator();
  });

  test('returns 0 for empty string', () {
    expect(calculator.add(''), 0);
  });

  test('returns number when single number is provided', () {
    expect(calculator.add('1'), 1);
  });

  test('returns sum of two numbers', () {
    expect(calculator.add('1,5'), 6);
  });

  test('returns sum of multiple numbers', () {
    expect(calculator.add('1,2,3,4'), 10);
  });

  test('handles newlines as delimiters', () {
    expect(calculator.add('1\n2,3'), 6);
  });

  test('supports custom delimiter', () {
    expect(calculator.add('//;\n1;2'), 3);
  });

  test('throws exception on negative numbers', () {
    expect(
        () => calculator.add('1,-2,3,-4'),
        throwsA(predicate((e) =>
            e.toString().contains('negative numbers not allowed -2,-4'))));
  });
}
