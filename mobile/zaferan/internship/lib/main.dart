// main.dart
import 'package:flutter/material.dart';
import 'package:internship/model/product.dart';
import 'package:internship/pages/add_update_page.dart';
import 'package:internship/pages/details_page.dart';
import 'package:internship/pages/home_page.dart';
import 'package:internship/pages/search_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Commerce App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
      ),
      initialRoute: '/home',
      routes: {
        '/home': (context) => const HomePage(),
        // '/add': (context) => const AddUpdatePage(),
        '/search': (context) => const SearchPage(),
        '/details': (context) {
          final product = ModalRoute.of(context)!.settings.arguments as Product;
          return DetailsPage(product: product);
        },
        '/update': (context) {
          final product = ModalRoute.of(context)!.settings.arguments as Product;
          return AddUpdatePage(product: product);
        },
      },
    );
  }
}
