import 'Product.dart';
class Ecommerce extends ProductManager {
  @override
  void addNewProduct(Product product) {
    if (product.name.trim().isEmpty) {
      print("Product name cannot be empty. Please enter a valid name.");
      return;
    }
    if (product.price < 0) {
      print("Product price cannot be negative. Please enter a valid price.");
      return;
    }
    super.addNewProduct(product);
  }

  @override
  void viewSingleProduct(int index) {
    if (index < 0 || index >= products.length) {
      print("Invalid product number. Please enter a valid number.");
      return;
    }
    super.viewSingleProduct(index);
  }

  @override
  void editProduct(int index, String newName, String newDescription, double newPrice) {
    if (index < 0 || index >= products.length) {
      print("Invalid product number. Cannot edit.");
      return;
    }
    if (newName.trim().isEmpty) {
      print("Product name cannot be empty.");
      return;
    }
    if (newPrice < 0) {
      print("Product price cannot be negative.");
      return;
    }
    super.editProduct(index, newName, newDescription, newPrice);
  }

  @override
  void removeProduct(int index) {
    if (index < 0 || index >= products.length) {
      print("Invalid product number. Cannot remove.");
      return;
    }
    super.removeProduct(index);
  }
}