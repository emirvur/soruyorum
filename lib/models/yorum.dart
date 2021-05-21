import 'package:intl/intl.dart';

class Yorum {
  int yorumid;
  String yorum;
  int soruid;

  int cevapid;
  String tarih;
  int userid;

  Yorum(this.yorumid, this.yorum, this.soruid, this.cevapid, this.tarih,
      this.userid);

  Map<String, dynamic> tosoruMap() {
    var map = Map<String, dynamic>();
    map['yorum1'] = yorum;
    map['soruid'] = soruid;
    map['cevapid'] = null;
    map['tarih'] = tarih;
    map['userid'] = userid;

    return map;
  }

  Map<String, dynamic> tocevapMap() {
    var map = Map<String, dynamic>();
    map['yorum1'] = yorum;
    map['soruid'] = null;
    map['cevapid'] = cevapid;
    map['tarih'] = tarih;
    map['userid'] = userid;

    return map;
  }

  Yorum.fromMap(Map<String, dynamic> map) {
    // this.id = map['id'];

    this.yorumid = map['yorumid'];
    this.yorum = map['yorum1'];
    print(yorum.toString());
    this.soruid = map['soruid'] ?? -1;
    this.tarih = map['tarih'];
    var saat = DateFormat.jm('tr_TR').format(DateTime.parse(tarih));
    var yil = DateFormat.yMMMEd('tr_TR').format(DateTime.parse(tarih));
    this.tarih = yil + "-" + saat;
    print(tarih.toString());
    this.cevapid = map['cevapid'] ?? -1;
    this.userid = map['userid'];
  }
}
