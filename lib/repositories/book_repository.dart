import 'dart:convert';

import 'package:book_tracking/models/books.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const apiUrl = 'https://fakerapi.it/api/v1/books?_quantity=100';

class BookRepository {
  final http.Client httpClient;

  BookRepository({@required this.httpClient});

  Future<List<Book>> getBooks() async {
    final response = await httpClient.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Books.fromJson(data).data;
    } else {
      throw Exception("Something went wrong!");
    }
  }

  List<Book> searchBook(List<Book> list, String query) {
    final books = list.where((book) {
      final lowerTitle = book.title.toLowerCase();
      final lowerQuery = query.toLowerCase();

      return lowerTitle.contains(lowerQuery);
    }).toList();

    return books;
  }
}
