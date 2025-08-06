import 'dart:convert';

import 'package:ecommerce_app/core/error/exceptions.dart';
import 'package:ecommerce_app/features/product/data/datasources/product_remote_data_source.dart';
import 'package:ecommerce_app/features/product/data/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late ProductRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  const baseUrl = 'https://g5-flutter-learning-path-be-tvum.onrender.com/api/v1/products';

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = ProductRemoteDataSourceImpl(client: mockHttpClient);
    registerFallbackValue(Uri.parse(baseUrl));
  });

  void setUpMockHttpClientSuccess(String fixtureFile, [int statusCode = 200]) {
    when(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
        .thenAnswer((_) async => http.Response(fixture(fixtureFile), statusCode));
  }

  void setUpMockHttpClientFailure([int statusCode = 404]) {
    when(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', statusCode));
  }

  group('GET All Products', () {
    final tProductList = (json.decode(fixture('product.json'))['data'] as List)
      .map((json) => ProductModel.fromJson(json))
      .toList();

    test('should perform a GET request with application/json header', () async {
      setUpMockHttpClientSuccess('product.json');
      await dataSource.getAllProducts();
      verify(() => mockHttpClient.get(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
      ));
    });

    test('should return list of ProductModels when response code is 200', () async {
      setUpMockHttpClientSuccess('product.json');
      final result = await dataSource.getAllProducts();
      expect(result, equals(tProductList));
    });

    test('should throw ServerException when response code is not 200', () async {
      setUpMockHttpClientFailure();
      final call = dataSource.getAllProducts;
      expect(() => call(), throwsA(isA<ServerException>()));
    });
  });

  group('GET Product by ID', () {
    const tId = 1;
    // <-- IMPORTANT: parse ['data'] here to get the inner product object
    final tProduct = ProductModel.fromJson(json.decode(fixture('single_product.json')));

    test('should perform GET request for a specific product by ID', () async {
      when(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
          .thenAnswer((_) async => http.Response(fixture('single_product.json'), 200));
      await dataSource.getProductById(tId);
      verify(() => mockHttpClient.get(
        Uri.parse('$baseUrl/$tId'),
        headers: {'Content-Type': 'application/json'},
      ));
    });

    test('should return ProductModel when response is successful (200)', () async {
      when(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
          .thenAnswer((_) async => http.Response(fixture('single_product.json'), 200));
      final result = await dataSource.getProductById(tId);
      expect(result, equals(tProduct));
    });

    test('should throw ServerException on error status code', () async {
      setUpMockHttpClientFailure();
      final call = dataSource.getProductById;
      expect(() => call(tId), throwsA(isA<ServerException>()));
    });
  });

  group('CREATE Product', () {
    final tProduct = ProductModel.fromJson(json.decode(fixture('single_product.json')));

    test('should perform POST request with correct data', () async {
      when(() => mockHttpClient.post(any(),
          headers: any(named: 'headers'), body: any(named: 'body')))
          .thenAnswer((_) async => http.Response('', 201));
      await dataSource.createProduct(tProduct);
      verify(() => mockHttpClient.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(tProduct.toJson()),
      ));
    });

    test('should throw ServerException if status code is not 201', () async {
      when(() => mockHttpClient.post(any(),
          headers: any(named: 'headers'), body: any(named: 'body')))
          .thenAnswer((_) async => http.Response('', 400));
      final call = dataSource.createProduct;
      expect(() => call(tProduct), throwsA(isA<ServerException>()));
    });
  });

  group('UPDATE Product', () {
    final tProduct = ProductModel.fromJson(json.decode(fixture('single_product.json')));

    test('should perform PUT request with correct data', () async {
      when(() => mockHttpClient.put(any(),
          headers: any(named: 'headers'), body: any(named: 'body')))
          .thenAnswer((_) async => http.Response('', 201));
      await dataSource.updateProduct(tProduct);
      verify(() => mockHttpClient.put(
        Uri.parse('$baseUrl/${tProduct.id}'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(tProduct.toJson()),
      ));
    });

    test('should throw ServerException if status is not 201', () async {
      when(() => mockHttpClient.put(any(),
          headers: any(named: 'headers'), body: any(named: 'body')))
          .thenAnswer((_) async => http.Response('', 400));
      final call = dataSource.updateProduct;
      expect(() => call(tProduct), throwsA(isA<ServerException>()));
    });
  });

  group('DELETE Product', () {
    const tId = 1;

    test('should perform DELETE request with correct ID', () async {
      when(() => mockHttpClient.delete(any(), headers: any(named: 'headers')))
          .thenAnswer((_) async => http.Response('', 201));
      await dataSource.deleteProduct(tId);
      verify(() => mockHttpClient.delete(
        Uri.parse('$baseUrl/$tId'),
        headers: {'Content-Type': 'application/json'},
      ));
    });

    test('should throw ServerException on error code', () async {
      when(() => mockHttpClient.delete(any(), headers: any(named: 'headers')))
          .thenAnswer((_) async => http.Response('', 500));
      final call = dataSource.deleteProduct;
      expect(() => call(tId), throwsA(isA<ServerException>()));
    });
  });
}
