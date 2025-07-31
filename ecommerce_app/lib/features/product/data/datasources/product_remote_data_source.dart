// product_remote_data_source.dart

import '../models/product_model.dart';

/// Abstract contract for the remote data source.
/// Defines methods to fetch and manipulate products from a remote API or server.
abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getAllProducts();
  Future<ProductModel?> getProductById(int id);
  Future<void> createProduct(ProductModel product);
  Future<void> updateProduct(ProductModel product);
  Future<void> deleteProduct(int id);
}
