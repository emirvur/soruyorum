class Konu {
  int konuid;
  String konular;
  String renk;

  Konu(this.konuid, this.konular);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['konular'] = konular;
    map['konuid'] = konuid;
    map['renk'] = renk;

    return map;
  }

  Konu.fromMap(Map<String, dynamic> map) {
    this.konular = map['konular'];
    this.konuid = map['konuid'];
    this.renk = map['renk'];
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
