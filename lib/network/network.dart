import 'package:http/http.dart' as http;
import 'package:reader_tracker/models/book.dart';
import 'dart:convert';

class Network{
  static const String _baseUrl = "https://www.googleapis.com/books/v1/volumes";

  Future<List<Book>> searchBooks(String query) async{
    var url = Uri.parse('$_baseUrl?q=$query');
    var res = await http.get(url);

    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      if (data['items'] != null && data['items'] is List){
        List<Book> books = (data['items'] as List<dynamic>)
          .map((book) => Book.fromJson(book as Map<String, dynamic>))
          .toList();
        return books;
      }
      else {
        return [];
      }
    }
    else {
      throw Exception('Failed to load books');
    }
  }
}