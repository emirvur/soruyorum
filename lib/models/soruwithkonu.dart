import 'package:intl/intl.dart';

class Soruwithkonu {
  int soruid;
  String sorular;
  int soranid;
  int mavitik;
  int cevapsayisi;
  int begenisayisi;
  int dislikesayisi;
  int yorumsayisi;
  String tarih;
  String altkonusu;
  String soranad;
  int altkonuid;

  Soruwithkonu(
      this.soruid,
      this.sorular,
      this.mavitik,
      this.cevapsayisi,
      this.soranid,
      this.begenisayisi,
      this.dislikesayisi,
      this.yorumsayisi,
      this.tarih,
      this.altkonusu,
      this.soranad,
      this.altkonuid);

  Soruwithkonu.fromMap(Map<String, dynamic> map) {
    // this.id = map['id'];
    print("soruwith fromda");
    this.soruid = map['soruid'];
    this.sorular = map['sorular'];
    this.mavitik = map['mavitik'];
    this.cevapsayisi = map['cevapsayisi'];
    //  print(sorular.toString());
    this.soranid = map['soranid'];
    //  print(soranid.toString());
    this.begenisayisi = map['begenisayisi'];
    this.dislikesayisi = map['dislikesayisi'];
    this.yorumsayisi = map['yorumsayisi'];
    //  print(begenisayisi.toString());
    this.tarih = map['tarih'];
    //  var saat = DateFormat.jm('tr_TR').format(DateTime.parse(tarih));
    //var yil = DateFormat.yMMMEd('tr_TR').format(DateTime.parse(tarih));
    //this.tarih = yil + "-" + saat;
    //  print(tarih.toString());
    this.altkonusu = map['altkonusu'];
    this.soranad = map['soranad'];
    this.altkonuid = map['altkonuid'];
    //  print(altkonusu.toString());
  }
}
