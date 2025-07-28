import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Add Product',
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
          icon: const Icon(Icons.arrow_back_ios, color: Colors.indigoAccent,),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 20),

              // upload image box
              Center(
                child: Container(
                  width: double.infinity,
                  height: 190,
                  decoration: BoxDecoration(
                    color: Color(0xFFF3F3F3),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 5),
                      Container(
                        height: 48,
                        width: 48,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 218, 215, 215),
                          shape: BoxShape.rectangle
                        ),
                        child: Image.asset(
                          'lib/icons/image1.png',
                          width: 40,
                          height: 40,
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'upload image',
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 16), 

              Text(
                  'name',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),

              SizedBox(height: 8),

              // name text field container
              Center(
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color(0xFFF3F3F3),
                    // color: Colors.black,
                    borderRadius: BorderRadius.circular(12)
                  ),
                ),
              ),

              SizedBox(height: 16), 

              Text(
                  'category',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),

              SizedBox(height: 8),

              // Category text field container
              Center(
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color(0xFFF3F3F3),
                    // color: Colors.black,
                    borderRadius: BorderRadius.circular(12)
                  ),
                ),
              ),

              SizedBox(height: 8),

              Text(
                  'price',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),

              SizedBox(height: 8),

              // Price text field container
              Center(
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color(0xFFF3F3F3),
                    // color: Colors.black,
                    borderRadius: BorderRadius.circular(12)
                  ),

                  // to add the dollar sign
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  alignment: Alignment.centerRight,
                  child: Text(
                    '\$',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 8),

              Text(
                  'description',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),

              SizedBox(height: 8),

              // description text field container
              Center(
                child: Container(
                  width: double.infinity,
                  height: 140,
                  decoration: BoxDecoration(
                    color: Color(0xFFF3F3F3),
                    // color: Colors.black,
                    borderRadius: BorderRadius.circular(12)
                  ),
                ),
              ),
              
              SizedBox(height: 30),

              // ADD Button
              Center(
                child: GestureDetector(
                  onTap : (){
                    Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.indigoAccent,
                      // color: Colors.black,
                      borderRadius: BorderRadius.circular(12)
                    ),
                    // padding: EdgeInsets.symmetric(horizontal: 25),
                    alignment: Alignment.center,
                    child: Text(
                      'ADD',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 16),
              
              // Delete Button
              Center(
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    // color: Colors.black,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.red, 
                      width: 1.5,         
                    ),
                     
                  ),
                  // padding: EdgeInsets.symmetric(horizontal: 25),
                  alignment: Alignment.center,
                  child: Text(
                    'DELETE',
                    style: GoogleFonts.poppins(
                      color: Colors.red,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
            ],            
          ),
        ),
      ),
    );
  }
}
