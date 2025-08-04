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

  static final Map<String, WidgetBuilder> appRoutes = {
    '/home': (_) => const HomePage(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Commerce App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      initialRoute: '/home',
      routes: appRoutes,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/details':
            final product = settings.arguments as Product;
            return PageRouteBuilder(
              settings: settings,
              pageBuilder: (_, __, ___) => DetailsPage(product: product),
              transitionDuration: const Duration(milliseconds: 800),
              transitionsBuilder: (_, animation, __, child) {
                return ScaleTransition(
                  scale: CurvedAnimation(parent: animation, curve: Curves.easeOut),
                  child: child,
                );
              },
            );

          case '/add':
            return PageRouteBuilder(
              settings: settings,
              pageBuilder: (_, __, ___) => const AddUpdatePage(),
              transitionDuration: const Duration(milliseconds: 700),
              transitionsBuilder: (_, animation, __, child) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(1, 0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                );
              },
            );

          case '/update':
            final product = settings.arguments as Product;
            return PageRouteBuilder(
              settings: settings,
              pageBuilder: (_, __, ___) => AddUpdatePage(product: product),
              transitionDuration: const Duration(milliseconds: 700),
              transitionsBuilder: (_, animation, __, child) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(1, 0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                );
              },
            );

          case '/search':
            return PageRouteBuilder(
              settings: settings,
              pageBuilder: (_, __, ___) => const SearchPage(),
              transitionDuration: const Duration(milliseconds: 700),
              transitionsBuilder: (_, animation, __, child) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(1, 0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                );
              },
            );

          default:
            // For any other route, fall back to routes map with default animation
            return null;
        }
      },
    );
  }
}

