import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Available Products',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Colors.black,
            fontSize: 24,
          ),
        ),
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade400, width: 1),
          ),
          child: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/search');
            },
            icon: Icon(
              Icons.search,
              size: 30,
              color: const Color.fromARGB(255, 100, 100, 100),
            ),
          ),
        ),
      ],
    );
  }
}