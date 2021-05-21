import 'package:intl/intl.dart';

class Dtoyorum {
  int yorumid;
  String yorum;
  int soruid;

  int cevapid;
  String tarih;
  int userid;
  String ad;
  int mavitik;

  Dtoyorum(this.yorumid, this.yorum, this.soruid, this.tarih, this.userid,
      this.ad, this.mavitik);

  Dtoyorum.fromMap(Map<String, dynamic> map) {
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
    this.ad = map['ad'];
    this.mavitik = map['mavitik'];
  }
}
