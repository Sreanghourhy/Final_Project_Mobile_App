class BookData {
  String bookcover;
  String bookname;
  String author;
  String description;
  String read;
  double rating; // Ensure this matches the JSON type
  String link;

  BookData({
    required this.bookcover,
    required this.bookname,
    required this.author,
    required this.description,
    required this.read,
    required this.rating,
    required this.link,
  });

  // Convert BookData to a map for JSON encoding
  Map<String, dynamic> toJson() {
    return {
      'bookcover': bookcover,
      'bookname': bookname,
      'author': author,
      'description': description,
      'read': read,
      'rating': rating, // Ensure consistency in data type
      'link': link,
    };
  }

  // Convert a map (from JSON) to BookData
  factory BookData.fromJson(Map<String, dynamic> json) {
    return BookData(
      bookcover: json['bookcover'] ?? '',
      bookname: json['bookname'] ?? '',
      author: json['author'] ?? '',
      description: json['description'] ?? '',
      read: json['read'] ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0, // Handle double conversion
      link: json['link'] ?? '',
    );
  }
}