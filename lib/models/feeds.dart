import 'package:intl/intl.dart';

class Feeds {
  int pk;
  int kullaniciid;
  String kullaniciad;
  String takma;
  String soru;
  String cevap;
  String tarih;
  int soruid;
  int cevapid;

  Feeds(this.pk, this.kullaniciid, this.kullaniciad, this.takma, this.soru,
      this.cevap, this.tarih, this.soruid, this.cevapid);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['kullaniciid'] = kullaniciid;
    map['kullaniciad'] = kullaniciad;
    map['takma'] = takma;
    map['soru'] = soru;
    map['cevap'] = cevap;
    map['tarih'] = tarih;
    map['soruid'] = soruid;
    map['cevapid'] = cevapid;

    return map;
  }

  Feeds.fromMap(Map<String, dynamic> map) {
    this.pk = map['pk'];
    this.kullaniciid = map['kullaniciid'];
    this.kullaniciad = map['kullaniciad'];
    this.takma = map['takma'];
    this.soru = map['soru'];
    this.cevap = map['cevap'];
    this.tarih = map['tarih'];

    this.soruid = map['soruid'];
    this.cevapid = map['cevapid'];
  }

  /* Kullanici.fromMap2(Map<String, dynamic> map) {
    print("qqq");
    this.barkodno = map['barkodno'];
    print("1111");
    //  print(barkodno.toString());
    this.adsoyad = map['adsoyad'];
    this.babaad = map['babaad'];
    this.id = map['id'];
    print(id.toString());

    this.sirano = map['sirano'];
    print(sirano.toString());
    this.sutkodu = map['sutkodu'];
  }*/

  /*@override
  String toString() {
    return 'Kategori{kategoriID: $kategoriID, kategoriBaslik: $kategoriBaslik}';
  }
  */
}
