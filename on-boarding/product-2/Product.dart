import 'dart:io';

class Product {
  String _name, _description;
  double _price;

  // constructor
  Product(this._name, this._description, this._price);

  // getters for private variables
  String get name => _name;
  String get description => _description;
  double get price => _price;

  // setters for private variables
  set name(String? value) {
    _name = value ?? _name;
  }

  set description(String? value) {
    _description = value ?? _description;
  }

  set price(double? value) {
    _price = value ?? _price;
  }
}


// Class to manage products
class ProductManager {
  // initializing a list to store a list of products
  var _products = <Product>[];
  
  // getter for products
  List<Product> get products => _products;

  // add a new product to the list
  void addNewProduct(Product product) {
    _products.add(product);
    print("Product ${product.name} added successfully. You can now view it, edit it or remove it.");
    print("\nPress Enter to return to the main menu..."); 
    stdin.readLineSync();
  }

  // view all products in the list
  void viewAllProduct() {
    if (_products.isEmpty) {
      print("There are no products available.");
    } 
    else {
      var i = 0;
      for (var product in _products) {
        i++;
        print(
          "Product $i: It's ${product.name}, which is ${product.description} and it costs ${product.price} dollars.",
        );
      }
    }
    print("\nPress Enter to return to the main menu...");
    stdin.readLineSync();
  }

  // view a single product by its index
  void viewSingleProduct(int index) {
    if (index < 0 || index >= _products.length) {
      print("Invalid product number.");
    }
    else{
      var pro = _products[index];
      var product = Product(pro.name, pro.description, pro.price);
      print("Product: ${product.name}, Which is ${product.description} and it costs ${product.price} dollars.");
    }
    print("\nPress Enter to return to the main menu..."); 
    stdin.readLineSync();
  }

  // edit a product by its index
  void editProduct(int index, String newName, String newDescription, double newPrice) {
    if (index < 0 || index >= _products.length) {
      print("Invalid product number.");
    }
    var product = _products[index];
    product.name = newName;
    product.description = newDescription;
    product.price = newPrice;
    print("Product ${product.name} updated successfully.");
    print("\nPress Enter to return to the main menu..."); 
    stdin.readLineSync();
  }
  // remove a product by its index
  void removeProduct(int index){
    if (index < 0 || index >= _products.length) {
      print("Invalid product number.");
    } 
    else {
      var removedProduct = _products.removeAt(index);
      print("Product ${removedProduct.name} removed successfully.");
    }
    print("\nPress Enter to return to the main menu...");
    stdin.readLineSync();
  }
}