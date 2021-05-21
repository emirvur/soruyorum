import 'package:intl/intl.dart';

class Favorilerim {
  int pk;
  int cevapid;
  String cevaplar;
  String sorular;
  String cevaplayan;
  String soran;
  int sorubegenisayisi;
  int cevapbegenisayisi;
  String tarih;
  String sorutarih;
  String cevaptarih;
  int soruid;
  int soranid;
  int cevaplayanid;
  int mavitik;

  Favorilerim(
      this.pk,
      this.cevapid,
      this.cevaplar,
      this.sorular,
      this.cevaplayan,
      this.soran,
      this.sorubegenisayisi,
      this.cevapbegenisayisi,
      this.tarih,
      this.sorutarih,
      this.cevaptarih,
      this.soruid,
      this.soranid,
      this.cevaplayanid,
      this.mavitik);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map['cevapid'] = cevapid;
    map['cevaplar'] = cevaplar;
    map['sorular'] = sorular;
    map['cevaplayan'] = cevaplayan;
    map['soran'] = soran;
    map['soruBegenisayisi'] = sorubegenisayisi;
    map['cevapBegenisayisi'] = cevapbegenisayisi;
    map['tarih'] = tarih;
    map['soruTarih'] = sorutarih;
    map['cevapTarih'] = cevaptarih;
    map['soruid'] = soruid;
    map['soranid'] = soranid;
    map['cevaplayanid'] = cevaplayanid;

    return map;
  }

  Favorilerim.fromMap(Map<String, dynamic> map) {
    this.pk = map['pk'];
    this.cevapid = map['cevapid'];
    this.cevaplar = map['cevaplar'];
    this.sorular = map['sorular'];
    this.cevaplayan = map['cevaplayan'];
    this.soran = map['soran'];
    this.sorubegenisayisi = map['soruBegenisayisi'];
    this.cevapbegenisayisi = map['cevapBegenisayisi'];
    this.tarih = map['tarih'];
    var saat = DateFormat.jm('tr_TR').format(DateTime.parse(tarih));
    var yil = DateFormat.yMMMEd('tr_TR').format(DateTime.parse(tarih));
    this.tarih = yil + "-" + saat;
    this.sorutarih = map['soruTarih'];
    print(sorutarih);
    this.cevaptarih = map['cevapTarih'];
    print(cevaptarih);
    this.soruid = map['soruid'];
    this.soranid = map['soranid'];
    this.cevaplayanid = map['cevaplayanid'];
    this.mavitik = map['mavitik'];
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
