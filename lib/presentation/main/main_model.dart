import 'package:flutter/material.dart';

class MainModel extends ChangeNotifier {
  String sampleText = '本カタログ';

  void changeSampleText() {
    sampleText = '本カタログ';
    notifyListeners();
  }
}
