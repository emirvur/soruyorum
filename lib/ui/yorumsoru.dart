import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:like_button/like_button.dart';
import 'package:soryor/ui/toplulukanasyf.dart';
import 'package:soryor/models/favorilerim.dart';
import 'package:soryor/models/yorum.dart';
import 'package:soryor/models/yorumdto.dart';
import 'package:soryor/provider/kullaniciprovider.dart';
import 'package:soryor/services/apiservices.dart';
import 'package:provider/provider.dart';
import 'package:soryor/ui/otherporfileui.dart';
import 'package:soryor/models/soruwithkonu.dart';
import 'package:soryor/ui/sorununcevabiui.dart';

class Yorumsoru extends StatefulWidget {
  final int x;
  final Soruwithkonu sor;
  Yorumsoru({this.x, this.sor});
  @override
  _YorumsoruState createState() => _YorumsoruState();
}

class _YorumsoruState extends State<Yorumsoru> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController cont;
  Future<List<Dtoyorum>> soruyorum(BuildContext context) async {
    print("kontrolll");

    List<Dtoyorum> lis = await APIServices.yorumsorual(1);
    print(lis[0].yorum);
    print("kontrol222");
    print(lis.toString());

    //print("soonnn");

    return lis;
  }

  @override
  void initState() {
    // _loadList();
    super.initState();
    cont = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    cont.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.x.toString());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.blueAccent,
          ),
        ),
        /*  title: Center(
          child: Text(
            "Popüler Kanallar",
            style: TextStyle(
                color: Colors.black,
                fontFamily: 'Avenir',
                fontSize: 24,
                fontWeight: FontWeight.bold),
          ),
        ),*/
      ),
      body: FutureBuilder(
          future: soruyorum(context),
          builder: (context, projectSnap) {
            if (projectSnap.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (projectSnap.hasError) {
              return Text("hata var internet bağlantınızı kontrol ediniz");
            } else if (projectSnap.data == null) {
              return Text("data null");
            } else if (projectSnap.hasData == null) {
              return Text("hasdata null veri yok");
            }
            return Column(
              children: [
                sorucard(
                    widget.sor.altkonuid,
                    widget.sor.sorular,
                    widget.sor.soranid,
                    widget.sor.soranad,
                    widget.sor.tarih,
                    widget.sor.begenisayisi,
                    widget.sor.dislikesayisi,
                    widget.sor.mavitik,
                    widget.sor.cevapsayisi,
                    widget.sor.altkonusu,
                    widget.sor.soruid,
                    context),
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Text(
                    "${widget.sor.yorumsayisi} Yorum",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                SingleChildScrollView(
                  physics: ScrollPhysics(),
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: projectSnap.data.length,
                    itemBuilder: (context, index) {
                      Dtoyorum project = projectSnap.data[index];
                      return yorumcard(
                          project.mavitik,
                          project.ad,
                          project.yorum,
                          project.tarih,
                          project.userid,
                          context);
                    },
                  ),
                ),
                Container(
                  child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Lütfen yorumunuzu giriniz';
                                }
                                return null;
                              },
                              controller: cont,
                              style: TextStyle(
                                //fontSize: 22.0,
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                suffixIcon: GestureDetector(
                                  child: Icon(
                                    Icons.send,
                                    color: Colors.blue,
                                  ),
                                  onTap: () async {
                                    if (_formKey.currentState.validate()) {
                                      print("rrr");
                                      int cid = context
                                          .read<KullaniciProvider>()
                                          .kullanici
                                          .kullaniciid;
                                      bool c =
                                          await APIServices.gonderyorumsoru(
                                              Yorum(
                                        0,
                                        cont.text,
                                        widget.sor.soruid,
                                        0,
                                        DateTime.now().toString(),
                                        cid,
                                      ));
                                      if (c == true) {
                                        setState(() {
                                          cont.clear();
                                        });
                                      }
                                    }
                                  },
                                ),
                                hintText: 'Yorum yaz',
                                labelText: 'Yorum yaz',
                                border: OutlineInputBorder(),
                              ),
                              onSaved: (String girilen) {
                                //  comment = girilen;
                              },
                            ),
                          ),
                        ],
                      )),
                )
              ],
            );
          }),
    );
  }
}

Card sorucard(
    int altkonuid,
    String cevaplar,
    int cvplynid,
    String cevaplayan,
    String tar,
    int begen,
    int disl,
    int mavitik,
    int cevapsayisi,
    String altk,
    int sid,
    BuildContext context) {
  var saat = DateFormat.jm('tr_TR').format(DateTime.parse(tar));
  var yil = DateFormat.yMMMEd('tr_TR').format(DateTime.parse(tar));
  var tarih = yil + "-" + saat;
  return Card(
      elevation: 10,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 10.0,
                ),
                SizedBox(
                  width: 6.0,
                ),
                Column(
                  children: [
                    Align(
                        alignment: Alignment.topLeft,
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => OtherProfileui(
                                            kullanicc: cvplynid,
                                          )),
                                );
                              },
                              child: Text(
                                cevaplayan,
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                            mavitik == 1
                                ? Icon(
                                    Icons.verified_user,
                                    color: Colors.blue,
                                    size: 18,
                                  )
                                : Text("")
                          ],
                        )),
                    // Align(
                    //      alignment: Alignment.topLeft,
                    //        child: Text("21 Mayıs'ta cevaplandı"))
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Align(
                alignment: Alignment.bottomLeft,
                child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Sorucevap(
                                  soru: Soruwithkonu(
                                      sid,
                                      cevaplar,
                                      mavitik,
                                      cevapsayisi,
                                      cvplynid,
                                      begen,
                                      disl,
                                      -1,
                                      tar,
                                      altk,
                                      cevaplayan,
                                      altkonuid),
                                )),
                      );
                    },
                    child: Text(cevaplar))),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.end,
              children: [
                LikeButton(
                  onTap: (bool isLiked) async {
                    /// send your request here
                    await Future.delayed(Duration(seconds: 1));

                    /// if failed, you can do nothing
                    // return success? !isLiked:isLiked;

                    return !isLiked;
                  },
                  size: 25.0,
                  circleColor: CircleColor(
                      start: Color(0xff00ddff), end: Color(0xff0099cc)),
                  bubblesColor: BubblesColor(
                    dotPrimaryColor: Color(0xff33b5e5),
                    dotSecondaryColor: Color(0xff0099cc),
                  ),
                  likeBuilder: (bool isLiked) {
                    return Icon(
                      Icons.arrow_upward_rounded,
                      color: isLiked ? Colors.green : Colors.grey,
                      size: 25.0,
                    );
                  },
                  likeCount: begen,
                ),
                LikeButton(
                  onTap: (bool isLiked) async {
                    /// send your request here
                    await Future.delayed(Duration(seconds: 1));

                    /// if failed, you can do nothing
                    // return success? !isLiked:isLiked;

                    return !isLiked;
                  },
                  size: 25.0,
                  circleColor: CircleColor(
                      start: Color(0xff00ddff), end: Color(0xff0099cc)),
                  bubblesColor: BubblesColor(
                    dotPrimaryColor: Color(0xff33b5e5),
                    dotSecondaryColor: Color(0xff0099cc),
                  ),
                  likeBuilder: (bool isLiked) {
                    return Icon(
                      Icons.arrow_downward_rounded,
                      color: isLiked ? Colors.red : Colors.grey,
                      size: 25.0,
                    );
                  },
                  likeCount: disl,
                ),
                SizedBox(width: 8),
                LikeButton(
                  onTap: (bool isLiked) async {
                    /// send your request here
                    await Future.delayed(Duration(seconds: 1));

                    /// if failed, you can do nothing
                    // return success? !isLiked:isLiked;
                    return !isLiked;
                  },
                  size: 25.0,
                  circleColor: CircleColor(
                      start: Color(0xff00ddff), end: Color(0xff0099cc)),
                  bubblesColor: BubblesColor(
                    dotPrimaryColor: Color(0xff33b5e5),
                    dotSecondaryColor: Color(0xff0099cc),
                  ),
                  likeBuilder: (bool isLiked) {
                    return Icon(
                      Icons.favorite,
                      color: isLiked ? Colors.pink : Colors.grey,
                      size: 25.0,
                    );
                  },
                  //likeCount: 13,
                ),
                //   Text("$cevapsayisi Cevap"),
                Spacer(),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    tarih,
                    style: TextStyle(fontSize: 12.0),
                  ),
                )
              ],
            ),
          ),
          Divider(
            height: 10,
            color: Colors.black,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                  onTap: () {
                    //  Navigator.push(
                    //      context,
                    //        MaterialPageRoute(builder: (context) => Test1(x: sid)),
                    //        );
                  },
                  child: Text("$cevapsayisi Cevap")),
              SizedBox(
                width: 30,
              ),
            ],
          )
        ],
      ));
  //  );
}

Card yorumcard(
    int mavitik,
    String ad,
    //
    String yorum,
    String tar,
    int uid,
    BuildContext context) {
  return Card(
      elevation: 10,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 10.0,
                ),
                SizedBox(
                  width: 6.0,
                ),
                Column(
                  children: [
                    Align(
                        alignment: Alignment.topLeft,
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => OtherProfileui(
                                            kullanicc: uid,
                                          )),
                                );
                              },
                              child: Text(
                                ad,
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                            mavitik == 1
                                ? Icon(
                                    Icons.verified_user,
                                    color: Colors.blue,
                                    size: 18,
                                  )
                                : Text("")
                          ],
                        )),
                    // Align(
                    //      alignment: Alignment.topLeft,
                    //        child: Text("21 Mayıs'ta cevaplandı"))
                  ],
                )
              ],
            ),
          ),
          Text(yorum),
          Align(
              alignment: Alignment.bottomRight,
              child: Text(
                tar,
                style: TextStyle(fontSize: 12.0),
              ))
        ],
      ));
  //  );
}
