import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coriander/domain/book.dart';
import 'package:flutter/material.dart';

class AddBookModel extends ChangeNotifier {
  String bookTitle = '';

  Future addBookToFirebase() async {
    if (bookTitle.isEmpty) {
      throw ('タイトルを入力してください');
    }

    FirebaseFirestore.instance.collection('books').add({
      'title': bookTitle,
      'createdAt': Timestamp.now(),
    });
  }

  Future updateBook(Book book) async {
    final document =
        FirebaseFirestore.instance.collection('books').doc(book.documentID);
    document.update({
      'title': bookTitle,
      'updateAt': Timestamp.now(),
    });
  }
}
