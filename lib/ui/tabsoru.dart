import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:like_button/like_button.dart';
import 'package:soryor/models/soru.dart';
import 'package:soryor/models/soruwithkonu.dart';
import 'package:soryor/provider/kullaniciprovider.dart';
import 'package:soryor/services/apiservices.dart';
import 'package:soryor/utils/colorloader.dart';
import 'package:soryor/utils/constans.dart';
import 'package:provider/provider.dart';
import 'package:soryor/provider/kullaniciprovider.dart';

import 'otherporfileui.dart';

class Tabsoru extends StatefulWidget {
  @override
  TabsoruState createState() => TabsoruState();
}

class TabsoruState extends State<Tabsoru> with AutomaticKeepAliveClientMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
  Future<List<Soruwithkonu>> list() async {
    print("kontrolll");
    int ku = context
        .watch<KullaniciProvider>()
        .kullanici
        .kullaniciid; //watc mu read muu
    List<Soruwithkonu> lis = await APIServices.sorualkull(ku);
    print("kontrol222");
    print(lis.toString());

    print("soonnn");

    return lis;
  }

  @override
  void initState() {
    // _loadList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: list(),
        builder: (context, projectSnap) {
          if (projectSnap.connectionState == ConnectionState.waiting) {
            return Center(child: ColorLoader3());
          } else if (projectSnap.hasError) {
            return Text("hata var internet bağlantınızı kontrol ediniz");
          } else if (projectSnap.data == null) {
            return Text("data null");
          } else if (projectSnap.hasData == null) {
            return Text("hasdata null veri yok");
          }
          return SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(children: [
              SingleChildScrollView(
                physics: ScrollPhysics(),
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: projectSnap.data.length,
                  itemBuilder: (context, index) {
                    Soruwithkonu project = projectSnap.data[index];

                    return sorucard(
                        project.sorular,
                        project.soranid,
                        project.soranad,
                        project.tarih,
                        project.begenisayisi,
                        project.dislikesayisi,
                        project.mavitik,
                        project.cevapsayisi);
                  },
                ),
              )
            ]),
          );
        });
  }

  Card sorucard(String cevaplar, int cvplynid, String cevaplayan, String tar,
      int begen, int disl, int mavitik, int cevapsayisi) {
    var saat = DateFormat.jm('tr_TR').format(DateTime.parse(tar));
    var yil = DateFormat.yMMMEd('tr_TR').format(DateTime.parse(tar));
    var tarih = yil + "-" + saat;
    return Card(
        elevation: 10,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
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
              child:
                  Align(alignment: Alignment.bottomLeft, child: Text(cevaplar)),
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
                  Text("$cevapsayisi Cevap"),
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
            )
          ],
        ));
    //  );
  }
}
