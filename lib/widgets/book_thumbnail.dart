import 'package:flutter/material.dart';
import 'package:reader_tracker/models/book.dart';

class BookThumbnail extends StatelessWidget {
  const BookThumbnail({
    super.key,
    required this.book,
  });

  final Book book;

  @override
  Widget build(BuildContext context) {
    return book.imageLinks.isNotEmpty ? Padding(
      padding: const EdgeInsets.all(8.0),
      child: Image.network(
        book.imageLinks['thumbnail'] ?? '',
        fit: BoxFit.cover,
      ),
      
    ) : Text('');
  }
}
