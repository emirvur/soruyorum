class Dtobildirimhaber {
  // int cevapid;

  int uid;
  String anauser;
  int digkulid;
  String digkul;
  String takma;
  int soruid;
  String soru;
  int cevapid;
  String cevap;

  Dtobildirimhaber(this.uid, this.anauser, this.digkulid, this.digkul,
      this.takma, this.soruid, this.soru, this.cevapid, this.cevap);

/*  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['uid'] = uid;
    map['digkulid'] = digkulid;
    map['takma'] = takma;
    map['soruid'] = soruid;
    map['cevapid'] = cevapid;

    return map;
  }*/

  Dtobildirimhaber.fromMap(Map<String, dynamic> map) {
    print("dtobild baslafı from map");
    this.uid = map['uid'];
    print(uid);

    this.digkulid = map['digkulid'] ?? -1;
    print(digkulid);
    this.takma = map['takma'] ?? "-1";
    print(takma);
    this.soruid = map['soruid'] ?? -1;
    print(soruid);
    this.cevapid = map['cevapid'] ?? -1;
    print(cevapid);
    this.anauser = map['anauser'] ?? "-1";
    print(anauser);
    this.digkul = map['digkul'] ?? "-1";
    print(digkul);
    this.soru = map['soru'] ?? "-1";
    print(soru);
    this.cevap = map['cevap'] ?? "-1";
    print(cevap);
  }
}
