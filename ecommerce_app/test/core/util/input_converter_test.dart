import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/util/input_converter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late InputConverter inputConverter;

  setUp(() {
    inputConverter = InputConverter();
  });
  group('stringToUnsignedInt', () {
    test(
      'should return an integer when the string represents an unsigned integer',
      () async {
        // arrange
        const str = '123';
        // act
        final result = inputConverter.stringToUnsignedInteger(str);
        // assert
        expect(result, const Right(123));
      },
    );
    test('should return a failure when the string is not an integer', () async {
      // arrange
      const str = 'abc';
      // act
      final result = inputConverter.stringToUnsignedInteger(str);
      // assert
      expect(result, Left(InvalidInputFailure()));
    });
    test(
      'should return a failure when the string is a negative integer',
      () async {
        // arrange
        const str = '-123';
        // act
        final result = inputConverter.stringToUnsignedInteger(str);
        // assert
        expect(result, Left(InvalidInputFailure()));
      },
    );
  });
  group('stringToPositiveDouble', () {
    test(
      'should return a double when the string represents a positive number',
      () {
        // arrange
        const str = '123.45';
        // act
        final result = inputConverter.stringToPositiveDouble(str);
        // assert
        expect(result, const Right(123.45));
      },
    );
    test('should return a failure when the string is not a number', () async {
      // arrange
      const str = 'abc';
      // act
      final result = inputConverter.stringToPositiveDouble(str);
      // assert
      expect(result, Left(InvalidInputFailure()));
    });
    test(
      'should return a failure when the string is a zero or negative number',
      () {
        // arrange
        const str1 = '0';
        const str2 = '-123.45';

        final result1 = inputConverter.stringToPositiveDouble(str1);
        final result2 = inputConverter.stringToPositiveDouble(str2);

        expect(result1, Left(InvalidInputFailure()));
        expect(result2, Left(InvalidInputFailure()));
      },
    );
  });
}
