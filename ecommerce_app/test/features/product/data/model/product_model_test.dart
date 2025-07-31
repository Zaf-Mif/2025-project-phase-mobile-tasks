import 'package:ecommerce_app/features/product/data/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ProductModel productModel;
  late Map<String, dynamic> json;

  setUp(() {
    productModel = ProductModel(
      id: 1,
      name: 'Test Product',
      price: 49.99,
      imageUrl: 'test.jpg',
      description: 'Test description',
    );

    json = {
      'id': 1,
      'name': 'Test Product',
      'price': 49.99,
      'image': 'test.jpg', // Mapped from imageUrl
      'description': 'Test description',
    };
  });

  group('ProductModel', () {
    test('fromJson should return valid ProductModel', () {
      final result = ProductModel.fromJson(json);
      expect(result, equals(productModel));
    });

    test('toJson should return a valid map', () {
      final result = productModel.toJson();
      expect(result, equals(json));
    });
  });
}
