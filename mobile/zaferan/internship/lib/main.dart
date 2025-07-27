import 'package:flutter/material.dart';
import 'package:internship/pages/add_update_page.dart';
// import 'package:internship/pages/details_page.dart';
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
      title: 'E-Commerce',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
      ),
      initialRoute: '/home', // initial page
      routes: {
        '/home' : (BuildContext context) => const HomePage(),
        '/add' : (BuildContext context) => const AddPage(),
        '/search' : (BuildContext context) => const SearchPage(),
        // '/details' : (BuildContext context) => const DetailsPage(),
      },
    );
  }
}