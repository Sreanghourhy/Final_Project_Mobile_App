import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/bookjompa.dart';
import '../shared/button.dart';
import '../shared/styled_text.dart';

class BookDetailScreen extends StatelessWidget {
  final BookData book;

  const BookDetailScreen({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          book.bookname,
          style: GoogleFonts.kanit(color: Colors.white),
        ),
        backgroundColor: Colors.grey[900],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Centered Book Cover
            Center(
              child: Container(
                height: 200.0,
                width: 140.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  image: DecorationImage(
                    image: NetworkImage(book.bookcover),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            // Book Name
            Text(
              book.bookname,
              style: GoogleFonts.kanit(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8.0),
            // Author Name
            Text(
              "by ${book.author}",
              style: GoogleFonts.kanit(
                fontSize: 16.0,
                color: Colors.grey[700],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20.0),
            // Type, Pages, and Rating
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Pages
                const SizedBox(width: 12.0),
                // Rating
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      size: 18.0,
                      color: Colors.yellow[700],
                    ),
                    const SizedBox(width: 6.0),
                    Text(
                      "${book.rating}",
                      style: GoogleFonts.kanit(
                        fontSize: 14.0,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20.0),

            // Title "Read some"
            Text(
              "Read some",
              style: GoogleFonts.kanit(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),

            // Excerpt Section
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.black,
              ),
              child: Text(
                book.read, // Assuming `read` is a field in the BookData model
                style: GoogleFonts.kanit(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(height: 20.0),

            // Read Now Button
            // StyledButton(
            //   onPressed: () {
            //     // Action for "Read Now" button
            //   },
            //   child: const StyledHeading(
            //     'Read Now',
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
