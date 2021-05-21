class Takip {
  int pk;
  int kullaniciid;
  int takipettigiid;
  int altkonuid;
  String takipad;
  String altkonu;
  String kullaniciad;
  String takipettigiad;

  Takip(this.pk, this.kullaniciid, this.takipettigiid, this.altkonuid,
      this.takipad, this.altkonu, this.kullaniciad, this.takipettigiad);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['kullaniciid'] = kullaniciid;
    map['takipettigiid'] = takipettigiid;
    map['altkonuid'] = altkonuid;
    map['takipad'] = takipad;
    map['altkonu'] = altkonu;
    map['kullaniciad'] = kullaniciad;
    map['takipettigiad'] = takipettigiad;

    return map;
  }

  Takip.fromMap(Map<String, dynamic> map) {
    this.pk = map['pk'];
    this.kullaniciid = map['kullaniciid'];
    this.takipettigiid = map['takipettigiid'];
    this.altkonuid = map['altkonuid'];
    this.takipad = map['takipad'];
    this.altkonu = map['altkonu'];
    this.kullaniciad = map['kullaniciad'];
    this.takipettigiad = map['takipettigiad'];
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
