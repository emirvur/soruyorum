class Takipettiklerim {
  int kullaniciid;
  int takipettigiid;
  int altkonuid;

  Takipettiklerim(this.kullaniciid, this.takipettigiid, {this.altkonuid});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['kullaniciid'] = kullaniciid;
    print(kullaniciid.toString());
    map['takipettigiid'] = takipettigiid;
    map['altkonuid'] = altkonuid;

    return map;
  }

  Takipettiklerim.fromMap(Map<String, dynamic> map) {
    // this.id = map['id'];
    this.kullaniciid = map['kullaniciid'];
    this.takipettigiid = map['takipettigiid'] ?? -1;
    this.altkonuid = map['altkonuid'] ?? -1;
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
