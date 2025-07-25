import 'package:flutter/material.dart';
import 'package:internship/add_page.dart';
import 'package:internship/details_page.dart';
import 'package:internship/home_page.dart';
import 'package:internship/search_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Eccommerece',
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
      // ),
      initialRoute: '/home',
      routes: {
        '/home' : (BuildContext context) => const HomePage(),
        '/add' : (BuildContext context) => const AddPage(),
        '/search' : (BuildContext context) => const SearchPage(),
        '/details' : (BuildContext context) => const DetailsPage(),
      },
      // home: const HomePage(),

    );
  }
}



// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text('You have pushed the button this many times:'),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         backgroundColor: Colors.indigoAccent,
//         shape: CircleBorder(),
//         child: const Icon(
//           Icons.add,
//           color: Colors.white,
//           size: 40, // 35 
//         ),
//       ),
//     );
//   }
// }
