import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';
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

const cachedProductsKey = 'CACHED_PRODUCTS';

class ProductLocalDataSourcesImpl implements ProductLocalDataSource {
  final SharedPreferences sharedPreferences;

  ProductLocalDataSourcesImpl({required this.sharedPreferences});

  @override
  Future<void> cacheProducts(List<ProductModel> products) async {
    final jsonList = products.map((e) => e.toJson()).toList();
    final jsonString = jsonEncode(jsonList);
    final success = await sharedPreferences.setString(cachedProductsKey, jsonString);
    if (!success) throw CacheException();
  }

  @override
  Future<List<ProductModel>> getCachedProducts() async {
    final jsonString = sharedPreferences.getString(cachedProductsKey);
    if (jsonString != null) {
      try {
        final decoded = jsonDecode(jsonString) as List;
        return decoded.map((e) => ProductModel.fromJson(e)).toList();
      } catch (_) {
        throw CacheException();
      }
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> saveProduct(ProductModel product) async {
    final current = await getCachedProducts();
    final updated = [...current, product];
    await cacheProducts(updated);
  }

  @override
  Future<void> updateProduct(ProductModel product) async {
    final current = await getCachedProducts();
    final index = current.indexWhere((e) => e.id == product.id);
    if (index == -1) throw CacheException();

    current[index] = product;
    await cacheProducts(current);
  }

  @override
  Future<void> deleteProduct(int id) async {
    final current = await getCachedProducts();
    final updated = current.where((e) => e.id != id).toList();
    if (current.length == updated.length) throw CacheException();

    await cacheProducts(updated);
  }
}
