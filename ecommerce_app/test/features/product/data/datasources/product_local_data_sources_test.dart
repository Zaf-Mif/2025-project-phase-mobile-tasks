import 'dart:convert';
import 'dart:io';

import 'package:ecommerce_app/core/error/exceptions.dart';
import 'package:ecommerce_app/features/product/data/datasources/product_local_data_sources.dart';
import 'package:ecommerce_app/features/product/data/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late ProductLocalDataSourcesImpl dataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = ProductLocalDataSourcesImpl(sharedPreferences: mockSharedPreferences);
  });

  /// Helper to load fixtures from `test/fixtures/`
  String fixture(String name) =>
      File('test/fixtures/$name').readAsStringSync();

  // Use fixtures
  final tProductJson = fixture('product.json');
  final tProductModel = ProductModel.fromJson(json.decode(tProductJson));

  final tProductListJson = fixture('product_cached.json');
  final tProductList = (json.decode(tProductListJson) as List)
      .map((item) => ProductModel.fromJson(item))
      .toList();

  group('cacheProducts', () {
    test('should call SharedPreferences to cache the data', () async {
      when(() => mockSharedPreferences.setString(any(), any()))
          .thenAnswer((_) async => true);

      await dataSource.cacheProducts(tProductList);

      verify(() => mockSharedPreferences.setString(cachedProductsKey, tProductListJson)).called(1);
    });

    test('should throw CacheException if caching fails', () async {
      when(() => mockSharedPreferences.setString(any(), any()))
          .thenAnswer((_) async => false);

      final result = dataSource.cacheProducts(tProductList);

      expect(() => result, throwsA(isA<CacheException>()));
    });
  });

  group('getCachedProducts', () {
    test('should return List<ProductModel> from SharedPreferences', () async {
      when(() => mockSharedPreferences.getString(cachedProductsKey))
          .thenReturn(tProductListJson);

      final result = await dataSource.getCachedProducts();

      expect(result, equals(tProductList));
    });

    test('should throw CacheException when no data is found', () async {
      when(() => mockSharedPreferences.getString(any())).thenReturn(null);

      final result = dataSource.getCachedProducts();

      expect(() => result, throwsA(isA<CacheException>()));
    });
  });

  group('saveProduct', () {
    test('should save product to local cache', () async {
      when(() => mockSharedPreferences.getString(cachedProductsKey))
          .thenReturn(tProductListJson);
      when(() => mockSharedPreferences.setString(any(), any()))
          .thenAnswer((_) async => true);

      await dataSource.saveProduct(tProductModel);

      verify(() => mockSharedPreferences.setString(any(), any())).called(1);
    });
  });

  group('updateProduct', () {
    test('should update product in local cache', () async {
      final updatedModel = ProductModel(
        id: tProductModel.id,
        name: 'Updated Name',
        price: tProductModel.price + 100,
        imageUrl: tProductModel.imageUrl,
        description: 'Updated Description',
      );

      when(() => mockSharedPreferences.getString(cachedProductsKey))
          .thenReturn(tProductListJson);
      when(() => mockSharedPreferences.setString(any(), any()))
          .thenAnswer((_) async => true);

      await dataSource.updateProduct(updatedModel);

      verify(() => mockSharedPreferences.setString(any(), any())).called(1);
    });

    test('should throw CacheException if product is not found', () async {
      when(() => mockSharedPreferences.getString(cachedProductsKey))
          .thenReturn(jsonEncode([]));

      final result = dataSource.updateProduct(tProductModel);

      expect(() => result, throwsA(isA<CacheException>()));
    });
  });

  group('deleteProduct', () {
    test('should delete product from local cache', () async {
      when(() => mockSharedPreferences.getString(cachedProductsKey))
          .thenReturn(tProductListJson);
      when(() => mockSharedPreferences.setString(any(), any()))
          .thenAnswer((_) async => true);

      await dataSource.deleteProduct(tProductModel.id);

      verify(() => mockSharedPreferences.setString(any(), any())).called(1);
    });

    test('should throw CacheException if product not found', () async {
      when(() => mockSharedPreferences.getString(cachedProductsKey))
          .thenReturn(jsonEncode([]));

      final result = dataSource.deleteProduct(tProductModel.id);

      expect(() => result, throwsA(isA<CacheException>()));
    });
  });
}
