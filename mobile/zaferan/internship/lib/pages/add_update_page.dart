import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internship/model/product.dart';

class AddUpdatePage extends StatefulWidget {
  final Product product;
  // final int? index;
  
  const AddUpdatePage({super.key, required  this.product});

  @override
  State<AddUpdatePage> createState() => _AddUpdatePageState();
}

class _AddUpdatePageState extends State<AddUpdatePage> {
  late TextEditingController nameController;
  late TextEditingController descriptionController;
  late TextEditingController categoryController;
  late TextEditingController priceController;

  bool get isUpdateMode => widget.product != null;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.product?.name ?? '');
    categoryController = TextEditingController(text: widget.product?.category ?? '');
    priceController = TextEditingController(
      text: widget.product != null ? widget.product!.price.toString() : '',
    );
    descriptionController = TextEditingController(text: widget.product?.description ?? '');
    }

   @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    categoryController.dispose();
    priceController.dispose();
    super.dispose();
  }

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
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  alignment: Alignment.centerLeft,
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(border: InputBorder.none),
                    style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500),
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

                  padding: EdgeInsets.symmetric(horizontal: 12),
                  alignment: Alignment.centerLeft,
                  child: TextField(
                    controller: categoryController,
                    readOnly: widget.product != null,
                    decoration: InputDecoration(border: InputBorder.none),
                    style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500),
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
                  
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: TextField(
                            controller: priceController,
                            readOnly: widget.product != null, // read-only when updating
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),

                  // to add the dollar sign
                      Text(
                        '\$',
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ]
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
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: TextField(
                    controller: descriptionController,
                    maxLines: null,
                    expands: true,
                    decoration: InputDecoration(border: InputBorder.none),
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              
              SizedBox(height: 30),

              // ADD Button
              Center(
                child: GestureDetector(
                  onTap : (){
                    final newProduct = Product(
                      name: nameController.text,
                      description: descriptionController.text,
                      price: double.tryParse(priceController.text) ?? 0,
                      category: categoryController.text,
                      image: widget.product?.image ?? 'lib/icons/default_image.png',
                      rating: widget.product?.rating ?? 0, 
                      sizes: widget.product?.sizes ?? [], // Keep sizes from existing product if updating, else empty list
                    );

                    Navigator.pop(context, newProduct); 
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
