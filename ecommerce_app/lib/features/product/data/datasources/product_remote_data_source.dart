// product_remote_data_source.dart

import 'package:http/http.dart' as http;

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

  /// Sends a PUT/PATCH request to update an existing product on the remote server.
  ///
  /// Throws a [ServerException] if the update fails or the product does not exist.
  Future<void> updateProduct(ProductModel product);

  /// Sends a DELETE request to remove a product by its [id] from the server.
  ///
  /// Throws a [ServerException] if the product cannot be found or the deletion fails.
  Future<void> deleteProduct(int id);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  late final http.Client client;

  ProductRemoteDataSourceImpl({required this.client});

  @override
  Future<void> createProduct(ProductModel product) {
    // TODO: implement createProduct
    throw UnimplementedError();
  }

  @override
  Future<void> deleteProduct(int id) {
    // TODO: implement deleteProduct
    throw UnimplementedError();
  }

  @override
  Future<List<ProductModel>> getAllProducts() {
    // TODO: implement getAllProducts
    throw UnimplementedError();
  }

  @override
  Future<ProductModel?> getProductById(int id) {
    // TODO: implement getProductById
    throw UnimplementedError();
  }

  @override
  Future<void> updateProduct(ProductModel product) {
    // TODO: implement updateProduct
    throw UnimplementedError();
  }
}
