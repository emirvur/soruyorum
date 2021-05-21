class Altkonu {
  int altkonuid;
  String altkonu;
  int konuid;
  int uyesayisi;
  String grupaciklama;
  String tarih;
  int kullaniciid;

  Altkonu(this.altkonuid, this.altkonu, this.konuid, this.uyesayisi,
      this.grupaciklama, this.tarih, this.kullaniciid);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['altkonular'] = altkonu;
    map['konuid'] = konuid;
    map['uyesayisi'] = uyesayisi;
    map['grupaciklama'] = grupaciklama;
    map['tarih'] = tarih;
    map['kullaniciid'] = kullaniciid;

    return map;
  }

  Altkonu.fromMap(Map<String, dynamic> map) {
    this.altkonuid = map['altkonuid'];
    this.altkonu = map['altkonular'];
    this.konuid = map['konuid'];
    this.uyesayisi = map['uyesayisi'];
    this.grupaciklama = map['grupaciklama'];
    this.tarih = map['tarih'];
    this.kullaniciid = map['kullaniciid'];
  }
}
