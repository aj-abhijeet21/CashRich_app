import 'package:flutter/cupertino.dart';

class PercentProvider extends ChangeNotifier {
  int shareValue = 50;
  int fixedValue = 50;

  void setEquity(int equity) {
    shareValue = equity;
    fixedValue = 100 - shareValue;
    notifyListeners();
  }
}
