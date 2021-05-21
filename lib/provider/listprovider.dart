import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:soryor/models/altkonu.dart';
import 'package:soryor/models/kullanici.dart';
import 'package:soryor/services/apiservices.dart';
import 'package:soryor/utils/constans.dart';

class Listprovider with ChangeNotifier {
  Kullanici kullanici;
  int y = 0;

  Future<List<Altkonu>> arakana(String x) async {
    print("kontrolll");

    List<Altkonu> li = await APIServices.araaltonual(x);

    print("kontrol222");
    print(li.toString());
    // l = li;
    print("soonnn");

    return li;
  }

  void ara(String ara) async {
    print("araaa yıklede");
    y = 1;
    pro = await arakana(ara);
    notifyListeners();
  }
}
