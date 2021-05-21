class Bildirimhaber {
  // int cevapid;

  int uid;
  int digkulid;
  String takma;
  int soruid;
  int cevapid;

  Bildirimhaber(this.uid, this.digkulid, this.takma, this.soruid, this.cevapid);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['uid'] = uid;
    map['digkulid'] = digkulid;
    map['takma'] = takma;
    map['soruid'] = soruid;
    map['cevapid'] = cevapid;

    return map;
  }

  Bildirimhaber.fromMap(Map<String, dynamic> map) {
    this.uid = map['uid'];
    this.digkulid = map['digkulid'] ?? -1;
    this.takma = map['takma'] ?? "-1";
    this.soruid = map['soruid'] ?? -1;
    this.cevapid = map['cevapid'] ?? -1;
  }
}
