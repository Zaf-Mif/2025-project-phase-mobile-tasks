---

## 🧱 Clean Architecture – Implementation Guide

This project implements the **Clean Architecture** pattern to ensure code scalability, maintainability, and testability.

---

## 📁 Folder Structure (Step 1)

Organized under `lib/` and `test/` using clean architectural boundaries:

```
lib/
├── core/                    # (Shared logic - error handling, utils) [Placeholder for future expansion]
├── features/
│   └── product/
│       ├── data/
│       │   └── models/
│       │       └── product_model.dart        # ✅ JSON serialization logic
│       ├── domain/
│       │   ├── entities/
│       │   │   └── product.dart              # ✅ Core business entity
│       │   ├── repositories/
│       │   │   └── product_repository.dart   # ✅ Abstract class for data source
│       │   └── usecases/
│       │       ├── create_product.dart       # ✅ Create product use case
│       │       └── delete_product.dart       # ✅ Delete product use case
└── test/
    └── features/
        └── product/
            ├── data/
            │   └── product_model_test.dart   # ✅ Unit test for JSON conversion
            └── domain/
                └── usecases/
                    ├── create_product_test.dart  # ✅ Tested with mock repository
                    └── delete_product_test.dart  # ✅ Tested with mock repository
```

---

## 🧠 Data Flow (Step 2)

### 📌 Domain Layer

* `product.dart`: A pure **Entity** (Extends `Equatable`)
* Use cases (`create_product.dart`, `delete_product.dart`): Accept entity data and call the repository

### 📌 Data Layer

* `product_model.dart`: Extends the `Product` entity

  * `fromJson(Map<String, dynamic>) → ProductModel`
  * `toJson() → Map<String, dynamic>`
  * Used to communicate with data sources (e.g., API)

### 📌 Tests

* `product_model_test.dart`:
  ✔ Verifies `fromJson()` and `toJson()`
  ✔ Fix applied to use `expect(actual, equals(expected))`

* `create_product_test.dart` and `delete_product_test.dart`:
  ✔ Use `MockProductRepository` with `mocktail`
  ✔ Verify use case calls expected repository method
  ✔ Test passes using `Right(null)` from `dartz`

---

## 🔍 Example: `ProductModel` Conversion Logic

```dart
factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
  id: json['id'],
  name: json['name'],
  imageUrl: json['image'],
  price: (json['price'] as num).toDouble(),
  description: json['description'],
);

Map<String, dynamic> toJson() => {
  'id': id,
  'name': name,
  'image': imageUrl,
  'price': price,
  'description': description,
};
```

---

## 🧪 Test Summary

### ✅ `product_model_test.dart`

```dart
test('ProductModel fromJson should return valid ProductModel', () {
  final jsonMap = {
    'id': 1,
    'name': 'Test Product',
    'price': 9.99,
    'image': 'image.jpg',
    'description': 'A test product',
  };

  final model = ProductModel.fromJson(jsonMap);
  final expected = ProductModel(...); // Your expected fields

  expect(model, equals(expected));
});
```

### ✅ `create_product_test.dart` and `delete_product_test.dart`

* Tested behavior of use cases:

  * Proper delegation to `ProductRepository`
  * Return value using `dartz.Right`
  * Verified with `verify()` and `verifyNoMoreInteractions()`

---

## 🧪 Run Tests

To run your tests and check they pass:

```bash
flutter test test/features/product/data/product_model_test.dart
flutter test test/features/product/domain/usecases/create_product_test.dart
flutter test test/features/product/domain/usecases/delete_product_test.dart
flutter test test/features/product/domain/usecases/update_product_test.dart
flutter test test/features/product/domain/usecases/view_product_test.dart
flutter test test/features/product/domain/usecases/view_all_products_test.dart

```
