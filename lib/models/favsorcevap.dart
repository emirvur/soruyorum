class Favsorucevap {
  int cevapid;
  String tarih;
  int kullaniciid;
  int soruid;

  Favsorucevap(
    this.tarih,
    this.kullaniciid, {
    this.soruid,
    this.cevapid,
  });

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map['cevapid'] = cevapid;
    map['tarih'] = tarih;
    map['soruid'] = soruid;
    map['kullaniciid'] = kullaniciid;

    return map;
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
