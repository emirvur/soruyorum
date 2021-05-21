import 'package:easy_localization/easy_localization.dart';

class Cevapwithkull {
  int cevapid;
  String cevaplar;
  int cevaplayanid;
  String cevaplayan;
  int mavitik;
  int dislikesayisi;
  int begenisayisi;
  int yorumsayisi;
  String tarih;
  int soruid;
  String soru;

  Cevapwithkull(
      this.cevapid,
      this.cevaplar,
      this.cevaplayanid,
      this.mavitik,
      this.dislikesayisi,
      this.cevaplayan,
      this.begenisayisi,
      this.yorumsayisi,
      this.tarih,
      this.soruid,
      this.soru);

  Cevapwithkull.fromMap(Map<String, dynamic> map) {
    // this.id = map['id'];
    print("cevapwith fomrda");
    this.cevapid = map['cevapid'];
    print(cevapid.toString());
    this.cevaplar = map['cevaplar'];
    print(cevaplar.toString());
    this.cevaplayanid = map['cevaplayanid'];
    this.mavitik = map['mavitik'];
    print(mavitik.toString());
    this.dislikesayisi = map['dislikesayisi'];
    print(dislikesayisi.toString());
    this.cevaplayan = map['cevaplayan'];
    print(cevaplayan.toString());
    this.begenisayisi = map['begenisayisi'];
    print(begenisayisi.toString());
    this.yorumsayisi = map['yorumsayisi'];
    this.tarih = map['tarih'];
    //var saat = DateFormat.jm('tr_TR').format(DateTime.parse(tarih));
    //var yil = DateFormat.yMMMEd('tr_TR').format(DateTime.parse(tarih));
    //  this.tarih = yil + "-" + saat;
    print(tarih.toString());
    this.soruid = map['soruid'];
    print(soruid.toString());
    this.soru = map['soru'];
    print(soru.toString());
  }

  Cevapwithkull.fromSadececevapMap(Map<String, dynamic> map) {
    // this.id = map['id'];
    print("cevapwith fomrda");
    this.cevapid = map['cevapid'];
    print(cevapid.toString());
    this.cevaplar = map['cevaplar'];
    print(cevaplar.toString());
    this.cevaplayanid = map['cevaplayanid'];
    this.mavitik = map['mavitik'];
    print(mavitik.toString());
    this.dislikesayisi = map['dislikesayisi'];
    this.yorumsayisi = map['yorumsayisi'];
    print(dislikesayisi.toString());
    this.cevaplayan = map['cevaplayan'];
    print(cevaplayan.toString());
    this.begenisayisi = map['begenisayisi'];
    print(begenisayisi.toString());

    this.tarih = map['tarih'];

    print(tarih.toString());
    this.soruid = map['soruid'];
    print(soruid.toString());
    this.soru = "w";
  }
}
