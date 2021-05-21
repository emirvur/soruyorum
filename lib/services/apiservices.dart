import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:soryor/models/altkonu.dart';
import 'package:soryor/models/altkonudto.dart';
import 'package:soryor/models/cevap.dart';
import 'package:soryor/models/cevapwithkull.dart';
import 'package:soryor/models/dtokull.dart';
import 'package:soryor/models/dtobildirim.dart';
import 'package:soryor/models/favorilerim.dart';
import 'package:soryor/models/favsorcevap.dart';
import 'package:soryor/models/feeds.dart';
import 'package:soryor/models/konu.dart';
import 'package:soryor/models/kullanici.dart';
import 'package:soryor/models/putkullanici.dart';
import 'package:soryor/models/putsoru.dart';
import 'package:soryor/models/soru.dart';
import 'package:soryor/models/soruwithkonu.dart';
import 'package:soryor/models/takipettigim.dart';
import 'package:soryor/models/takipettiklerim.dart';
import 'package:soryor/models/yorum.dart';
import 'package:soryor/models/yorumdto.dart';

class APIServices {
/* 
todo 1. kullanıcı eklede 500 status codeu duzelt
*/

  static Map<String, String> header = {
    'Content-type': 'application/json',
    'Accept': 'application/json'
  };

  static Future<bool> kullaniciekle(Kullanici kullanici) async {
    print("girdiii kullanici ekleye");
    var maps = json.encode(kullanici.toMap());
    print(maps.toString());

    var res = await http.post(
        "https://soryorapi.azurewebsites.net/api/kullanicis",
        headers: header,
        body: maps);
    print(res.statusCode.toString());
    debugPrint("resten sonra");
    /*if (res.statusCode != 200 ||
        res.statusCode != 201 ||
        res.statusCode != 500) {
      throw Exception;
    }*/
    return Future.value(
        res.statusCode == 200 || res.statusCode != 201 ? true : false);
  }

  static Future sorual() async {
    print("soru al baslıyr");

    http.Response res =
        await http.get("https://soryorapi.azurewebsites.net/api/sorus");
    if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("ikinci sama");
    print("$re");
    List<Soruwithkonu> list = [];
    for (var l in re) {
      list.add(Soruwithkonu.fromMap(l));
    }
    print("sorual bitii");
    return list;

    // return List<Kullaniciliste>.from(re.map((x) => Kullaniciliste.fromMap(x)));
  }

  static Future tarihlisorual() async {
    print("tarihlisoru al baslıyr");

    http.Response res =
        await http.get("https://soryorapi.azurewebsites.net/api/sorus/s");
    if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("ikinci sama");
    print("$re");
    List<Soruwithkonu> list = [];
    for (var l in re) {
      list.add(Soruwithkonu.fromMap(l));
    }
    print("sorual bitii");
    return list;

    // return List<Kullaniciliste>.from(re.map((x) => Kullaniciliste.fromMap(x)));
  }

  static Future araaltonual(String ara) async {
    print("atraaltkonu al baslıyr");

    http.Response res = await http
        .get("https://soryorapi.azurewebsites.net/api/altkonus/k/$ara");
    if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("ikinci sama");
    print("$re");
    List<Altkonu> list = [];
    for (var l in re) {
      list.add(Altkonu.fromMap(l));
    }
    print("araaltkonuall bitii");
    return list;

    // return List<Kullaniciliste>.from(re.map((x) => Kullaniciliste.fromMap(x)));
  }

  static Future arakulla(String ara) async {
    print("atraaltkonu al baslıyr");

    http.Response res = await http
        .get("https://soryorapi.azurewebsites.net/api/kullanicis/k/$ara");
    if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("ikinci sama");
    print("$re");
    List<Kullanici> list = [];
    for (var l in re) {
      list.add(Kullanici.fromMap(l));
    }
    print("araaltkonuall bitii");
    return list;

    // return List<Kullaniciliste>.from(re.map((x) => Kullaniciliste.fromMap(x)));
  }

  static Future altonual() async {
    print("altkonu al baslıyr");

    http.Response res =
        await http.get("https://soryorapi.azurewebsites.net/api/altkonus");
    if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("ikinci sama");
    print("$re");
    List<Dtoaltkonu> list = []; //altkonudtoo
    for (var l in re) {
      list.add(Dtoaltkonu.fromMap(l));
    }
    print("altkonuall bitii");
    return list;

    // return List<Kullaniciliste>.from(re.map((x) => Kullaniciliste.fromMap(x)));
  }

  static Future altkonuidlial(int id) async {
    print("altkonuidlialbaslıyr");

    http.Response res =
        await http.get("https://soryorapi.azurewebsites.net/api/altkonus/$id");
    if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    var re = json.decode(res.body);
    print("ikinci sama");
    print("$re");

    var list = Dtoaltkonu.fromMap(re);

    print("favsorce bitii");
    return list;

    // return List<Kullaniciliste>.from(re.map((x) => Kullaniciliste.fromMap(x)));
  }

  static Future bildirimal(int id) async {
    print("bildriimallda");

    http.Response res = await http
        .get("https://soryorapi.azurewebsites.net/api/bildirimhabers/$id");
    if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    var re = json.decode(res.body);
    print("ikinci sama");
    print("$re");

    List<Dtobildirimhaber> list = [];
    for (var l in re) {
      list.add(Dtobildirimhaber.fromMap(l));
    }

    print("bildridimal bitii");
    return list;

    // return List<Kullaniciliste>.from(re.map((x) => Kullaniciliste.fromMap(x)));
  }

  static Future favsorcev(int id) async {
    print("favsorcev al baslıyr");

    http.Response res = await http
        .get("https://soryorapi.azurewebsites.net/api/favsorucevaps/$id");
    if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("ikinci sama");
    print("$re");
    List<Favorilerim> list = [];
    for (var l in re) {
      list.add(Favorilerim.fromMap(l));
    }
    print("favsorce bitii");
    return list;

    // return List<Kullaniciliste>.from(re.map((x) => Kullaniciliste.fromMap(x)));
  }

  static Future takipcilistesi(int id) async {
    print("takip al baslıyr");

    http.Response res = await http
        .get("https://soryorapi.azurewebsites.net/api/takipettiklerims/o/$id");
    if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("ikinci sama");
    print("$re");
    List<Dtokull> list = [];
    for (var l in re) {
      list.add(Dtokull.fromMap(l));
    }
    print("takip bitii");
    return list;

    // return List<Kullaniciliste>.from(re.map((x) => Kullaniciliste.fromMap(x)));
  }

  static Future takip(int id) async {
    print("takip al baslıyr");

    http.Response res = await http
        .get("https://soryorapi.azurewebsites.net/api/takipettiklerims/$id");
    if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("ikinci sama");
    print("$re");
    List<Takip> list = [];
    for (var l in re) {
      list.add(Takip.fromMap(l));
    }
    print("takip bitii");
    return list;

    // return List<Kullaniciliste>.from(re.map((x) => Kullaniciliste.fromMap(x)));
  }

  static Future feed(int id) async {
    print("feed al baslıyr");

    http.Response res =
        await http.get("https://soryorapi.azurewebsites.net/api/feeds/$id");
    if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("ikinci sama");
    print("$re");
    List<Feeds> list = [];
    for (var l in re) {
      list.add(Feeds.fromMap(l));
    }
    print("feed bitii");
    return list;

    // return List<Kullaniciliste>.from(re.map((x) => Kullaniciliste.fromMap(x)));
  }

  static Future cevapalkul(int kul) async {
    print("cevap al baslıyr");
    print(kul);
    http.Response res =
        await http.get("https://soryorapi.azurewebsites.net/api/cevaps/k/$kul");
    if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("ikinci sama");
    print("$re");
    List<Cevapwithkull> list = [];
    for (var l in re) {
      list.add(Cevapwithkull.fromMap(l));
    }
    print("cevapall bitii");
    return list;

    // return List<Kullaniciliste>.from(re.map((x) => Kullaniciliste.fromMap(x)));
  }

  static Future sorununcevabial(int id) async {
    print("xxxxxxxxxxxxx");
    print("sorucevap al baslıyr");

    http.Response res =
        await http.get("https://soryorapi.azurewebsites.net/api/cevaps/s/$id");
    if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("ikinci sama");
    print("$re");
    print("dd");
    List<Cevapwithkull> list = [];
    for (var l in re) {
      list.add(Cevapwithkull.fromSadececevapMap(l));
    }
    print("cevapall bitii");
    return list;

    // return List<Kullaniciliste>.from(re.map((x) => Kullaniciliste.fromMap(x)));
  }

  static Future sorualkull(int kul) async {
    print("soru al baslıyr");

    http.Response res =
        await http.get("https://soryorapi.azurewebsites.net/api/sorus/k/$kul");
    if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("ikinci sama");
    print("$re");
    List<Soruwithkonu> list = [];
    for (var l in re) {
      list.add(Soruwithkonu.fromMap(l));
    }
    print("sorual bitii");
    return list;

    // return List<Kullaniciliste>.from(re.map((x) => Kullaniciliste.fromMap(x)));
  }

  static Future konulusorualkull(int konu) async {
    print("konulusuroru al baslıyr");

    http.Response res = await http
        .get("https://soryorapi.azurewebsites.net/api/sorus/ko/$konu");
    if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("ikinci sama");
    print("$re");
    List<Soruwithkonu> list = [];
    for (var l in re) {
      list.add(Soruwithkonu.fromMap(l));
    }
    print("konulusoror bitii");
    return list;
  }

  static Future topluluksoru(int id) async {
    print("topluluk soru baslıyr");

    http.Response res =
        await http.get("https://soryorapi.azurewebsites.net/api/sorus/t/$id");
    if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("ikinci sama");
    print("$re");
    List<Soruwithkonu> list = [];
    for (var l in re) {
      list.add(Soruwithkonu.fromMap(l));
    }
    print("topluluk bitii");
    return list;

    // return List<Kullaniciliste>.from(re.map((x) => Kullaniciliste.fromMap(x)));
  }

  static Future yorumsorual(int id) async {
    print("yroum soru baslıyr");

    http.Response res =
        await http.get("https://soryorapi.azurewebsites.net/api/yorums/$id");
    if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("ikinci sama");
    print("$re");
    List<Dtoyorum> list = [];
    for (var l in re) {
      list.add(Dtoyorum.fromMap(l));
    }
    print("topluluk bitii");
    return list;

    // return List<Kullaniciliste>.from(re.map((x) => Kullaniciliste.fromMap(x)));
  }

  static Future yorumcevappl(int id) async {
    print("yroum cevapp baslıyr");

    http.Response res =
        await http.get("https://soryorapi.azurewebsites.net/api/yorums/c/$id");
    if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("ikinci sama");
    print("$re");
    List<Dtoyorum> list = [];
    for (var l in re) {
      list.add(Dtoyorum.fromMap(l));
    }
    print("topluluk bitii");
    return list;

    // return List<Kullaniciliste>.from(re.map((x) => Kullaniciliste.fromMap(x)));
  }

  static Future poptopluluksoru(int id) async {
    print("tpopoopluluk soru baslıyr");

    http.Response res =
        await http.get("https://soryorapi.azurewebsites.net/api/sorus/pt/$id");
    if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("ikinci sama");
    print("$re");
    List<Soruwithkonu> list = [];
    for (var l in re) {
      list.add(Soruwithkonu.fromMap(l));
    }
    print("topluluk bitii");
    return list;
  }

  static Future uyetopluluk(int id) async {
    print("uyetoplul soru baslıyr");

    http.Response res = await http
        .get("https://soryorapi.azurewebsites.net/api/kullanicis/t/$id");
    if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("ikinci sama");
    print("$re");
    List<Dtokull> list = [];
    for (var l in re) {
      list.add(Dtokull.fromMap(l));
    }
    print("topluluk bitii");
    return list;

    // return List<Kullaniciliste>.from(re.map((x) => Kullaniciliste.fromMap(x)));
  }

  static Future kullanicivarmi(String id) async {
    print("kullanici var mı  baslıyr");

    http.Response res = await http
        .get("https://soryorapi.azurewebsites.net/api/kullanicis/v/$id");
    if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    var re = json.decode(res.body);
    print("ikinci sama");
    print("$re");
    return re;

    // return List<Kullaniciliste>.from(re.map((x) => Kullaniciliste.fromMap(x)));
  }

  static Future adtakipmi(int id, int ad) async {
    print("adtakip var mı  baslıyr");

    http.Response res = await http.get(
        "https://soryorapi.azurewebsites.net/api/takipettiklerims/$id/$ad");
    if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    var re = json.decode(res.body);
    print("ikinci sama");
    print("$re");
    return re;

    // return List<Kullaniciliste>.from(re.map((x) => Kullaniciliste.fromMap(x)));
  }

  static Future topluluktakipmi(int id, int ad) async {
    print("tıoplloktakip var mı  baslıyr");

    http.Response res = await http.get(
        "https://soryorapi.azurewebsites.net/api/takipettiklerims/t/$id/$ad");
    if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    var re = json.decode(res.body);
    print("ikinci sama");
    print("$re");
    return re;

    // return List<Kullaniciliste>.from(re.map((x) => Kullaniciliste.fromMap(x)));
  }

  static Future alkullanici(String email) async {
    print("al kullanici  baslıyr");

    http.Response res = await http
        .get("https://soryorapi.azurewebsites.net/api/kullanicis/$email");
    if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    var re = json.decode(res.body);
    print("ikinci sama");
    print("$re");
    Kullanici kullani = Kullanici.fromMap(re);
    return kullani;

    // return List<Kullaniciliste>.from(re.map((x) => Kullaniciliste.fromMap(x)));
  }

  static Future konual() async {
    print("konu al baslıyr");

    http.Response res =
        await http.get("https://soryorapi.azurewebsites.net/api/konus");
    if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("ikinci sama");
    print("$re");
    List<Konu> list = [];
    for (var l in re) {
      list.add(Konu.fromMap(l));
    }
    print("konua bitii");
    return list;

    // return List<Kullaniciliste>.from(re.map((x) => Kullaniciliste.fromMap(x)));
  }

  static Future konudanalt(int id) async {
    print("konudanatt al baslıyr");

    http.Response res = await http
        .get("https://soryorapi.azurewebsites.net/api/altkonus/pko/$id");
    if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("ikinci sama");
    print("$re");
    List<Dtoaltkonu> list = [];
    for (var l in re) {
      list.add(Dtoaltkonu.fromMap(l));
    }
    print("sorual bitii");
    return list;

    // return List<Kullaniciliste>.from(re.map((x) => Kullaniciliste.fromMap(x)));
  }

  static Future poptrendtoplsoru(int id) async {
    print("konudanatt al baslıyr");

    http.Response res =
        await http.get("https://soryorapi.azurewebsites.net/api/sorus/pko/$id");
    if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("ikinci sama");
    print("$re");
    List<Soruwithkonu> list = [];
    for (var l in re) {
      list.add(Soruwithkonu.fromMap(l));
    }
    print("sorual bitii");
    return list;

    // return List<Kullaniciliste>.from(re.map((x) => Kullaniciliste.fromMap(x)));
  }

  static Future<Kullanici> bakkullanici(int id) async {
    print("bak kullanici  baslıyr");

    http.Response res = await http
        .get("https://soryorapi.azurewebsites.net/api/kullanicis/a/$id");
    if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    var re = json.decode(res.body);
    print("ikinci sama");
    print("$re");
    Kullanici kullani = Kullanici.fromMap(re);
    return kullani;

    // return List<Kullaniciliste>.from(re.map((x) => Kullaniciliste.fromMap(x)));
  }

  static Future<Kullanici> testkulla() async {
    print("bak kullanici  baslıyr");
    /*HttpClient client = new HttpClient();
    var request =
      await client.getUrl(Uri.parse("10.0.3.2:44314/api/kullanicis"));
    print(request.toString());
    var response1 = request.close();*/
    bool trustSelfSigned = true;
    HttpClient httpClient = new HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => trustSelfSigned);
    IOClient ioClient = new IOClient(httpClient);
    http.Response res =
        await ioClient.get("https://10.0.2.2:44314/api/kullanicis");
    // http.Response res = await http.get("https://10.0.3.2:44314/api/kullanicis");
    if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    var re = json.decode(res.body);
    print("ikinci sama");
    print("$re");
    Kullanici kullani = Kullanici.fromMap(re);
    return kullani;

    // return List<Kullaniciliste>.from(re.map((x) => Kullaniciliste.fromMap(x)));
  }

  static Future<bool> gonderfav(Favsorucevap fav) async {
    print("yorumsor");
    var maps = json.encode(fav.toMap());
    print(maps.toString());
    var res = await http.post(
        "https://soryorapi.azurewebsites.net/api/favsorucevaps",
        headers: header,
        body: maps);
    print(res.statusCode.toString());
    if (res.statusCode != 200) {
      throw Exception;
    }
    return Future.value(res.statusCode == 200 ? true : false);
  }

  static Future<bool> eklekanal(Altkonu kanal) async {
    print("yorumsor");
    var maps = json.encode(kanal.toMap());
    print(maps.toString());
    var res = await http.post(
        "https://soryorapi.azurewebsites.net/api/altokonus",
        headers: header,
        body: maps);
    print(res.statusCode.toString());
    if (res.statusCode != 201) {
      throw Exception;
    }
    return Future.value(res.statusCode == 201 ? true : false);
  }

  static Future<bool> gonderyorumsoru(Yorum yoru) async {
    print("yorumsor");
    var maps = json.encode(yoru.tosoruMap());
    print(maps.toString());
    var res = await http.post("https://soryorapi.azurewebsites.net/api/yorums",
        headers: header, body: maps);
    print(res.statusCode.toString());
    if (res.statusCode != 200) {
      throw Exception;
    }
    return Future.value(res.statusCode == 200 ? true : false);
  }

  static Future<bool> gonderyorumcevap(Yorum yoru) async {
    print("yorumsor");
    var maps = json.encode(yoru.tocevapMap());
    print(maps.toString());
    var res = await http.post("https://soryorapi.azurewebsites.net/api/yorums",
        headers: header, body: maps);
    print(res.statusCode.toString());
    if (res.statusCode != 200) {
      throw Exception;
    }
    return Future.value(res.statusCode == 200 ? true : false);
  }

  static Future<bool> gondersoru(Soru soru) async {
    print("sorugonderde");
    var maps = json.encode(soru.toMap());
    print(maps.toString());
    var res = await http.post("https://soryorapi.azurewebsites.net/api/sorus",
        headers: header, body: maps);
    print(res.statusCode.toString());
    if (res.statusCode != 201) {
      throw Exception;
    }
    return Future.value(res.statusCode == 201 ? true : false);
  }

  static Future<bool> guncelleuser(int id, Putkullanici user) async {
    print("guncellede");
    var maps = json.encode(user.toMap());
    print(maps.toString());
    var res = await http.put(
        "https://soryorapi.azurewebsites.net/api/kullanicis/$id",
        headers: header,
        body: maps);
    print(res.statusCode.toString());
    if (res.statusCode != 204) {
      throw Exception;
    }
    return Future.value(res.statusCode == 204 ? true : false);
  }

  static Future<bool> guncellesorununcvpsayi(int id, Putsoru soru) async {
    print("guncellede");

    var res1 =
        await http.get("https://soryorapi.azurewebsites.net/api/sorus/$id");
    Soru re = json.decode(res1.body);
    int cvp = re.kacvarcevap;
    soru.kacvarcevap = cvp + 1;
    var maps = json.encode(soru.puttoMap(id));
    print(maps.toString());
    var res = await http.put(
        "https://soryorapi.azurewebsites.net/api/sorus/$id",
        headers: header,
        body: maps);
    print(res.statusCode.toString());
    if (res.statusCode != 204) {
      throw Exception;
    }
    return Future.value(res.statusCode == 204 ? true : false);
  }

  static Future<bool> guncellesoru(int id, Putsoru soru, int sayi) async {
    print("guncellede");
    var maps = json.encode(soru.puttoMap(sayi));
    print(maps.toString());
    var res = await http.put(
        "https://soryorapi.azurewebsites.net/api/sorus/$id",
        headers: header,
        body: maps);
    print(res.statusCode.toString());
    if (res.statusCode != 204) {
      throw Exception;
    }
    return Future.value(res.statusCode == 204 ? true : false);
  }

  static Future<bool> takipciekle(Takipettiklerim tak) async {
    print("takipcekeelede");
    var maps = json.encode(tak.toMap());
    print(maps.toString());
    var res = await http.post(
        "https://soryorapi.azurewebsites.net/api/takipettiklerims",
        headers: header,
        body: maps);
    print(res.statusCode.toString());
    if (res.statusCode != 200) {
      throw Exception;
    }
    return Future.value(res.statusCode == 200 ? true : false);
  }

  static Future<bool> soruekle(Soru sor) async {
    print("soruekl");
    var maps = json.encode(sor.toMap());
    print(maps.toString());
    var res = await http.post("https://soryorapi.azurewebsites.net/api/sorus",
        headers: header, body: maps);
    print(res.statusCode.toString());
    if (res.statusCode != 201) {
      throw Exception;
    }
    return Future.value(res.statusCode == 201 ? true : false);
  }

  static Future<bool> cevapekle(Cevap cevap) async {
    print("cevapekeellde");
    var maps = json.encode(cevap.toMap());
    print(maps.toString());
    var res = await http.post("https://soryorapi.azurewebsites.net/api/cevaps",
        headers: header, body: maps);
    print(res.statusCode.toString());
    if (res.statusCode != 201) {
      throw Exception;
    }
    return Future.value(res.statusCode == 201 ? true : false);
  }
}
