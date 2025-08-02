// product_remote_data_source.dart

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../../core/error/exceptions.dart';
import '../models/product_model.dart';

/// Abstract contract for the remote data source.
/// Defines methods to fetch and manipulate products from a remote API or server.
abstract class ProductRemoteDataSource {
  /// Fetches all products from the remote server.
  ///
  /// Returns a list of [ProductModel] instances.
  ///
  /// Throws a [ServerException] if the network request fails,
  /// the server returns an error, or the data cannot be parsed.
  Future<List<ProductModel>> getAllProducts();

  /// Fetches a single [ProductModel] by its [id] from the server.
  ///
  /// Returns a [ProductModel] if found, or `null` if not found.
  ///
  /// Throws a [ServerException] if the network request fails or the server returns an error.
  Future<ProductModel?> getProductById(int id);

  /// Sends a POST request to create a new product on the remote server.
  ///
  /// Throws a [ServerException] if the request fails or the server rejects the product data.
  Future<void> createProduct(ProductModel product);

  /// Sends a PUT request to update an existing product on the remote server.
  ///
  /// Throws a [ServerException] if the update fails or the product does not exist.
  Future<void> updateProduct(ProductModel product);

  /// Sends a DELETE request to remove a product by its [id] from the server.
  ///
  /// Throws a [ServerException] if the product cannot be found or the deletion fails.
  Future<void> deleteProduct(int id);
}

/// Implementation of [ProductRemoteDataSource] using the `http` package.
class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final http.Client client;

  ProductRemoteDataSourceImpl({required this.client});

  static const _baseUrl =
      'https://g5-flutter-learning-path-be.onrender.com/api/v1/products';

  @override
  Future<List<ProductModel>> getAllProducts() async {
    final response = await client.get(
      Uri.parse(_baseUrl),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      // final Map<String, dynamic> jsonMap =
      //     json.decode(response.body) as Map<String, dynamic>;
      final Map<String, dynamic> jsonMap =
          json.decode(response.body);
      final List<dynamic> jsonList = jsonMap['data'] as List<dynamic>;

      return jsonList
          .map((json) => ProductModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      throw ServerException('Failed to load products: ${response.statusCode}');
    }
  }

  @override
  Future<ProductModel?> getProductById(int id) async {
    final response = await client.get(
      Uri.parse('$_baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      // final Map<String, dynamic> jsonMap =
      //     json.decode(response.body) as Map<String, dynamic>;
      final Map<String, dynamic> jsonMap = json.decode(response.body);
      
      return ProductModel.fromJson(jsonMap);
    } else {
      throw ServerException(
          'Failed to fetch product by ID: ${response.statusCode}');
    }
  }

  @override
  Future<void> createProduct(ProductModel product) async {
    final response = await client.post(
      Uri.parse(_baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(product.toJson()),
    );

    if (response.statusCode != 201) {
      throw ServerException(
          'Failed to create product: ${response.statusCode}');
    }
  }

  @override
  Future<void> updateProduct(ProductModel product) async {
    final response = await client.put(
      Uri.parse('$_baseUrl/${product.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(product.toJson()),
    );

    if (response.statusCode != 201) {
      throw ServerException(
          'Failed to update product: ${response.statusCode}');
    }
  }

  @override
  Future<void> deleteProduct(int id) async {
    final response = await client.delete(
      Uri.parse('$_baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 201) {
      throw ServerException(
          'Failed to delete product: ${response.statusCode}');
    }
  }
}
