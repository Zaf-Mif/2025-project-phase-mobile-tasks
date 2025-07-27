import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internship/model/products_repository.dart';
import 'package:internship/widgets/product_card.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  double start = 50.0, end = 1000.00;

  RangeValues val = RangeValues(50, 1000);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        centerTitle: true,
        title: Text(
          'Search Product',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.indigoAccent,
            size: 20,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SizedBox(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Leather',
                        hintStyle: GoogleFonts.poppins(color: Colors.grey),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: Color(0xFFCCCCCC),
                          ), // grey border
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Color(0xFFCCCCCC)),
                        ),
                        suffixIcon: Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.rotationY(3.1416),
                          child: Icon(
                            Icons.arrow_back,
                            size: 20,
                            color: Colors.indigoAccent,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 6),

                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.indigoAccent,
                    borderRadius: BorderRadius.circular(10),
                  ),

                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.filter_list_outlined,
                      size: 25,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
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
            const SizedBox(height: 10),

            // Bottom filter section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Category',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    decoration: InputDecoration(
                      // hintText: 'Search Category',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFFCCCCCC)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFFCCCCCC)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Price',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),

                  SliderTheme(
                    data: SliderThemeData(
                      thumbColor: Colors.white,
                      trackHeight: 8.0,
                      activeTrackColor: Colors.blue,
                      inactiveTrackColor: const Color.fromARGB(
                        255,
                        209,
                        208,
                        208,
                      ),
                      thumbShape: RoundSliderThumbShape(
                        enabledThumbRadius: 0.0,
                      ), 
                      overlayShape: RoundSliderOverlayShape(overlayRadius: 0.0),
                      showValueIndicator: ShowValueIndicator.always,
                    ),
                    child: RangeSlider(
                      min: 50,
                      max: 1000,
                      values: val,
                      labels: RangeLabels(
                        val.start.toStringAsFixed(1),
                        val.end.toStringAsFixed(1),
                      ),
                      onChanged: (value) {
                        setState(() {
                          val = value;
                        });
                      },
                    ),
                  ),

                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        debugPrint('This is the apply button');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'APPLY',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
