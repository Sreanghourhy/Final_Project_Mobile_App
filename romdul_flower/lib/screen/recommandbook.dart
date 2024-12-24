import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/bookjompa.dart';
import 'page1.dart';

class RecommandBook extends StatelessWidget {
  final BookData book;

  const RecommandBook({required this.book, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookDetailScreen(book: book),
          ),
        );
      },
      child: Container(
        width: 122.0,
        margin: const EdgeInsets.only(right: 12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 180.5,
              width: 121.66,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                image: DecorationImage(
                  image: NetworkImage(book.bookcover),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 8.0), // Added spacing
            Flexible(
              child: Text(
                book.bookname,
                style: GoogleFonts.kanit(fontSize: 16.0, color: Colors.white),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}