class Dtokull {
  int kullaniciid;
  int mavitik;
  String userad;

  Dtokull(
      //  this.kullaniciid,
      this.mavitik,
      this.userad);

  Dtokull.fromMap(Map<String, dynamic> map) {
    // this.id = map['id'];
    this.kullaniciid = map['kullaniciid'];
    this.mavitik = map['mavitik']; //babad dı burası

    this.userad = map['userad'];
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
