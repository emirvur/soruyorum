import 'package:intl/intl.dart';

class Soru {
  String soru;
  int soranid;
  int begenisayisi;
  int kacvarcevap;
  String tarih;
  int altkonuid;
  //cevap sayisi
  int dislikesayisi;
  int yorumsayisi;

  Soru(this.soru, this.soranid, this.begenisayisi, this.kacvarcevap, this.tarih,
      this.altkonuid, this.dislikesayisi, this.yorumsayisi);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['sorular'] = soru;
    map['soranid'] = soranid;
    map['begenisayisi'] = 0;
    map['kacvarcevap'] = 0;
    map['tarih'] = tarih;
    map['altkonuid'] = altkonuid;
    print("rrr");
    map['dislikesayisi'] = 0;
    map['yorumsayisi'] = 0;

    return map;
  }

  Map<String, dynamic> puttoMap(int id, int say) {
    var map = Map<String, dynamic>();
    map['soruid'] = id;
    map['sorular'] = soru;
    map['soranid'] = soranid;
    map['begenisayisi'] = say;
    map['tarih'] = tarih;

    map['altkonuid'] = altkonuid;
    map['kacvarcevap'] = kacvarcevap;
    print("rrr");
    map['dislikesayisi'] = dislikesayisi;
    map['yorumsayisi'] = yorumsayisi;

    return map;
  }

  Soru.fromMap(Map<String, dynamic> map) {
    // this.id = map['id'];
    this.soru = map['sorular'];
    print(soru.toString());
    this.soranid = map['soranid'];
    print(soranid.toString());
    this.begenisayisi = map['begenisayisi'];
    print(begenisayisi.toString());
    this.kacvarcevap = map['kacvarcevap'];
    print(kacvarcevap.toString());
    this.tarih = map['tarih'];
    //  var saat = DateFormat.jm('tr_TR').format(DateTime.parse(tarih));
    //var yil = DateFormat.yMMMEd('tr_TR').format(DateTime.parse(tarih));
    //this.tarih = yil + "-" + saat;
    print(toString());
    this.altkonuid = map['altkonuid'];
    print(altkonuid.toString());
    this.dislikesayisi = map['dislikesayisi'];
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
