class Kullanici {
  int kullaniciid;
  int mavitik;
  String bio;
  int cevaplanansayi;
  int sorulansayi;
  int takipcisayisi;
  String resimurl;
  String tokenid;
  String email;
  String location;
  String ilgi;
  int takipsayi;
  int userseviye;
  String userad;

  Kullanici(
      //  this.kullaniciid,
      this.mavitik,
      this.bio,
      this.cevaplanansayi,
      this.sorulansayi,
      this.takipcisayisi,
      this.resimurl,
      this.tokenid,
      this.email,
      this.location,
      this.ilgi,
      this.takipsayi,
      this.userseviye,
      this.userad);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map['mavitik'] = 0;
    print("xx");
    map['bio'] = bio;
    map['cevaplanansayi'] = 0;
    map['sorulansayi'] = 0;
    map['takipcisayisi'] = 0;
    map['resimurl'] = "a";
    map['tokenid'] = "ccc";
    map['email'] = email;
    map['location'] = location ?? "d";
    map['ilgi'] = ilgi ?? "q";
    print("rrr");
    map['takipsayi'] = 0;
    map['userseviye'] = 0;
    map['userad'] = userad;

    return map;
  }

  Kullanici.fromMap(Map<String, dynamic> map) {
    // this.id = map['id'];
    this.kullaniciid = map['kullaniciid'];
    this.mavitik = map['mavitik']; //babad dı burası
    this.bio = map['bio'];
    this.cevaplanansayi = map['cevaplanansayi'];
    this.sorulansayi = map['sorulansayi']; //babad dı burası
    this.takipcisayisi = map['takipcisayisi'];
    this.resimurl = map['resimurl'];
    this.tokenid = map['tokenid'];
    this.email = map['email'];
    this.location = map['location'] ?? "a";
    this.ilgi = map['ilgi'] ?? "s";
    //this.flag = 0;
    this.takipsayi = map['takipsayi'];
    this.userseviye = map['userseviye'];
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
