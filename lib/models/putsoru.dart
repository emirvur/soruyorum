import 'package:intl/intl.dart';

class Putsoru {
  int soruid;
  String soru;
  int soranid;
  int begenisayisi;
  int kacvarcevap;
  String tarih;
  int altkonuid;
  //cevap sayisi
  int dislikesayisi;
  int yorumsayisi;

  Putsoru(
      this.soruid,
      this.soru,
      this.soranid,
      this.begenisayisi,
      this.kacvarcevap,
      this.tarih,
      this.altkonuid,
      this.dislikesayisi,
      this.yorumsayisi);

  Map<String, dynamic> puttoMap(int say) {
    var map = Map<String, dynamic>();
    map['soruid'] = soruid;
    map['sorular'] = soru;
    map['soranid'] = soranid;
    map['begenisayisi'] = say;
    // DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    //dateFormat.format(tarih);
    map['tarih'] = tarih;

    map['altkonuid'] = altkonuid;
    map['kacvarcevap'] = kacvarcevap;
    print("rrr");
    map['dislikesayisi'] = dislikesayisi;
    map['yorumsayisi'] = yorumsayisi;

    return map;
  }
}
