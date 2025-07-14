// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

// File: string_calculator_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:calculator_add/string_calculator.dart';

void main() {
  late StringCalculator calculator;

  setUp(() {
    calculator = StringCalculator();
  });

  group('StringCalculator.add()', () {
    test('returns 0 when input is empty', () {
      expect(calculator.add(''), equals(0));
    });

    test('returns the number when single number is provided', () {
      expect(calculator.add('5'), equals(5));
    });

    test('returns the sum of two numbers', () {
      expect(calculator.add('1,2'), equals(3));
    });

    test('returns the sum of multiple comma-separated numbers', () {
      expect(calculator.add('1,2,3,4,5'), equals(15));
    });

    test('handles newlines as valid separators', () {
      expect(calculator.add('1\n2,3'), equals(6));
    });

    test('supports custom single-character delimiter', () {
      expect(calculator.add('//;\n2;3'), equals(5));
    });

    test('should support custom multi-character delimiter', () {
      expect(calculator.add('//[***]\n1***2***3'), 6);
    });

    test('should support multiple delimiters', () {
      expect(calculator.add('//[*][%]\n1*2%3'), 6);
    });

    test('should support multiple multi-character delimiters', () {
      expect(calculator.add('//[***][%%]\n1***2%%3'), 6);
    });

    test('should ignore numbers greater than 1000', () {
      expect(calculator.add('2,1001'), 2);
    });

    test('should throw exception with one negative number', () {
      expect(
        () => calculator.add('1,-2,3'),
        throwsA(predicate((e) =>
            e is Exception &&
            e.toString().contains('negative numbers not allowed -2'))),
      );
    });

    test('throws exception with multiple negative numbers', () {
      expect(
        () => calculator.add('1,-2,3,-5'),
        throwsA(predicate((e) =>
            e is Exception &&
            e.toString().contains('negative numbers not allowed -2,-5'))),
      );
    });
  });
}
