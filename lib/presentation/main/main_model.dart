import 'package:flutter/material.dart';

class MainModel extends ChangeNotifier {
  String sampleText = '図書館';

  void changeSampleText() {
    sampleText = 'また変わったよ';
    notifyListeners();
  }
}
