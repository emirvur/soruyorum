class Putkullanici {
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

  Putkullanici(
      this.kullaniciid,
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
    map['kullaniciid'] = kullaniciid;
    map['mavitik'] = mavitik;
    print("xx");
    map['bio'] = bio;
    map['cevaplanansayi'] = cevaplanansayi;
    map['sorulansayi'] = sorulansayi;
    map['takipcisayisi'] = takipcisayisi;
    map['resimurl'] = resimurl;
    map['tokenid'] = tokenid;
    map['email'] = email;
    map['location'] = location ?? "d";
    map['ilgi'] = ilgi ?? "q";
    print("rrr");
    map['takipsayi'] = takipsayi;
    map['userseviye'] = userseviye;
    map['userad'] = userad;

    return map;
  }

  Putkullanici.fromMap(Map<String, dynamic> map) {
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
}
