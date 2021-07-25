import 'package:flutter/material.dart';

class MainModel extends ChangeNotifier {
  String sampleText = 'ホニャララ';

  void changeSampleText() {
    sampleText = 'また変わったよ';
    notifyListeners();
  }
}