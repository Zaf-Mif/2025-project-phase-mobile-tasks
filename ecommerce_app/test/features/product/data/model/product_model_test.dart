import 'dart:convert';

import 'package:ecommerce_app/features/product/data/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';


void main() {
  late ProductModel productModel;

  setUp(() {
    productModel = const ProductModel(
      id: 1,
      name: 'Test Product',
      price: 49.99,
      imageUrl: 'test.jpg',
      description: 'Test description',
    );
  });

  group('ProductModel', () {
    test('fromJson should return valid ProductModel', () {
      // arrange
      final Map<String, dynamic> jsonMap = json.decode(fixture('product.json'));
      // act
      final result = ProductModel.fromJson(jsonMap);
      // assert
      expect(result, equals(productModel));
    });

    test('toJson should return a valid map', () {
      // act
      final result = productModel.toJson();
      // expected JSON map must match keys exactly like from JSON file
      final expectedMap = {
        'id': 1,
        'name': 'Test Product',
        'price': 49.99,
        'image': 'test.jpg', // Note: key is 'image', not 'imageUrl'
        'description': 'Test description',
      };
      // assert
      expect(result, equals(expectedMap));
    });
  });
}
