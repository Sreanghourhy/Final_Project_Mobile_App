import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/bookjompa.dart';
import '../shared/button.dart';
import '../shared/styled_text.dart';
import 'page1.dart';

class AllBook extends StatefulWidget {
  final BookData book;

  const AllBook({required this.book, Key? key}) : super(key: key);

  @override
  _AllBookState createState() => _AllBookState();
}

class _AllBookState extends State<AllBook> {
  late TextEditingController nameController;
  late TextEditingController authorController;
  late TextEditingController ratingController;
  late TextEditingController descriptionController;
  late TextEditingController readController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.book.bookname);
    authorController = TextEditingController(text: widget.book.author);
    ratingController = TextEditingController(text: widget.book.rating.toString());
    descriptionController = TextEditingController(text: widget.book.description);
    readController = TextEditingController(text: widget.book.read);
  }

  @override
  Widget build(BuildContext context) {
    return allbook(widget.book, context);
  }

  Widget allbook(BookData book, BuildContext context) {
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
        width: double.infinity,
        height: 150.0,
        margin: const EdgeInsets.only(bottom: 12.0),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 12.0),
              height: 128.0,
              width: 83.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                image: DecorationImage(
                  image: NetworkImage(book.bookcover),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    book.bookname,
                    style: const TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    book.author,
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.yellow,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Expanded(
                    child: Text(
                      book.description,
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  // const SizedBox(height: 12.0),
                  Row(
                    children: [
                      // const SizedBox(width: 4.0),
                      const Icon(Icons.star, color: Colors.yellow, size: 18),
                      const SizedBox(width: 4.0),
                      Text(
                        book.rating.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.white),
                        onPressed: () {
                          _showEditDialog(context, book);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditDialog(BuildContext context, BookData book) {
    final TextEditingController nameController = TextEditingController(text: book.bookname);
    final TextEditingController authorController = TextEditingController(text: book.author);
    final TextEditingController ratingController = TextEditingController(text: book.rating.toString());
    final TextEditingController descriptionController = TextEditingController(text: book.description);
    final TextEditingController readController = TextEditingController(text: book.read);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          title: Text(
            'Edit Book',
            style: GoogleFonts.kanit(color: Colors.white),
          ),
          content: Container(
            width: MediaQuery.of(context).size.width * 0.8, // Set width to 80% of screen width
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'Book Name',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      prefixIcon: Icon(Icons.book, color: Colors.white),
                    ),
                    style: const TextStyle(color: Colors.white), // Set text color to white
                  ),
                  const SizedBox(height: 10.0),
                  TextField(
                    controller: authorController,
                    decoration: const InputDecoration(
                      labelText: 'Author',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      prefixIcon: Icon(Icons.person, color: Colors.white),
                    ),
                    style: const TextStyle(color: Colors.white), // Set text color to white
                  ),
                  const SizedBox(height: 10.0),
                  const SizedBox(height: 10.0),
                  TextField(
                    controller: ratingController,
                    decoration: const InputDecoration(
                      labelText: 'Rating',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      prefixIcon: Icon(Icons.star, color: Colors.white),
                    ),
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: Colors.white), // Set text color to white
                  ),
                  const SizedBox(height: 10.0),
                  TextField(
                    controller: descriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      prefixIcon: Icon(Icons.description, color: Colors.white),
                    ),
                    style: const TextStyle(color: Colors.white), // Set text color to white
                    maxLines: null, // Allow the description to be multiline
                  ),
                  const SizedBox(height: 10.0),
                  TextField(
                    controller: readController,
                    decoration: const InputDecoration(
                      labelText: 'Read Status',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      prefixIcon: Icon(Icons.check_circle, color: Colors.white),
                    ),
                    style: const TextStyle(color: Colors.white), // Set text color to white
                  ),
                ],
              ),
            ),
          ),
          actions: [
            StyledButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const StyledHeading('Cancel'),
            ),
            StyledButton(
              onPressed: () {
                // Update the book details
                setState(() {
                  book.bookname = nameController.text;
                  book.author = authorController.text;
                  book.rating = double.parse(ratingController.text);
                  book.description = descriptionController.text;
                  book.read = readController.text;
                  _saveBooks();
                  _filterBooks();
                });

                Navigator.of(context).pop();
              },
              child: const StyledHeading('Save'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _saveBooks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String booksString = json.encode(widget.book.toJson());
    prefs.setString('books', booksString);
  }

  void _filterBooks() {
    // Implement the filter logic here
  }
}