// product_local_data_source.dart

import '../models/product_model.dart';

/// Abstract contract for the local data source.
/// Defines methods to cache, retrieve, and manipulate products locally (e.g., SQLite, Hive).
abstract class ProductLocalDataSource {
  Future<List<ProductModel>> getCachedProducts();
  Future<void> cacheProducts(List<ProductModel> products);
  Future<void> saveProduct(ProductModel product);
  Future<void> updateProduct(ProductModel product);
  Future<void> deleteProduct(int id);
}