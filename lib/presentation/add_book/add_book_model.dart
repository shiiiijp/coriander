import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coriander/domain/book.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AddBookModel extends ChangeNotifier {
  String bookTitle = '';
  File? imageFile;
  bool isLoading = false;

  startLoading() {
    isLoading = true;
    notifyListeners();
  }

  endLoading() {
    isLoading = false;
    notifyListeners();
  }

  Future showImagePicker() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
    }
    notifyListeners();
  }

  Future addBookToFirebase() async {
    if (bookTitle.isEmpty) {
      throw ('タイトルを入力してください');
    }

    final imageURL = await _uploadImage();

    FirebaseFirestore.instance.collection('books').add({
      'title': bookTitle,
      'imageURL': imageURL,
      'createdAt': Timestamp.now(),
    });
  }

  Future updateBook(Book book) async {
    final imageURL = await _uploadImage();

    final document =
        FirebaseFirestore.instance.collection('books').doc(book.documentID);
    document.update({
      'title': bookTitle,
      'imageURL': imageURL,
      'updateAt': Timestamp.now(),
    });
  }

  Future<String?> _uploadImage() async {
    final storage = FirebaseStorage.instance;
    try {
      TaskSnapshot snapshot =
          await storage.ref().child("books/$bookTitle").putFile(imageFile!);
      final String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print(e);
    }
  }
}
