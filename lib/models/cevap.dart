import 'package:easy_localization/easy_localization.dart';

class Cevap {
  // int cevapid;
  String cevap;
  int cevaplayanid;
  int begenisayisi;
  int dislikesayisi;
  String tarih;
  int soruid;
  int emojisayisi;
  int yorumsayisi;
  Cevap(this.cevap, this.cevaplayanid, this.begenisayisi, this.dislikesayisi,
      this.tarih, this.soruid, this.emojisayisi, this.yorumsayisi);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['cevaplar'] = cevap;
    map['cevaplayanid'] = cevaplayanid;
    map['begenisayisi'] = 0;
    map['tarih'] = tarih;
    map['soruid'] = soruid;
    map['dislikesayisi'] = 0;
    map['emojisayisi'] = 0;
    map['yorumsayisi'] = 0;

    return map;
  }

  Cevap.fromMap(Map<String, dynamic> map) {
    // this.id = map['id'];
    print("ww");
    //this.cevapid = map['cevapid'];
    //  print(cevapid.toString());
    this.cevap = map['cevaplar'];
    this.cevaplayanid = map['cevaplayanid'];
    this.begenisayisi = map['begenisayisi'];
    this.tarih = map['tarih'];
    var saat = DateFormat.jm('tr_TR').format(DateTime.parse(tarih));
    var yil = DateFormat.yMMMEd('tr_TR').format(DateTime.parse(tarih));
    this.tarih = yil + "-" + saat;
    this.soruid = map['soruid'];
    this.dislikesayisi = map['dislikesayisi'];
    this.emojisayisi = map['emojisayisi'];
    this.yorumsayisi = map['yorumsayisi'];
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
