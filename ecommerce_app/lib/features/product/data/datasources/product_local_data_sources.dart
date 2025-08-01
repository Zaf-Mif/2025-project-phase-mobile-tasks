import 'package:shared_preferences/shared_preferences.dart';

import '../models/product_model.dart';

/// Abstract contract for the local data source.
/// Defines methods to cache, retrieve, and manipulate products locally (e.g., SQLite, Hive).
abstract class ProductLocalDataSource {
  /// Returns the list of cached [ProductModel]s.
  ///
  /// Throws a [CacheException] if no products are found or data retrieval fails.
  Future<List<ProductModel>> getCachedProducts();

  /// Caches a list of [ProductModel]s.
  ///
  /// Throws a [CacheException] if saving the data fails.
  Future<void> cacheProducts(List<ProductModel> products);

  /// Saves a single [ProductModel] to local storage.
  ///
  /// Throws a [CacheException] if the product cannot be saved.
  Future<void> saveProduct(ProductModel product);

  /// Updates an existing [ProductModel] in the local cache.
  ///
  /// Throws a [CacheException] if the update fails or if the product does not exist.
  Future<void> updateProduct(ProductModel product);

  /// Deletes a [ProductModel] from local storage using its [id].
  ///
  /// Throws a [CacheException] if the product cannot be found or deletion fails.
  Future<void> deleteProduct(int id);
}

class ProductLocalDataSourcesImpl implements ProductLocalDataSource {
  late final SharedPreferences sharedPreferences;

  ProductLocalDataSourcesImpl({required this.sharedPreferences});
  @override
  Future<void> cacheProducts(List<ProductModel> products) {
    // TODO: implement cacheProducts
    throw UnimplementedError();
  }

  @override
  Future<void> deleteProduct(int id) {
    // TODO: implement deleteProduct
    throw UnimplementedError();
  }

  @override
  Future<List<ProductModel>> getCachedProducts() {
    // TODO: implement getCachedProducts
    throw UnimplementedError();
  }

  @override
  Future<void> saveProduct(ProductModel product) {
    // TODO: implement saveProduct
    throw UnimplementedError();
  }

  @override
  Future<void> updateProduct(ProductModel product) {
    // TODO: implement updateProduct
    throw UnimplementedError();
  }
}
