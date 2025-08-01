# 🧩 Task 14: Implement Local Data Source for Products

## ✅ Objective

Implement a local data source layer for caching and managing product data using `SharedPreferences`, adhering to **Clean Architecture** and **Test-Driven Development (TDD)** principles.

---

## 📦 Features

* Cache product list locally
* Retrieve cached products
* Save new product to local storage
* Update existing product
* Delete product from cache
* Proper error handling using `CacheException`

---

## 🛠️ Implementation Summary

### 1. **Interface** – `ProductLocalDataSource`

Located in:
`lib/features/product/data/datasources/product_local_data_sources.dart`

Defines abstract methods for:

* `getCachedProducts()`
* `cacheProducts(List<ProductModel>)`
* `saveProduct(ProductModel)`
* `updateProduct(ProductModel)`
* `deleteProduct(int id)`

### 2. **Concrete Class** – `ProductLocalDataSourcesImpl`

Implements all local operations using `SharedPreferences`.

### 3. **Model Used** – `ProductModel`

Serializes and deserializes product data for caching.

---

## 🧪 Tests

Located in:
`test/features/product/data/datasources/product_local_data_source_test.dart`

### ✅ Test Scenarios Covered:

* ✅ Should cache product list using `SharedPreferences`
* ✅ Should throw `CacheException` when caching fails
* ✅ Should return list of `ProductModel` when cached data exists
* ✅ Should throw `CacheException` when no cached data is found
* ✅ Should save product to cache
* ✅ Should update existing product
* ✅ Should throw `CacheException` when trying to update non-existent product
* ✅ Should delete product from cache
* ✅ Should throw `CacheException` if deleting a non-existent product

---

## ⚙️ Dependencies

Make sure the following are added in `pubspec.yaml`:

```yaml
dependencies:
  shared_preferences: ^2.5.3

dev_dependencies:
  flutter_test:
    sdk: flutter
  mocktail: ^1.0.1
```

---

## 📂 File Structure

```
lib/
└── features/
    └── product/
        └── data/
            └── datasources/
                └── product_local_data_sources.dart
                └── product_model.dart

test/
└── features/
    └── product/
        └── data/
            └── datasources/
                └── product_local_data_source_test.dart
```

---

## ⚠️ Error Handling

All operations throw `CacheException` from:

```
lib/core/error/exceptions.dart
```

If:

* Data is not available
* Operation (cache/save/update/delete) fails

---

## 📘 References

* Follows [Clean Architecture](https://resocoder.com/2019/09/26/flutter-tdd-clean-architecture-course-8-local-data-source/)
* Test-first approach using **TDD**

