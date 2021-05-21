import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:soryor/models/kullanici.dart';

class KullaniciProvider with ChangeNotifier {
  Kullanici kullanici;
  int y = 0;

  void kullaniciyukle(Kullanici kull) {
    print("kullanici yıklede");
    kullanici = kull;
    notifyListeners();
  }

  void kullanicidegistir(String ad) {
    print("kullanici degistirde");
    kullanici.userad = ad;
    notifyListeners();
  }

  void kullanicibiodegistir(String bio) {
    print("bioo degistirde");
    kullanici.bio = bio;
    notifyListeners();
  }

  void kullanicifotodegistir(String bio, String fot) {
    print("foro degistirde");
    kullanici.bio = bio;
    kullanici.resimurl = fot;
    notifyListeners();
  }
}
