import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart'; // Add image_picker package
import 'dart:io';

import '../models/bookjompa.dart'; // For handling file system
import '../shared/button.dart';
import '../shared/styled_text.dart';

class CreateBookScreen extends StatefulWidget {
  final Function(BookData) onSave;
  final BookData? bookToEdit; // Accept an optional book to edit

  // Constructor to either create or edit a book
  CreateBookScreen({super.key, required this.onSave, this.bookToEdit});

  @override
  _CreateBookScreenState createState() => _CreateBookScreenState();
}

class _CreateBookScreenState extends State<CreateBookScreen> {
  final TextEditingController _bookcoverController = TextEditingController();
  final TextEditingController _booknameController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _readController = TextEditingController();
  final TextEditingController _ratingController = TextEditingController();
  final TextEditingController _linkController = TextEditingController();

  File? _image; // Make the image nullable by using File?
  final ImagePicker _picker = ImagePicker();

  // Flag to check whether we're editing a book or adding a new one
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();

    // If a book is passed for editing, populate the fields with the book details
    if (widget.bookToEdit != null) {
      _isEditing = true;
      _bookcoverController.text = widget.bookToEdit!.bookcover;
      _booknameController.text = widget.bookToEdit!.bookname;
      _authorController.text = widget.bookToEdit!.author;
      _descriptionController.text = widget.bookToEdit!.description;
      _readController.text = widget.bookToEdit!.read;
      _ratingController.text = widget.bookToEdit!.rating.toString();
      _linkController.text = widget.bookToEdit!.link;
    }
  }

  // Function to pick an image from the gallery or camera
  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _saveBook() {
    if (_booknameController.text.isEmpty ||
        _authorController.text.isEmpty ||        _ratingController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all required fields.'),
        ),
      );
      return;
    }

    final newBook = BookData(
      bookcover: _bookcoverController.text,
      bookname: _booknameController.text,
      author: _authorController.text,
      description: _descriptionController.text,
      read: _readController.text,
      rating: double.parse(_ratingController.text),
      link: _linkController.text, // Handle the link input
    );

    // If editing, call the onSave with the updated book
    widget.onSave(newBook); // Save the new or edited book using the callback
    Navigator.pop(context); // Go back to the previous screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isEditing ? 'Edit Book' : 'Add Book',
          style: GoogleFonts.kanit(
            textStyle: Theme.of(context).textTheme.titleMedium,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Book Details',
              style: GoogleFonts.kanit(
                textStyle: Theme.of(context).textTheme.headlineSmall,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            _buildTextField(
              controller: _bookcoverController,
              label: 'Book Cover URL',
              icon: Icons.link,
            ),
            const SizedBox(height: 10),
            // Add an image upload button
            // ElevatedButton(
            //   onPressed: _pickImage,
            //   child: Text('Upload Book Cover Image'),
            // ),
            if (_image != null) ...[
              Image.file(_image!, width: 100, height: 100), // Display the selected image
            ],
            _buildTextField(
              controller: _booknameController,
              label: 'Book Name',
              icon: Icons.book,
            ),
            _buildTextField(
              controller: _authorController,
              label: 'Author',
              icon: Icons.person,
            ),
            _buildTextField(
              controller: _descriptionController,
              label: 'Description',
              icon: Icons.description,
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            Text(
              'Additional Information',
              style: GoogleFonts.kanit(
                textStyle: Theme.of(context).textTheme.headlineSmall,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            _buildTextField(
              controller: _readController,
              label: 'Read Status',
              icon: Icons.check_circle,
            ),
            _buildTextField(
              controller: _ratingController,
              label: 'Rating',
              icon: Icons.star,
              keyboardType: TextInputType.number,
            ),
            // _buildTextField(
            //   controller: _linkController,
            //   label: 'Book Link (Optional)',
            //   icon: Icons.link,
            // ),
            const SizedBox(height: 30),
            Center(
              child: StyledButton(
                onPressed: _saveBook,
                child: const StyledHeading('Save Book'),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black,
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        style: GoogleFonts.kanit(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: GoogleFonts.kanit(color: Colors.white),
          prefixIcon: Icon(icon, color: Colors.white),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }
}