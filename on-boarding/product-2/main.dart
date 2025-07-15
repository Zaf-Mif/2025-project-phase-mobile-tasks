import 'Ecommerce.dart';
import 'Product.dart';
import 'dart:io';
void main() {
  Ecommerce ecommerce = Ecommerce();

  while (true) {
    print("\n  Welcome to the Product Management System");
    print("1. Add New Product");
    print("2. View All Products");
    print("3. View Single Product");
    print("4. Edit Product");
    print("5. Remove Product");
    print("6. Exit");

    // choice input
    print("Please enter your choice:");
    String? choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        addNewProduct(ecommerce);
        break;
      case '2':
        ecommerce.viewAllProduct();
        break;
      case '3':
        viewSingleProduct(ecommerce);
        break;
      case '4':
        editProduct(ecommerce);
        break;
      case '5':
        removeProduct(ecommerce);
        break;
      case '6':
        print("Exiting the system. Goodbye!");
        exit(0);
      default:
        print("Invalid choice, please try again.");
    }
  }
}

// Functions to handle user input for product management
void addNewProduct(Ecommerce ecommerce) {
  print("Enter product name:");
  String name = stdin.readLineSync() ?? "";

  print("Enter product description:");
  String description = stdin.readLineSync() ?? "";

  print("Enter product price:");
  double price = double.tryParse(stdin.readLineSync() ?? "") ?? -1;

  if (price < 0) {
    print("Invalid price entered. Product not added.");
    return;
  }

  var product = Product(name, description, price);
  ecommerce.addNewProduct(product);
}

void viewSingleProduct(Ecommerce ecommerce) {
  print("Enter product number to view:");
  int index = int.tryParse(stdin.readLineSync() ?? "") ?? -1;

  ecommerce.viewSingleProduct(index - 1); // zero indexed
}

void editProduct(Ecommerce ecommerce) {
  print("Enter product number to edit:");
  int index = int.tryParse(stdin.readLineSync() ?? "") ?? -1;

  if (index < 1 || index > ecommerce.products.length) {
    print("Invalid product number.");
    return;
  }

  print("Enter new name:");
  String newName = stdin.readLineSync() ?? "";

  print("Enter new description:");
  String newDescription = stdin.readLineSync() ?? "";

  print("Enter new price:");
  double newPrice = double.tryParse(stdin.readLineSync() ?? "") ?? -1;

  if (newPrice < 0) {
    print("Invalid price entered. Edit cancelled.");
    return;
  }

  ecommerce.editProduct(index - 1, newName, newDescription, newPrice);
}

void removeProduct(Ecommerce ecommerce) {
  print("Enter product number to remove:");
  int index = int.tryParse(stdin.readLineSync() ?? "") ?? -1;

  ecommerce.removeProduct(index - 1);
}