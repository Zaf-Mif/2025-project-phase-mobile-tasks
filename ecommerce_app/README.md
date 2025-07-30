---

# 🧱 eCommerce App – Clean Architecture Implementation Guide

This Flutter project demonstrates the use of **Clean Architecture** to build a scalable, maintainable, and testable eCommerce mobile application. It incorporates domain-driven design, separation of concerns, and test-driven development.

---

## 📁 Folder Structure (Step 1)

The project follows a layered architecture structured as follows:

```
lib/
├── core/                                # Shared logic (error handling, etc.)
│   └── error/
│       └── failures.dart                # Base error handling classes (e.g., ServerFailure)
│
├── features/
│   └── product/
│       ├── data/
│       │   └── product_model.dart       # Data model with JSON serialization logic
│       │
│       ├── domain/
│       │   ├── entities/
│       │   │   └── product.dart         # Core business entity
│       │   │
│       │   ├── repositories/
│       │   │   └── product_repository.dart  # Abstract repository definition
│       │   │
│       │   └── usecases/
│       │       ├── create_product.dart      # Use case to create a product
│       │       ├── delete_product.dart      # Use case to delete a product
│       │       ├── update_product.dart      # Use case to update a product
│       │       ├── view_all_products.dart   # Use case to fetch all products
│       │       └── view_product.dart        # Use case to fetch a single product
│       │
│       └── main.dart                     # Entry point for the feature

test/
├── features/
│   └── product/
│       ├── data/
│       │   └── product_model_test.dart      # Unit test for ProductModel
│       │
│       ├── domain/
│       │   └── usecases/
│       │       ├── create_product_test.dart     # Unit test for CreateProduct use case
│       │       ├── delete_product_test.dart     # Unit test for DeleteProduct use case
│       │       ├── update_product_test.dart     # Unit test for UpdateProduct use case
│       │       ├── view_all_products_test.dart  # Unit test for ViewAllProducts use case
│       │       └── view_product_test.dart       # Unit test for ViewProduct use case
```

---

## 🧠 Data Flow (Step 2)

### 📌 Domain Layer

* **Entity** (`product.dart`): Pure domain model extending `Equatable`.
* **Use Cases**:

  * Handle business logic.
  * Accept input and delegate operations to the repository.

### 📌 Data Layer

* **ProductModel** (`product_model.dart`)

  * Extends the domain entity `Product`.
  * Contains methods for JSON serialization/deserialization:

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

## 🧪 Unit Testing Summary

### ✅ `product_model_test.dart`

Test: Ensure the JSON conversion methods work as expected.

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
  final expected = ProductModel(
    id: 1,
    name: 'Test Product',
    price: 9.99,
    imageUrl: 'image.jpg',
    description: 'A test product',
  );

  expect(model, equals(expected));
});
```

### ✅ `create_product_test.dart` and `delete_product_test.dart`

* Use **`MockProductRepository`** with **mocktail**.
* Verify delegation to repository using `verify()` and `verifyNoMoreInteractions()`.
* Return value verified using `Right(null)` from **dartz**.

---

## ▶️ Run All Tests

```bash
flutter test test/features/product/data/product_model_test.dart
flutter test test/features/product/domain/usecases/create_product_test.dart
flutter test test/features/product/domain/usecases/delete_product_test.dart
flutter test test/features/product/domain/usecases/update_product_test.dart
flutter test test/features/product/domain/usecases/view_product_test.dart
flutter test test/features/product/domain/usecases/view_all_products_test.dart
```

---

## ✅ Features Completed

* Clean architecture folder setup
* Domain entity with `Equatable`
* Use cases (Create, Delete, Update, View One, View All)
* Product model with JSON serialization
* Unit tests for model and use cases
* Linter rules configured for consistent code style

---
