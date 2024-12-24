import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:romdul_flowe/shared/styled_text.dart';
import '../models/bookjompa.dart';
import '../shared/button.dart';
import 'createscreen.dart';
import 'page1.dart';
import 'recommandbook.dart';
import 'allbook.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<BookData> books = [];
  List<BookData> filteredBooks = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadBooks();
    searchController.addListener(_filterBooks);
  }

  Future<void> _loadBooks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? booksString = prefs.getString('books');

    if (booksString != null) {
      List<dynamic> booksJson = json.decode(booksString);
      setState(() {
        books = booksJson.map((json) => BookData.fromJson(json)).toList();
        filteredBooks = books;
      });
    }
  }

  Future<void> _saveBooks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String booksString = json.encode(books.map((book) => book.toJson()).toList());
    prefs.setString('books', booksString);
  }

  void _navigateToCreateBookScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateBookScreen(
          onSave: (newBook) {
            setState(() {
              books.add(newBook);
              _saveBooks();
              _filterBooks();
            });
          },
        ),
      ),
    );
  }

  void _filterBooks() {
    setState(() {
      filteredBooks = books
          .where((book) =>
              book.bookname.toLowerCase().contains(searchController.text.toLowerCase()) ||
              book.author.toLowerCase().contains(searchController.text.toLowerCase()))
          .toList();
    });
  }

  void _removeBook(int index) {
    setState(() {
      books.removeAt(index);
      _saveBooks();
      _filterBooks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const StyledTitle('SOSORO'),
            StyledButton(
              onPressed: _navigateToCreateBookScreen,
              child: const StyledHeading('Create New'),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 18.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSearchField(),
              const SizedBox(height: 20.0),
              _buildRecommandSection(),
              const SizedBox(height: 20.0),
              _buildBooksList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: searchController,
      style: GoogleFonts.kanit(
        textStyle: Theme.of(context).textTheme.titleMedium,
        color: Colors.black,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xffe6e6e6),
        prefixIcon: const Icon(Icons.search),
        contentPadding: const EdgeInsets.all(8.0),
        hintText: "Search your favorite Book...",
        hintStyle: GoogleFonts.kanit(
          textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.grey,
              ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildRecommandSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Recommand",
          style: GoogleFonts.kanit(
            textStyle: Theme.of(context).textTheme.titleLarge,
            color: Colors.grey,
            fontSize: 20.0,
          ),
        ),
        const SizedBox(height: 10.0),
        SizedBox(
          height: 250.0,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              if (books.isNotEmpty) RecommandBook(book: books[0]),
              if (books.length > 1) RecommandBook(book: books[1]),
              if (books.length > 2) RecommandBook(book: books[2]),
              if (books.length > 3) RecommandBook(book: books[3]),
              if (books.length > 4) RecommandBook(book: books[4]),
              if (books.length > 5) RecommandBook(book: books[5]),
            ],
          ),
        ),
        const SizedBox(height: 20.0),
        Text(
          "See Also",
          style: GoogleFonts.kanit(
            textStyle: Theme.of(context).textTheme.titleLarge,
            color: Colors.grey,
            fontSize: 20.0,
          ),
        ),
      ],
    );
  }

  Widget _buildBooksList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: filteredBooks.length,
      itemBuilder: (context, index) {
        return Dismissible(
          key: Key(filteredBooks[index].toString()), // Ensure each Dismissible has a unique key
          direction: DismissDirection.endToStart,
          background: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20.0),
            color: Colors.red,
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          onDismissed: (direction) {
            _removeBook(index);
          },
          child: AllBook(book: filteredBooks[index]), // Use the correct child property
        );
      },
    );
  }
}