import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Otherprofprov with ChangeNotifier {
  int takipcisayi;
  bool istakip;

  void takipet() {
    print("otherprff yıklede");
    takipcisayi = takipcisayi + 1;
    istakip = true;
    notifyListeners();
  }

  void ekle(int x, bool y) {
    print("otherprff yıklede");
    takipcisayi = x;
    istakip = y;
    notifyListeners();
  }

  void takiptencik() {
    print("otherprff yıklede");
    takipcisayi = takipcisayi - 1;
    istakip = false;
    notifyListeners();
  }
}
