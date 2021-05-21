class Dtoaltkonu {
  int altkonuid;
  String altkonu;
  int konuid;
  String konular;
  int uyesayisi;
  String grupaciklama;
  String tarih;
  int kullaniciid;

  Dtoaltkonu(this.altkonuid, this.altkonu, this.konuid);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['altkonular'] = altkonu;
    map['konuid'] = konuid;
    map['konular'] = konular;
    map['uyesayisi'] = uyesayisi;
    map['grupaciklama'] = grupaciklama;
    map['tarih'] = tarih;
    map['kullaniciid'] = kullaniciid;

    return map;
  }

  Dtoaltkonu.fromMap(Map<String, dynamic> map) {
    this.altkonuid = map['altkonuid'];
    this.altkonu = map['altkonular'];
    this.konuid = map['konuid'];
    this.konular = map['konular'] ?? "hata";
    this.uyesayisi = map['uyesayisi'];
    this.grupaciklama = map['grupaciklama'];
    this.tarih = map['tarih'];
    this.kullaniciid = map['kullaniciid'];
  }
}
