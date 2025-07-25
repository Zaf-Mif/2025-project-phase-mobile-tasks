import 'package:flutter/material.dart';
import 'package:internship/model/products_repository.dart';
import 'package:internship/widgets/app_bar_content.dart'; // App bar UI (logo, search, etc.)
import 'package:internship/widgets/product_card.dart';  // Displays individual product details
import 'package:internship/widgets/section_header.dart';// Section title for the product list

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: const AppBarContent(), // Custom app bar layout
      ),

      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            const SectionHeader(), // Title above product list

            const SizedBox(height: 10),

            // Expanded to take remaining space with product list
            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                padding: const EdgeInsets.only(bottom: 16),
                itemBuilder: (context, index) {
                  final product = products[index];
                  return ProductCard(product: product); // Product card UI
                },
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add');
        },
        backgroundColor: Colors.indigoAccent,
        shape: CircleBorder(),
        child: const Icon(
          Icons.add,
          size: 32, // 35
          color: Colors.white,
        ),
      ),
    );
  }
}
