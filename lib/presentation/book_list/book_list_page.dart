import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coriander/presentation/add_book/add_book_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'book_list_model.dart';

class BookListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BookListModel>(
      create: (_) => BookListModel()..fetchBooks(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('本一覧'),
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('books').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) return Text('Error: ${snapshot.error}');
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(child: Text('Loading...'));
                default:
                  return Consumer<BookListModel>(
                      builder: (context, model, child) {
                    final books = model.books;
                    final listTiles = books
                        .map(
                          (book) => ListTile(
                            title: Text(book.title!),
                            trailing: IconButton(
                              onPressed: () async {
                                // todo: 画面遷移
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddBookPage(
                                      book: book,
                                    ),
                                    fullscreenDialog: true,
                                  ),
                                );
                                model.fetchBooks();
                              },
                              icon: Icon(Icons.edit),
                            ),
                          ),
                        )
                        .toList();
                    return ListView(
                      children: listTiles,
                    );
                  });
              }
            }),
        floatingActionButton:
            Consumer<BookListModel>(builder: (context, model, child) {
          return FloatingActionButton(
            onPressed: () async {
              //todo
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddBookPage(),
                  fullscreenDialog: true,
                ),
              );
              model.fetchBooks();
            },
            child: Icon(Icons.add),
          );
        }),
      ),
    );
  }
}
